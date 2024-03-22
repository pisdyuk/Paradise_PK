/obj/machinery/door
	name = "door"
	desc = "It opens and closes."
	icon = 'icons/obj/doors/doorint.dmi'
	icon_state = "door1"
	anchored = TRUE
	opacity = 1
	density = TRUE
	layer = OPEN_DOOR_LAYER
	power_channel = ENVIRON
	max_integrity = 350
	armor = list("melee" = 30, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 100, "fire" = 80, "acid" = 70)
	flags = PREVENT_CLICK_UNDER
	damage_deflection = 10
	pass_flags_self = PASSDOOR
	var/closingLayer = CLOSED_DOOR_LAYER
	var/visible = 1
	/// Is it currently in the process of opening or closing.
	var/operating = NONE
	var/autoclose = 0
	/// Whether the door detects things and mobs in its way and reopen or crushes them.
	var/safe = TRUE
	// Whether the door is bolted or not.
	var/locked = FALSE
	var/glass = FALSE
	var/welded = FALSE
	var/normalspeed = TRUE
	var/auto_close_time = 150
	var/auto_close_time_dangerous = 15
	/// The type of door frame to drop during deconstruction
	var/assemblytype
	var/datum/effect_system/spark_spread/spark_system
	var/real_explosion_block	//ignore this, just use explosion_block
	var/heat_proof = FALSE // For rglass-windowed airlocks and firedoors
	var/emergency = FALSE
	/// Unrestricted sides. A bitflag for which direction (if any) can open the door with no access.
	var/unres_sides = 0
	//Multi-tile doors
	var/width = 1
	//Whether nonstandard door sounds (cmag laughter) are off cooldown.
	var/sound_ready = TRUE
	var/sound_cooldown = 1 SECONDS
	//Emag vulnerability.
	var/hackable = TRUE

/obj/machinery/door/New()
	..()
	set_init_door_layer()
	update_dir()
	update_freelook_sight()
	GLOB.airlocks += src
	spark_system = new /datum/effect_system/spark_spread
	spark_system.set_up(2, 1, src)

	//doors only block while dense though so we have to use the proc
	real_explosion_block = explosion_block
	explosion_block = EXPLOSION_BLOCK_PROC

/obj/machinery/door/proc/set_init_door_layer()
	if(density)
		layer = closingLayer
	else
		layer = initial(layer)

/obj/machinery/door/setDir(newdir)
	..()
	update_dir()


/obj/machinery/door/power_change(forced = FALSE)
	. = ..()
	if(.)
		update_icon()


/obj/machinery/door/proc/update_dir()
	if(width > 1)
		if(dir in list(EAST, WEST))
			bound_width = width * world.icon_size
			bound_height = world.icon_size
		else
			bound_width = world.icon_size
			bound_height = width * world.icon_size

/obj/machinery/door/Initialize()
	air_update_turf(1)
	..()

/obj/machinery/door/Destroy()
	density = 0
	air_update_turf(1)
	update_freelook_sight()
	GLOB.airlocks -= src
	QDEL_NULL(spark_system)
	return ..()

/obj/machinery/door/Bumped(atom/movable/moving_atom)
	..()

	if(operating || emagged)
		return
	if(ismob(moving_atom))
		var/mob/B = moving_atom
		if((isrobot(B)) && B.stat)
			return
		if(isliving(moving_atom))
			var/mob/living/M = moving_atom
			if(world.time - M.last_bumped <= 10)
				return	//Can bump-open one airlock per second. This is to prevent shock spam.
			M.last_bumped = world.time
			if(M.restrained() && !check_access(null))
				return
			if(M.mob_size > MOB_SIZE_TINY)
				bumpopen(M)
			return

	if(ismecha(moving_atom))
		var/obj/mecha/mecha = moving_atom
		if(density)
			if(mecha.occupant)
				if(world.time - mecha.occupant.last_bumped <= 10)
					return
			if(mecha.occupant && allowed(mecha.occupant) || check_access_list(mecha.operation_req_access))
				if(HAS_TRAIT(src, TRAIT_CMAGGED))
					cmag_switch(FALSE, mecha.occupant)
					return
				open()
			else
				if(HAS_TRAIT(src, TRAIT_CMAGGED))
					cmag_switch(TRUE, mecha.occupant)
					return
				do_animate("deny")
		return

