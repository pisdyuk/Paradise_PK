GLOBAL_LIST_EMPTY(closets)

/obj/structure/closet
	name = "closet"
	desc = "It's a basic storage unit."
	icon = 'icons/obj/closet.dmi'
	icon_state = "closed"
	density = TRUE
	layer = LOW_ITEM_LAYER	//Prevents items from dropping on turf visually
	max_integrity = 200
	integrity_failure = 50
	armor = list("melee" = 20, "bullet" = 10, "laser" = 10, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 60)
	pass_flags_self = PASSSTRUCTURE|LETPASSCLICKS

	/// Special marker for the closet to use default icon_closed/icon_opened states, skipping everything else.
	var/no_overlays = FALSE
	var/icon_closed = "closed" //stays here for compatibility issues
	var/icon_opened = "open"

	//following overlays are used by default for states, override if necessary
	var/overlay_sparking = "sparking"
	var/overlay_unlocked = "unlocked"
	var/overlay_locked = "locked"
	var/overlay_locker = "locker"
	var/custom_door_overlay = null //handles overlay of door looking into screen
	var/custom_open_overlay = null //handles overlay of opened door (its inner side)

	var/ignore_density_closed = FALSE
	var/opened = FALSE
	var/welded = FALSE
	var/locked = FALSE
	var/large = TRUE
	var/can_be_emaged = FALSE
	var/wall_mounted = FALSE //never solid (You can always pass over it)
	var/lastbang
	var/open_sound = 'sound/machines/closet_open.ogg'
	var/close_sound = 'sound/machines/closet_close.ogg'
	var/list/togglelock_sound = list(
		'sound/machines/lock_1.ogg',
		'sound/machines/lock_2.ogg',
		'sound/machines/lock_3.ogg',
	)
	var/open_sound_volume = 35
	var/close_sound_volume = 50
	var/storage_capacity = 30 //This is so that someone can't pack hundreds of items in a locker/crate then open it in a populated area to crash clients.
	var/material_drop = /obj/item/stack/sheet/metal
	var/material_drop_amount = 2

// Please dont override this unless you absolutely have to
/obj/structure/closet/Initialize(mapload)
	. = ..()
	GLOB.closets += src
	if(mapload && !opened)
		// Youre probably asking, why is this a 0 seconds timer AA?
		// Well, I will tell you. One day, all /obj/effect/spawner will use Initialize
		// This includes maint loot spawners. The problem with that is if a closet loads before a spawner,
		// the loot will just be in a pile. Adding a timer with 0 delay will cause it to only take in contents once the MC has loaded,
		// therefore solving the issue on mapload. During rounds, everything will happen as normal
		addtimer(CALLBACK(src, PROC_REF(take_contents)), 0)
	update_icon() // Set it to the right icon if needed
	populate_contents() // Spawn all its stuff

// Override this to spawn your things in. This lets you use probabilities, and also doesnt cause init overrides
/obj/structure/closet/proc/populate_contents()
	return

// This is called on Initialize to add contents on the tile
/obj/structure/closet/proc/take_contents()
	var/itemcount = 0
	for(var/obj/item/I in loc)
		if(I.density || I.anchored || I == src)
			continue
		I.forceMove(src)
		// Ensure the storage cap is respected
		if(++itemcount >= storage_capacity)
			break

// Fix for #383 - C4 deleting fridges with corpses
/obj/structure/closet/Destroy()
	GLOB.closets -= src
	dump_contents()
	return ..()


/obj/structure/closet/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(wall_mounted)
		return TRUE


/obj/structure/closet/proc/can_open()
	if(welded)
		return FALSE
	return TRUE

/obj/structure/closet/proc/can_close()
	for(var/obj/structure/closet/closet in get_turf(src))
		if(closet != src && closet.anchored != 1)
			return FALSE

	return TRUE

/obj/structure/closet/proc/dump_contents()
	var/atom/L = drop_location()
	for(var/atom/movable/AM in src)
		AM.forceMove(L)
		if(throwing) // you keep some momentum when getting out of a thrown closet
			step(AM, dir)
	if(throwing)
		throwing.finalize()

/obj/structure/closet/proc/open()
	if(opened || !can_open())
		return FALSE

	dump_contents()

	opened = TRUE
	update_icon()
	if(open_sound)
		playsound(loc, open_sound, open_sound_volume, TRUE, -3)
	else
		playsound(loc, 'sound/machines/click.ogg', open_sound_volume, TRUE, -3)
	density = FALSE
	after_open()
	return TRUE

///Proc to override for effects after opening a door
/obj/structure/closet/proc/after_open(mob/living/user, force = FALSE)
	return

