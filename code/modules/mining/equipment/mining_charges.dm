/****************Mining Charges****************/
/obj/item/grenade/plastic/miningcharge
	name = "industrial mining charge"
	desc = "Used to make big holes in rocks. Only works on rocks!"
	icon = 'icons/obj/mining.dmi'
	icon_state = "mining-charge-2"
	item_state = "charge_indust"
	det_time = 5 SECONDS
	notify_admins = FALSE // no need to make adminlogs on lavaland, while they are "safe" to use
	var/timer_off = FALSE
	var/installed = FALSE
	var/smoke_amount = 3
	var/boom_sizes = list(2,3,5)
	var/hacked = FALSE

/obj/item/grenade/plastic/miningcharge/examine(mob/user)
	. = ..()
	if(hacked)
		. += "Its wiring is haphazardly changed."
	if(timer_off)
		. += "<span class='notice'>The mining charge is connected to a detonator.</span>"

/obj/item/grenade/plastic/miningcharge/Initialize()
	. = ..()
	image_overlay = mutable_appearance(icon, "[icon_state]_active", ON_EDGED_TURF_LAYER)

/obj/item/grenade/plastic/miningcharge/attack_self(mob/user)
	if(nadeassembly)
		nadeassembly.attack_self(user)

/obj/item/grenade/plastic/miningcharge/afterattack(atom/movable/AM, mob/user, flag)
	if(ismineralturf(AM) || hacked)
		if(isancientturf(AM) && !hacked)
			visible_message("<span class='notice'>This rock appears to be resistant to all mining tools except pickaxes!</span>")
			return
		if(timer_off) //override original proc for plastic explosions
			if(!flag)
				return
			if(istype(AM, /mob/living/carbon))
				return
			to_chat(user, "<span class='notice'>You start planting the [src].</span>")
			if(do_after(user, 25 * toolspeed * gettoolspeedmod(user), target = AM))
				if(!user.drop_item_ground(src))
					return
				src.target = AM
				loc = null
				if(hacked)
					message_admins("[ADMIN_LOOKUPFLW(user)] planted [src.name] on [target.name] at [ADMIN_COORDJMP(target)]")
					add_game_logs("planted [name] on [target.name] at [COORD(target)]", user)
				installed = TRUE
				target.add_overlay(image_overlay)
			return
		..()

/obj/item/grenade/plastic/miningcharge/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/detonator))
		var/obj/item/detonator/detonator = I
		if(!(src in detonator.bombs) && !timer_off)
			detonator.bombs += src
			timer_off = TRUE
			to_chat(user, span_notice("You synchronized [src] to a detonator."))
			playsound(src, 'sound/machines/twobeep.ogg', 50)
		else
			to_chat(user, span_warning("[src] was already synchronized to a existing detonator!"))
		detonator.update_icon()
	..()

/obj/item/grenade/plastic/miningcharge/proc/detonate()
	addtimer(CALLBACK(src, PROC_REF(prime)), 3 SECONDS)

/obj/item/grenade/plastic/miningcharge/prime()
	if(hacked) //explosion
		explode()
		return
	var/turf/simulated/mineral/location = get_turf(target)
	var/datum/effect_system/smoke_spread/S = new
	S.set_up(smoke_amount,0,location,null)
	S.start()
	//location.attempt_drill(null,TRUE,3) //orange says it doesnt include the actual middle
	for(var/turf/simulated/mineral/rock in circlerangeturfs(location, boom_sizes[3]))
		var/distance = get_dist_euclidian(location,rock)
		if(distance <= boom_sizes[1])
			rock.attempt_drill(null,TRUE,3)
		else if (distance <= boom_sizes[2])
			rock.attempt_drill(null,TRUE,2)
		else if (distance <= boom_sizes[3])
			rock.attempt_drill(null,TRUE,1)

	for(var/mob/living/carbon/C in circlerange(location,boom_sizes[3]))
		if(ishuman(C)) //working on everyone
			var/distance = get_dist_euclidian(location,C)
			C.flash_eyes()
			C.Weaken((boom_sizes[2] - distance) * 1 SECONDS) //1 second for how close you are to center if you're in range
			C.AdjustDeaf((boom_sizes[3] - distance) * 10 SECONDS)
			var/obj/item/organ/internal/ears/ears = C.get_int_organ(/obj/item/organ/internal/ears)
			if(istype(ears))
				ears.receive_damage((boom_sizes[3] - distance) * 2) //something like that i guess. Mega charge makes 12 damage to ears if nearby
			to_chat(C, span_warning("<font size='2'><b>You are knocked down by the power of the mining charge!</font></b>"))
	qdel(src)