/obj/machinery/door/Move(new_loc, new_dir)
	var/turf/T = loc
	. = ..()
	move_update_air(T)

	if(width > 1)
		if(dir in list(EAST, WEST))
			bound_width = width * world.icon_size
			bound_height = world.icon_size
		else
			bound_width = world.icon_size
			bound_height = width * world.icon_size


/obj/machinery/door/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(.)
		return TRUE
	// Snowflake handling for PASSGLASS.
	if(checkpass(mover, PASSGLASS))
		return !opacity


/obj/machinery/door/CanAtmosPass()
	return !density

/obj/machinery/door/proc/bumpopen(mob/user)
	if(operating)
		return
	add_fingerprint(user)

	if(density && !emagged)
		if(allowed(user))
			if(HAS_TRAIT(src, TRAIT_CMAGGED))
				cmag_switch(FALSE, user)
				return
			open()
			if(isbot(user))
				var/mob/living/simple_animal/bot/B = user
				B.door_opened(src)
		else
			if(pry_open_check(user))
				return
			if(HAS_TRAIT(src, TRAIT_CMAGGED))
				cmag_switch(TRUE, user)
				return
			do_animate("deny")


/obj/machinery/door/proc/pry_open_check(mob/user)
	. = TRUE
	if(isterrorspider(user))
		return

	if(!HAS_TRAIT(user, TRAIT_FORCE_DOORS))
		return FALSE

	var/datum/antagonist/vampire/V = user.mind?.has_antag_datum(/datum/antagonist/vampire)
	if(V && HAS_TRAIT_FROM(user, TRAIT_FORCE_DOORS, VAMPIRE_TRAIT))
		if(!V.bloodusable)
			REMOVE_TRAIT(user, TRAIT_FORCE_DOORS, VAMPIRE_TRAIT)
			return FALSE

	if(welded)
		to_chat(user, span_warning("The door is welded."))
		return FALSE

	if(locked)
		to_chat(user, span_warning("The door is bolted."))
		return FALSE

	if(density)
		visible_message(span_danger("[user] forces the door open!"))
		playsound(loc, "sparks", 100, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		open(TRUE)

	if(V && HAS_TRAIT_FROM(user, TRAIT_FORCE_DOORS, VAMPIRE_TRAIT))
		V.bloodusable = max(V.bloodusable - 5, 0)


/obj/machinery/door/attack_ai(mob/user)
	return attack_hand(user)

/obj/machinery/door/attack_ghost(mob/user)
	if(user.can_advanced_admin_interact())
		return attack_hand(user)

/obj/machinery/door/attack_hand(mob/user)
	return try_to_activate_door(user)

/obj/machinery/door/attack_tk(mob/user)
	if(!allowed(null))
		return
	..()

/obj/machinery/door/proc/try_to_activate_door(mob/user)
	add_fingerprint(user)
	if(operating || emagged)
		return
	if(requiresID() && (allowed(user) || user.can_advanced_admin_interact()))
		if(density)
			if(HAS_TRAIT(src, TRAIT_CMAGGED) && !user.can_advanced_admin_interact()) //cmag should not prevent admin intervention
				cmag_switch(FALSE, user)
				return
			open()
		else
			if(HAS_TRAIT(src, TRAIT_CMAGGED) && !user.can_advanced_admin_interact())
				return
			close()
		return TRUE
	if(HAS_TRAIT(src, TRAIT_CMAGGED))
		cmag_switch(TRUE, user)
		return
	if(density)
		do_animate("deny")

/obj/machinery/door/allowed(mob/M)
	if(emergency)
		return TRUE
	if(unrestricted_side(M))
		return TRUE
	if(!requiresID())
		return FALSE // Intentional. machinery/door/requiresID() always == 1. airlocks, however, == 0 if ID scan is disabled. Yes, this var is poorly named.
	return ..()

/obj/machinery/door/proc/unrestricted_side(mob/M) //Allows for specific side of airlocks to be unrestrected (IE, can exit maint freely, but need access to enter)
	return get_dir(src, M) & unres_sides

/obj/machinery/door/proc/try_to_crowbar(mob/user, obj/item/I)
	return

/obj/machinery/door/proc/clean_cmag_ooze(obj/item/I, mob/user) //Emags are Engineering's problem, cmags are the janitor's problem
	var/cleaning = FALSE
	if(istype(I, /obj/item/reagent_containers/spray/cleaner))
		var/obj/item/reagent_containers/spray/cleaner/C = I
		if(C.reagents.total_volume >= C.amount_per_transfer_from_this)
			cleaning = TRUE
		else
			return
	if(istype(I, /obj/item/soap))
		cleaning = TRUE

	if(!cleaning)
		return
	user.visible_message(span_notice("[user] starts to clean the ooze off the access panel."), span_notice("You start to clean the ooze off the access panel."))
	if(do_after(user, 50, target = src))
		user.visible_message(span_notice("[user] cleans the ooze off [src]."), span_notice("You clean the ooze off [src]."))
		REMOVE_TRAIT(src, TRAIT_CMAGGED, CMAGGED)

/obj/machinery/door/attackby(obj/item/I, mob/user, params)
	if(HAS_TRAIT(src, TRAIT_CMAGGED))
		clean_cmag_ooze(I, user)
	if(user.a_intent != INTENT_HARM && istype(I, /obj/item/twohanded/fireaxe))
		add_fingerprint(user)
		try_to_crowbar(user, I)
		return 1
	else if(!(I.flags & NOBLUDGEON) && user.a_intent != INTENT_HARM)
		try_to_activate_door(user)
		return 1
	return ..()


/obj/machinery/door/crowbar_act(mob/user, obj/item/I)
	if(user.a_intent == INTENT_HARM)
		return
	. = TRUE
	if(operating)
		return
	if(!I.use_tool(src, user, 0, volume = 0))
		return
	try_to_crowbar(user, I)

/obj/machinery/door/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	. = ..()
	if(. && obj_integrity > 0)
		if(damage_amount >= 10 && prob(30))
			spark_system.start()

/obj/machinery/door/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(glass)
				playsound(loc, 'sound/effects/glasshit.ogg', 90, TRUE)
			else if(damage_amount)
				playsound(loc, 'sound/weapons/smash.ogg', 50, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/machinery/door/emag_act(mob/user)
	if(!hackable)
		if(user)
			to_chat(user, span_notice("The electronic systems in this door are far too advanced for your primitive hacking peripherals."))
		return
	if(density)
		add_attack_logs(user, src, "emagged ([locked ? "bolted" : "not bolted"])")
		flick("door_spark", src)
		sleep(6)
		open()
		emagged = TRUE
		return TRUE

/obj/machinery/door/cmag_act(mob/user)
	if(!density)
		return
	flick("door_spark", src)
	sleep(6) //The cmag doesn't automatically open doors. It inverts access, not provides it!
	ADD_TRAIT(src, TRAIT_CMAGGED, CMAGGED)
	return TRUE

//Proc for inverting access on cmagged doors."canopen" should always return the OPPOSITE of the normal result.
/obj/machinery/door/proc/cmag_switch(canopen, mob/living/user)
	if(!canopen || locked || !hasPower())
		if(density) //Windoors can still do their deny animation in unpowered environments, this bugs out if density isn't checked for
			do_animate("deny")
		if(hasPower() && sound_ready)
			playsound(loc, 'sound/machines/honkbot_evil_laugh.ogg', 25, TRUE, ignore_walls = FALSE)
			soundcooldown()
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(!H.get_assignment(0, 0)) //Humans can't game inverted access by taking their ID off or using spare IDs.
			if(!density)
				return
			do_animate("deny")
			to_chat(H, span_warning("The airlock speaker chuckles: 'What's wrong, pal? Lost your ID? Nyuk nyuk nyuk!'"))
			if(sound_ready)
				playsound(loc, 'sound/machines/honkbot_evil_laugh.ogg', 25, TRUE, ignore_walls = FALSE)
				soundcooldown() //Thanks, mechs
			return
	if(density)
		open()
	else
		close()

/obj/machinery/door/proc/soundcooldown()
	if(!sound_ready)
		return
	sound_ready = FALSE
	addtimer(VARSET_CALLBACK(src, sound_ready, TRUE), sound_cooldown)


/obj/machinery/door/update_icon_state()
	icon_state = "door[density]"


/obj/machinery/door/proc/do_animate(animation)
	switch(animation)
		if("opening")
			if(panel_open)
				flick("o_doorc0", src)
			else
				flick("doorc0", src)
		if("closing")
			if(panel_open)
				flick("o_doorc1", src)
			else
				flick("doorc1", src)
		if("deny")
			if(!stat)
				flick("door_deny", src)

/obj/machinery/door/proc/open()
	if(!density)
		return TRUE
	if(operating)
		return FALSE
	operating = DOOR_OPENING
	do_animate("opening")
	set_opacity(FALSE)
	sleep(0.5 SECONDS)
	density = FALSE
	sleep(0.5 SECONDS)
	layer = initial(layer)
	update_icon()
	operating = NONE
	air_update_turf(TRUE)
	update_freelook_sight()
	if(autoclose)
		autoclose_in(normalspeed ? auto_close_time : auto_close_time_dangerous)
	return TRUE


/obj/machinery/door/proc/close()
	if(density)
		return TRUE
	if(operating || welded)
		return
	if(safe)
		for(var/turf/turf in locs)
			for(var/atom/movable/M in turf)
				if(M.density && M != src) //something is blocking the door
					if(autoclose)
						autoclose_in(6 SECONDS)
					return

	operating = DOOR_CLOSING

	do_animate("closing")
	layer = closingLayer
	sleep(0.5 SECONDS)
	density = TRUE
	sleep(0.5 SECONDS)
	update_icon()
	if(visible && !glass)
		set_opacity(TRUE)
	operating = NONE
	air_update_turf(TRUE)
	update_freelook_sight()
	if(safe)
		CheckForMobs()
	else
		crush()
	return TRUE


/obj/machinery/door/proc/CheckForMobs()
	if(locate(/mob/living) in get_turf(src))
		sleep(1)
		open()

/obj/machinery/door/proc/crush()
	for(var/mob/living/L in get_turf(src))
		L.visible_message(span_warning("[src] closes on [L], crushing [L.p_them()]!"), span_userdanger("[src] closes on you and crushes you!"))
		if(isalien(L))  //For xenos
			L.adjustBruteLoss(DOOR_CRUSH_DAMAGE * 1.5) //Xenos go into crit after aproximately the same amount of crushes as humans.
			L.emote("roar")
		else if(ishuman(L)) //For humans
			L.adjustBruteLoss(DOOR_CRUSH_DAMAGE)
			if(L.stat == CONSCIOUS)
				L.emote("scream")
			L.Weaken(10 SECONDS)
		else //for simple_animals & borgs
			L.adjustBruteLoss(DOOR_CRUSH_DAMAGE)
		var/turf/location = get_turf(src)
		L.add_splatter_floor(location)
	for(var/obj/mecha/M in get_turf(src))
		M.take_damage(DOOR_CRUSH_DAMAGE)

/obj/machinery/door/proc/requiresID()
	return 1

/obj/machinery/door/proc/hasPower()
	return !(stat & NOPOWER)

/obj/machinery/door/proc/autoclose()
	if(!QDELETED(src) && !density && !operating && !locked && !welded && autoclose)
		close()

/obj/machinery/door/proc/autoclose_in(wait)
	addtimer(CALLBACK(src, PROC_REF(autoclose)), wait, TIMER_UNIQUE | TIMER_NO_HASH_WAIT | TIMER_OVERRIDE)

/obj/machinery/door/proc/update_freelook_sight()
	if(!glass && GLOB.cameranet)
		GLOB.cameranet.updateVisibility(src, 0)

/obj/machinery/door/BlockSuperconductivity() // All non-glass airlocks block heat, this is intended.
	if(opacity || heat_proof)
		return 1
	return 0

/obj/machinery/door/morgue
	icon = 'icons/obj/doors/doormorgue.dmi'

/obj/machinery/door/proc/lock()
	return

/obj/machinery/door/proc/unlock()
	return

/obj/machinery/door/proc/hostile_lockdown(mob/origin)
	if(!stat) //So that only powered doors are closed.
		close() //Close ALL the doors!

/obj/machinery/door/proc/disable_lockdown()
	if(!stat) //Opens only powered doors.
		open() //Open everything!

/obj/machinery/door/ex_act(severity)
	//if it blows up a wall it should blow up a door
	..(severity ? max(1, severity - 1) : 0)


/obj/machinery/door/GetExplosionBlock()
	return density ? real_explosion_block : 0