/obj/structure/closet/proc/close()
	if(!opened || !can_close())
		return FALSE

	var/itemcount = 0

	//Cham Projector Exception
	for(var/obj/effect/dummy/chameleon/AD in loc)
		if(itemcount >= storage_capacity)
			break
		AD.forceMove(src)
		itemcount++

	for(var/obj/item/I in loc)
		if(itemcount >= storage_capacity)
			break
		if(!I.anchored)
			I.forceMove(src)
			itemcount++

	for(var/mob/M in loc)
		if(itemcount >= storage_capacity)
			break
		if(istype(M, /mob/dead/observer))
			continue
		if(istype(M, /mob/living/simple_animal/bot/mulebot))
			continue
		if(istype(M, /mob/living/simple_animal/hostile/megafauna))
			continue
		if(M.buckled || M.anchored || M.has_buckled_mobs())
			continue
		if(isAI(M))
			continue

		M.forceMove(src)
		itemcount++

	opened = FALSE
	update_icon()
	if(close_sound)
		playsound(loc, close_sound, close_sound_volume, TRUE, -3)
	else
		playsound(loc, 'sound/machines/click.ogg', close_sound_volume, TRUE, -3)
	density = ignore_density_closed ? FALSE : TRUE
	return TRUE

/obj/structure/closet/proc/toggle(mob/user)
	. = TRUE
	if(!(opened ? close() : open()))
		. = FALSE
		to_chat(user, span_notice("It won't budge!"))

/obj/structure/closet/proc/bust_open()
	welded = FALSE //applies to all lockers
	locked = FALSE //applies to critter crates and secure lockers only
	broken = TRUE //applies to secure lockers only
	open()

/obj/structure/closet/deconstruct(disassembled = TRUE)
	if(ispath(material_drop) && material_drop_amount && !(flags & NODECONSTRUCT))
		new material_drop(loc, material_drop_amount)
	qdel(src)

/obj/structure/closet/obj_break(damage_flag)
	if(!broken && !(flags & NODECONSTRUCT))
		bust_open()

/obj/structure/closet/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/rcs) && !opened)
		var/obj/item/rcs/E = W
		if(E.try_send_container(user, src))
			add_fingerprint(user)
		return

	if(opened)
		if(istype(W, /obj/item/grab))
			var/obj/item/grab/G = W
			if(large)
				MouseDrop_T(G.affecting, user)      //act like they were dragged onto the closet
			else
				to_chat(user, "<span class='notice'>[src] is too small to stuff [G.affecting] into!</span>")
		if(istype(W, /obj/item/tk_grab))
			return FALSE
		if(user.a_intent != INTENT_HELP) // Stops you from putting your baton in the closet on accident
			return
		if(isrobot(user))
			return
		if(!user.transfer_item_to_loc(W, src.loc)) //couldn't drop the item
			to_chat(user, "<span class='notice'>\The [W] is stuck to your hand, you cannot put it in \the [src]!</span>")
			return
		if(W)
			add_fingerprint(user)
			return TRUE // It's resolved. No afterattack needed. Stops you from emagging lockers when putting in an emag
	else if(can_be_emaged && (istype(W, /obj/item/card/emag) || istype(W, /obj/item/melee/energy/blade) && !broken))
		add_fingerprint(user)
		emag_act(user)
	else if(istype(W, /obj/item/stack/packageWrap))
		return
	else if(user.a_intent != INTENT_HARM)
		closed_item_click(user)
	else
		return ..()

// What happens when the closet is attacked by a random item not on harm mode
/obj/structure/closet/proc/closed_item_click(mob/user)
	attack_hand(user)

/obj/structure/closet/welder_act(mob/user, obj/item/I)
	. = TRUE
	if(!opened && user.loc == src)
		to_chat(user, "<span class='warning'>You can't weld [src] from inside!</span>")
		return
	if(!I.tool_use_check(user, 0))
		return
	if(opened)
		WELDER_ATTEMPT_SLICING_MESSAGE
		if(I.use_tool(src, user, 40, volume = I.tool_volume))
			WELDER_SLICING_SUCCESS_MESSAGE
			deconstruct(TRUE)
			return
	else
		var/adjective = welded ? "open" : "shut"
		user.visible_message("<span class='notice'>[user] begins welding [src] [adjective]...</span>", "<span class='notice'>You begin welding [src] [adjective]...</span>", "<span class='warning'>You hear welding.</span>")
		if(I.use_tool(src, user, 15, volume = I.tool_volume))
			if(opened)
				to_chat(user, "<span class='notice'>Keep [src] shut while doing that!</span>")
				return
			user.visible_message("<span class='notice'>[user] welds [src] [adjective]!</span>", "<span class='notice'>You weld [src] [adjective]!</span>")
			welded = !welded
			update_icon()