/obj/item/grenade/plastic/miningcharge/proc/explode() //c4 code
	var/turf/location
	if(target)
		if(!QDELETED(target))
			if(istype(target, /turf/))
				location = get_turf(target)
			else
				location = get_atom_on_turf(target)
			target.cut_overlay(image_overlay)
	else
		location = get_atom_on_turf(src)
	if(location)
		explosion(location, boom_sizes[1], boom_sizes[2], boom_sizes[3], cause = src)
		location.ex_act(2, target)
	if(istype(target, /mob))
		var/mob/M = target
		M.gib()
	qdel(src)


/obj/item/grenade/plastic/miningcharge/proc/override_safety()
	hacked = TRUE
	notify_admins = TRUE
	boom_sizes[1] = round(boom_sizes[1]/3)	//lesser - 0, normal - 0, mega - 1; c4 - 0
	boom_sizes[2] = round(boom_sizes[2]/3)	//lesser - 0, normal - 1, mega - 2; c4 - 0
	boom_sizes[3] = round(boom_sizes[3]/1.5)//lesser - 2, normal - 3, mega - 5; c4 - 3

/obj/item/grenade/plastic/miningcharge/deconstruct(disassembled = TRUE) //no gibbing a miner with pda bombs
	if(!QDELETED(src))
		qdel(src)

/obj/item/grenade/plastic/miningcharge/lesser
	name = "mining charge"
	desc = "A mining charge. This one seems less powerful than industrial. Only works on rocks!"
	icon_state = "mining-charge-1"
	item_state = "charge_lesser"
	smoke_amount = 1
	boom_sizes = list(1,2,3)

/obj/item/grenade/plastic/miningcharge/mega
	name = "experimental mining charge"
	desc = "A mining charge. This one seems much more powerful than normal!"
	icon_state = "mining-charge-3"
	item_state = "charge_mega"
	smoke_amount = 5
	boom_sizes = list(4,6,8) //did you see the price? It has to be better..

/obj/item/storage/backpack/duffel/miningcharges/populate_contents()
	for(var/i in 1 to 5)
		new /obj/item/grenade/plastic/miningcharge/lesser(src)
	for(var/i in 1 to 3)
		new /obj/item/grenade/plastic/miningcharge(src)
	new /obj/item/detonator(src)


//MINING CHARGE HACKER
/obj/item/t_scanner/adv_mining_scanner/syndicate
	var/charges = 6
	description_antag = "This scanner has an extra port for overriding mining charge safeties."

/obj/item/t_scanner/adv_mining_scanner/syndicate/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(istype(target,/obj/item/grenade/plastic/miningcharge))
		var/obj/item/grenade/plastic/miningcharge/charge = target
		if(charge.hacked)
			to_chat(user, span_notice("[src] is already overridden!"))
			return
		if(charges <= 0)
			to_chat(user, span_notice("Its overriding function is depleted."))
			return
		charge.override_safety()
		visible_message(span_warning("Sparks fly out of [src]!"), span_notice("You override [src], disabling its safeties."))
		playsound(src, "sparks", 50, 1)
		charges--
		if(charges <= 0)
			to_chat(user ,span_warning("[src]'s internal battery for overriding mining charges has run dry!"))

// MINING CHARGES DETONATOR

/obj/item/detonator
	name = "mining charge detonator"
	desc = "A specialized mining device designed for controlled demolition operations using mining explosives."
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/mining.dmi'
	icon_state = "Detonator-0"
	var/list/bombs = list()

/obj/item/detonator/examine(mob/user)
	. = ..()
	if(bombs.len)
		. += "<span class='notice'>List of synched bombs:</span>"
		for(var/obj/item/grenade/plastic/miningcharge/charge in bombs)
			. += "<span class='notice'>[bicon(charge)] [charge]. Current status: [charge.installed ? "ready to detonate" : "ready to deploy"]."


/obj/item/detonator/update_icon_state()
	if(length(bombs))
		icon_state = "Detonator-1"
	else
		icon_state = initial(icon_state)


/obj/item/detonator/attack_self(mob/user)
	playsound(src, 'sound/items/detonator.ogg', 40)
	if(bombs.len)
		to_chat(user, span_notice("Activating explosives..."))
		for(var/obj/item/grenade/plastic/miningcharge/charge in bombs)
			if(QDELETED(charge))
				to_chat(user, span_notice("Can't reach [charge]. Deleting from the list..."))
				bombs -= charge
				return
			if(charge.installed)
				bombs -= charge
				charge.detonate()
	else
		to_chat(user, span_warning("There is no charges linked to a detonator!"))
	update_icon(UPDATE_ICON_STATE)
	. = ..()