/obj/structure/closet/MouseDrop_T(atom/movable/O, mob/living/user, params)
	. = ..()
	if(istype(O, /obj/screen))	//fix for HUD elements making their way into the world	-Pete
		return
	if(O.loc == user)
		return
	if(user.restrained() || user.stat || user.IsWeakened() || user.IsStunned() || user.IsParalyzed() || user.lying)
		return
	if((!( istype(O, /atom/movable) ) || O.anchored || get_dist(user, src) > 1 || get_dist(user, O) > 1 || user.contents.Find(src)))
		return
	if(user.loc==null) // just in case someone manages to get a closet into the blue light dimension, as unlikely as that seems
		return
	if(!istype(user.loc, /turf)) // are you in a container/closet/pod/etc?
		return
	if(!opened)
		return
	if(istype(O, /obj/structure/closet))
		return
	step_towards(O, loc)
	if(user != O)
		user.visible_message("<span class='danger'>[user] stuffs [O] into [src]!</span>", "<span class='danger'>You stuff [O] into [src]!</span>")
	add_fingerprint(user)
	return TRUE

/obj/structure/closet/attack_ai(mob/user)
	if(isrobot(user) && Adjacent(user)) //Robots can open/close it, but not the AI
		attack_hand(user)

/obj/structure/closet/relaymove(mob/user)
	if(user.stat || !isturf(loc))
		return

	if(!open())
		to_chat(user, "<span class='notice'>It won't budge!</span>")
		if(!lastbang)
			lastbang = 1
			for(var/mob/M in hearers(src, null))
				to_chat(M, text("<FONT size=[]>BANG, bang!</FONT>", max(0, 5 - get_dist(src, M))))
			spawn(30)
				lastbang = 0

/obj/structure/closet/attack_hand(mob/user)
	add_fingerprint(user)
	toggle(user)

/obj/structure/closet/attack_ghost(mob/user)
	if(user.can_advanced_admin_interact())
		toggle(user)

// tk grab then use on self
/obj/structure/closet/attack_self_tk(mob/user)
	add_fingerprint(user)
	toggle()

/obj/structure/closet/verb/verb_toggleopen()
	set src in oview(1)
	set category = null
	set name = "Toggle Open"

	if(usr.incapacitated())
		return

	if(ishuman(usr) || isrobot(usr) || istype(usr, /mob/living/simple_animal/hostile/gorilla))
		add_fingerprint(usr)
		toggle(usr)
	else
		to_chat(usr, "<span class='warning'>This mob type can't use this verb.</span>")


/obj/structure/closet/update_icon(updates = ALL)
	if(no_overlays)
		return ..(UPDATE_ICON_STATE)
	return ..()


/obj/structure/closet/update_icon_state()
	if(no_overlays)
		icon_state = opened ? icon_opened : icon_closed


/obj/structure/closet/update_overlays()
	. = ..()
	if(opened)
		if(custom_open_overlay)
			. += "[custom_open_overlay]_open"
		else
			. += "[icon_state]_open"
	else
		for(var/olay in apply_contents_overlays())
			. += olay
		if(custom_door_overlay)
			. += "[custom_door_overlay]_door"
		else
			. += "[icon_state]_door"	//No initials because of custom map-made closets.
		if(welded)
			. += "welded"


/**
 * Additional overlays for contents inside the closet. Usefull when the door is transparent.
 */
/obj/structure/closet/proc/apply_contents_overlays()
	RETURN_TYPE(/list)
	. = list()


// Objects that try to exit a locker by stepping were doing so successfully,
// and due to an oversight in turf/Enter() were going through walls.  That
// should be independently resolved, but this is also an interesting twist.
/obj/structure/closet/Exit(atom/movable/AM)
	open()
	if(AM.loc == src)
		return FALSE
	return TRUE

/obj/structure/closet/container_resist(var/mob/living/L)
	var/breakout_time = 2 //2 minutes by default
	if(opened)
		if(L.loc == src)
			L.forceMove(get_turf(src)) // Let's just be safe here
		return //Door's open... wait, why are you in it's contents then?
	if(!welded)
		if(isobj(loc))
			var/obj/loc_as_obj = loc
			loc_as_obj.container_resist(L)
			return
		open() //for cardboard boxes
		return //closed but not welded...
	//	else Meh, lets just keep it at 2 minutes for now
	//		breakout_time++ //Harder to get out of welded lockers than locked lockers

	//okay, so the closet is either welded or locked... resist!!!
	to_chat(L, "<span class='warning'>You lean on the back of \the [src] and start pushing the door open. (this will take about [breakout_time] minutes)</span>")
	for(var/mob/O in viewers(usr.loc))
		O.show_message("<span class='danger'>The [src] begins to shake violently!</span>", 1)


	spawn(0)
		if(do_after(L,(breakout_time*60*10), target = src)) //minutes * 60seconds * 10deciseconds
			if(!src || !L || L.stat != CONSCIOUS || L.loc != src || opened) //closet/user destroyed OR user dead/unconcious OR user no longer in closet OR closet opened
				return

			//Perform the same set of checks as above for weld and lock status to determine if there is even still a point in 'resisting'...
			if(!welded)
				return

			//Well then break it!
			welded = FALSE
			update_icon()
			to_chat(usr, "<span class='warning'>You successfully break out!</span>")
			for(var/mob/O in viewers(L.loc))
				O.show_message("<span class='danger'>\the [usr] successfully broke out of \the [src]!</span>", 1)
			if(istype(loc, /obj/structure/bigDelivery)) //nullspace ect.. read the comment above
				var/obj/structure/bigDelivery/BD = loc
				BD.attack_hand(usr)
			if(isobj(loc))
				var/obj/loc_as_obj = loc
				loc_as_obj.container_resist(L)
			open()

/obj/structure/closet/tesla_act(var/power)
	..()
	visible_message("<span class='danger'>[src] is blown apart by the bolt of electricity!</span>", "<span class='danger'>You hear a metallic screeching sound.</span>")
	qdel(src)

/obj/structure/closet/get_remote_view_fullscreens(mob/user)
	if(user.stat == DEAD || !(user.sight & (SEEOBJS|SEEMOBS)))
		user.overlay_fullscreen("remote_view", /obj/screen/fullscreen/impaired, 1)

/obj/structure/closet/ex_act(severity)
	for(var/atom/A in contents)
		A.ex_act(severity)
		CHECK_TICK
	..()

/obj/structure/closet/singularity_act()
	dump_contents()
	..()

/obj/structure/closet/AllowDrop()
	return TRUE

/obj/structure/closet/force_eject_occupant(mob/target)
	// Its okay to silently teleport mobs out of lockers, since the only thing affected is their contents list.
	return


/obj/structure/closet/AltClick(mob/living/simple_animal/hostile/gorilla/gorilla)
	if(istype(gorilla) && in_range(gorilla, src))
		gorilla.face_atom(src)
		toggle()
		gorilla.oogaooga()
	return ..()


/obj/structure/closet/bluespace
	name = "bluespace closet"
	desc = "A storage unit that moves and stores through the fourth dimension."
	density = 0
	icon_state = "bluespace"
	storage_capacity = 60
	var/materials = list(MAT_METAL = 5000, MAT_PLASMA = 2500, MAT_TITANIUM = 500, MAT_BLUESPACE = 500)
	var/transparent = FALSE


/obj/structure/closet/bluespace/proc/UpdateTransparency(atom/movable/AM, atom/location)
	var/transparency = FALSE
	for(var/atom/A in location)
		if(A.density && A != src && A != AM)
			transparency = TRUE
			break
	transparent = transparency
	update_icon()


/obj/structure/closet/bluespace/update_icon_state()
	icon_state = "[initial(icon_state)][transparent ? "_trans" : ""]"


/obj/structure/closet/bluespace/update_overlays()
	. = list()
	if(!opened)
		if(transparent)
			. += "[initial(icon_state)]_door_trans"
		else
			. += "[initial(icon_state)]_door"
		if(welded)
			. += "welded"
	else
		if(transparent)
			. += "[initial(icon_state)]_open_trans"
		else
			. += "[initial(icon_state)]_open"


/obj/structure/closet/bluespace/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(AM.density)
		transparent = TRUE
		update_icon()


/obj/structure/closet/bluespace/Uncrossed(atom/movable/mover)
	. = ..()
	UpdateTransparency(mover, loc)


/obj/structure/closet/bluespace/Move(NewLoc, direct) // Allows for "phasing" throug objects but doesn't allow you to stuff your EOC homebois in one of these and push them through walls.
	var/turf/T = get_turf(NewLoc)
	if(T.density)
		return
	for(var/atom/A in T.contents)
		if(A.density && istype(A, /obj/machinery/door))
			return
	UpdateTransparency(src, NewLoc)
	forceMove(NewLoc)

/obj/structure/closet/bluespace/close()
	. = ..()
	density = 0
