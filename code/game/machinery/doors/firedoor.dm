#define CONSTRUCTION_COMPLETE 0 //No construction done - functioning as normal
#define CONSTRUCTION_PANEL_OPEN 1 //Maintenance panel is open, still functioning
#define CONSTRUCTION_WIRES_EXPOSED 2 //Cover plate is removed, wires are available
#define CONSTRUCTION_GUTTED 3 //Wires are removed, circuit ready to remove
#define CONSTRUCTION_NOCIRCUIT 4 //Circuit board removed, can safely weld apart

/obj/machinery/door/firedoor
	name = "firelock"
	desc = "A convenable firelock. Equipped with a manual lever for operating in case of emergency."
	icon = 'icons/obj/doors/doorfireglass.dmi'
	icon_state = "door_open"
	opacity = 0
	density = FALSE
	max_integrity = 300
	resistance_flags = FIRE_PROOF
	heat_proof = TRUE
	glass = TRUE
	explosion_block = 1
	safe = FALSE
	layer = BELOW_OPEN_DOOR_LAYER
	closingLayer = CLOSED_FIREDOOR_LAYER
	blocks_emissive = EMISSIVE_BLOCK_GENERIC
	auto_close_time = 5 SECONDS
	assemblytype = /obj/structure/firelock_frame
	armor = list("melee" = 30, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 100, "fire" = 95, "acid" = 70)
	/// How long does opening by hand take, in deciseconds.
	var/manual_open_time = 5 SECONDS
	var/can_crush = TRUE
	var/nextstate = null
	/// Whether the "bolts" are "screwed". Used for deconstruction sequence. Has nothing to do with airlock bolting.
	var/boltslocked = TRUE
	var/active_alarm = FALSE
	var/list/affecting_areas

/obj/machinery/door/firedoor/Initialize(mapload)
	. = ..()
	CalculateAffectingAreas()

/obj/machinery/door/firedoor/examine(mob/user)
	. = ..()
	if(!density)
		. += span_notice("It is open, but could be <b>pried</b> closed.")
	else if(!welded)
		. += span_notice("It is closed, but could be <i>pried</i> open. Deconstruction would require it to be <b>welded</b> shut.")
	else if(boltslocked)
		. += span_notice("It is <i>welded</i> shut. The floor bolts have been locked by <b>screws</b>.")
	else
		. += span_notice("The bolt locks have been <i>unscrewed</i>, but the bolts themselves are still <b>wrenched</b> to the floor.")

/obj/machinery/door/firedoor/proc/CalculateAffectingAreas()
	remove_from_areas()
	affecting_areas = get_adjacent_open_areas(src) | get_area(src)
	for(var/I in affecting_areas)
		var/area/A = I
		LAZYADD(A.firedoors, src)

/obj/machinery/door/firedoor/closed
	icon_state = "door_closed"
	opacity = TRUE
	density = TRUE

//see also turf/AfterChange for adjacency shennanigans

/obj/machinery/door/firedoor/proc/remove_from_areas()
	if(affecting_areas)
		for(var/I in affecting_areas)
			var/area/A = I
			LAZYREMOVE(A.firedoors, src)

/obj/machinery/door/firedoor/Destroy()
	remove_from_areas()
	affecting_areas.Cut()
	return ..()

/obj/machinery/door/firedoor/Bumped(atom/movable/moving_atom)
	if(panel_open || operating)
		SEND_SIGNAL(src, COMSIG_ATOM_BUMPED, moving_atom)
		return
	if(!density)
		return ..()
	return 0


/obj/machinery/door/firedoor/proc/adjust_light()
	if(stat & (NOPOWER|BROKEN))
		set_light(0)
		return
	if(active_alarm)
		set_light(1, 0.5, COLOR_RED_LIGHT)
	else
		set_light(1, LIGHTING_MINIMUM_POWER)

/obj/machinery/door/firedoor/extinguish_light(force = FALSE)
	set_light(0)
	update_icon(UPDATE_OVERLAYS)


/obj/machinery/door/firedoor/power_change(forced = FALSE)
	. = ..()
	if(!(stat & NOPOWER))
		latetoggle()
	if(!.)
		return
	adjust_light()
	update_icon()


/obj/machinery/door/firedoor/attack_hand(mob/user)
	if(user.a_intent == INTENT_HARM && ishuman(user) && user.dna.species.obj_damage)
		add_fingerprint(user)
		user.changeNext_move(CLICK_CD_MELEE)
		attack_generic(user, user.dna.species.obj_damage)
		return
	if(operating || !density)
		return

	if(welded)
		to_chat(user, span_warning("[src] is welded shut!"))
		return

	user.changeNext_move(CLICK_CD_MELEE)

	user.visible_message(
		span_notice("[user] tries to open [src] manually."),
		span_notice("You operate the manual lever on [src]."))

	if(do_after(user, manual_open_time, target = src))
		add_fingerprint(user)
		user.visible_message(
			span_notice("[user] opens [src]."),
			span_notice("You open [src]."))
		open(auto_close = FALSE)

/obj/machinery/door/firedoor/attackby(obj/item/C, mob/user, params)
	if(operating)
		add_fingerprint(user)
		return
	return ..()

/obj/machinery/door/firedoor/try_to_activate_door(mob/user)
	return

/obj/machinery/door/firedoor/screwdriver_act(mob/user, obj/item/I)
	if(user.a_intent == INTENT_HARM)
		return
	if(operating || !welded)
		return
	. = TRUE
	if(!I.use_tool(src, user, 0, volume = I.tool_volume))
		return
	user.visible_message(span_notice("[user] [boltslocked ? "unlocks" : "locks"] [src]'s bolts."), \
						 span_notice("You [boltslocked ? "unlock" : "lock"] [src]'s floor bolts."))
	boltslocked = !boltslocked

/obj/machinery/door/firedoor/wrench_act(mob/user, obj/item/I)
	if(user.a_intent == INTENT_HARM)
		return
	if(operating || !welded)
		return
	. = TRUE
	if(!I.tool_use_check(user, 0))
		return
	if(boltslocked)
		to_chat(user, span_notice("There are screws locking the bolts in place!"))
		return
	user.visible_message(span_notice("[user] starts undoing [src]'s bolts..."), \
						 span_notice("You start unfastening [src]'s floor bolts..."))
	if(!I.use_tool(src, user, 50, volume = I.tool_volume) || boltslocked)
		return
	user.visible_message(span_notice("[user] unfastens [src]'s bolts."), \
							span_notice("You undo [src]'s floor bolts."))
	deconstruct(TRUE)

/obj/machinery/door/firedoor/welder_act(mob/user, obj/item/I)
	if(!density)
		return
	. = TRUE
	if(!I.tool_use_check(user, 0))
		return
	WELDER_ATTEMPT_WELD_MESSAGE
	if(!I.use_tool(src, user, 40, volume = I.tool_volume))
		return
	if(!density) //In case someone opens it while it's getting welded
		return
	WELDER_WELD_SUCCESS_MESSAGE
	welded = !welded
	update_icon(UPDATE_OVERLAYS)

/obj/machinery/door/firedoor/try_to_crowbar(obj/item/I, mob/user)
	if(welded || operating)
		return
	if(density)
		open()
	else
		close()

/obj/machinery/door/firedoor/attack_ai(mob/user)
	forcetoggle()

/obj/machinery/door/firedoor/attack_ghost(mob/user)
	if(user.can_advanced_admin_interact())
		forcetoggle(TRUE)

/obj/machinery/door/firedoor/attack_alien(mob/user)
	add_fingerprint(user)
	if(welded)
		return ..()
	open()

/obj/machinery/door/firedoor/attack_animal(mob/user)
	. = ..()
	if(istype(user, /mob/living/simple_animal/hulk))
		var/mob/living/simple_animal/hulk/H = user
		H.attack_hulk(src)

/obj/machinery/door/firedoor/do_animate(animation)
	switch(animation)
		if("opening")
			flick("door_opening", src)
			playsound(src, 'sound/machines/firedoor.ogg', 60, 1)
		if("closing")
			flick("door_closing", src)
			playsound(src, 'sound/machines/firedoor.ogg', 60, 1)


/obj/machinery/door/firedoor/update_icon_state()
	icon_state = "door_[density ? "closed" : "open"]"


/obj/machinery/door/firedoor/update_overlays()
	. = ..()
	if(welded)
		. += "welded[density ? "" : "_open"]"
	if(active_alarm && hasPower())
		if(light)
			. += emissive_appearance('icons/obj/doors/doorfire.dmi', "alarmlights_lightmask")
		. += image('icons/obj/doors/doorfire.dmi', "alarmlights")


/obj/machinery/door/firedoor/proc/activate_alarm()
	active_alarm = TRUE
	adjust_light()
	update_icon()

/obj/machinery/door/firedoor/proc/deactivate_alarm()
	active_alarm = FALSE
	if(!density)
		layer = initial(layer)
	adjust_light()
	update_icon()

/obj/machinery/door/firedoor/open(auto_close = TRUE)
	if(welded)
		return
	. = ..()
	latetoggle(auto_close)
	if(active_alarm)
		layer = closingLayer // Active firedoors take precedence and remain visible over closed airlocks.
	if(auto_close)
		autoclose = TRUE

/obj/machinery/door/firedoor/close()
	. = ..()
	latetoggle()

/obj/machinery/door/firedoor/autoclose()
	if(active_alarm)
		. = ..()

/obj/machinery/door/firedoor/proc/latetoggle(auto_close = TRUE)
	if(operating || !hasPower() || !nextstate)
		return
	if(nextstate == FD_OPEN)
		INVOKE_ASYNC(src, PROC_REF(open), auto_close)
	if(nextstate == FD_CLOSED)
		INVOKE_ASYNC(src, PROC_REF(close))
	nextstate = null

/obj/machinery/door/firedoor/proc/forcetoggle(magic = FALSE, auto_close = TRUE)
	if(!magic && (operating || !hasPower()))
		return
	if(density)
		open(auto_close)
	else
		close()

/obj/machinery/door/firedoor/deconstruct(disassembled = TRUE)
	if(!(flags & NODECONSTRUCT))
		var/obj/structure/firelock_frame/F = new assemblytype(get_turf(src))
		if(disassembled)
			F.constructionStep = CONSTRUCTION_PANEL_OPEN
		else
			F.constructionStep = CONSTRUCTION_WIRES_EXPOSED
			F.obj_integrity = F.max_integrity * 0.5
		F.update_icon(UPDATE_ICON_STATE)
	qdel(src)

/obj/machinery/door/firedoor/border_only
	icon = 'icons/obj/doors/edge_doorfire.dmi'
	flags = ON_BORDER
	can_crush = FALSE

/obj/machinery/door/firedoor/border_only/closed
	icon_state = "door_closed"
	opacity = TRUE
	density = TRUE
	pass_flags_self = PASSGLASS


/obj/machinery/door/firedoor/border_only/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(dir != border_dir)
		return TRUE


/obj/machinery/door/firedoor/border_only/CanExit(atom/movable/mover, moving_direction)
	. = ..()
	if(dir == moving_direction)
		return !density || checkpass(mover, PASSGLASS)


/obj/machinery/door/firedoor/border_only/CanAtmosPass(turf/T)
	if(get_dir(loc, T) == dir)
		return !density
	else
		return 1

/obj/machinery/door/firedoor/rcd_deconstruct_act(mob/user, obj/item/rcd/our_rcd)
	. = ..()
	if(our_rcd.checkResource(16, user))
		to_chat(user, "Deconstructing firelock...")
		playsound(get_turf(our_rcd), 'sound/machines/click.ogg', 50, 1)
		if(do_after(user, 50 * our_rcd.toolspeed * gettoolspeedmod(user), target = src))
			if(!our_rcd.useResource(16, user))
				return RCD_ACT_FAILED
			playsound(get_turf(our_rcd), our_rcd.usesound, 50, 1)
			add_attack_logs(user, src, "Deconstructed firelock with RCD")
			qdel(src)
			return RCD_ACT_SUCCESSFULL
		to_chat(user, span_warning("ERROR! Deconstruction interrupted!"))
		return RCD_ACT_FAILED
	to_chat(user, span_warning("ERROR! Not enough matter in unit to deconstruct this firelock!"))
	playsound(get_turf(our_rcd), 'sound/machines/click.ogg', 50, 1)
	return RCD_ACT_FAILED

/obj/machinery/door/firedoor/heavy
	name = "heavy firelock"
	icon = 'icons/obj/doors/doorfire.dmi'
	glass = FALSE
	opacity = 1
	explosion_block = 2
	assemblytype = /obj/structure/firelock_frame/heavy
	max_integrity = 550

/obj/item/firelock_electronics
	name = "firelock electronics"
	icon = 'icons/obj/doors/door_assembly.dmi'
	icon_state = "door_electronics"
	desc = "A circuit board used in construction of firelocks."
	w_class = WEIGHT_CLASS_SMALL
	materials = list(MAT_METAL=50, MAT_GLASS=50)
	origin_tech = "engineering=2;programming=1"
	toolspeed = 1
	usesound = 'sound/items/deconstruct.ogg'

/obj/structure/firelock_frame
	name = "firelock frame"
	desc = "A partially completed firelock."
	icon = 'icons/obj/doors/doorfire.dmi'
	icon_state = "frame1"
	anchored = FALSE
	density = TRUE
	var/constructionStep = CONSTRUCTION_NOCIRCUIT
	var/reinforced = 0

/obj/structure/firelock_frame/examine(mob/user)
	. = ..()
	switch(constructionStep)
		if(CONSTRUCTION_PANEL_OPEN)
			. += span_notice("It is <i>unbolted</i> from the floor. A small <b>loosely connected</b> metal plate is covering the wires.")
			if(!reinforced)
				. += span_notice("It could be reinforced with plasteel.")
		if(CONSTRUCTION_WIRES_EXPOSED)
			. += span_notice("The maintenance plate has been <i>pried away</i>, and <b>wires</b> are trailing.")
		if(CONSTRUCTION_GUTTED)
			. += span_notice("The maintenance panel is missing <i>wires</i> and the circuit board is <b>loosely connected</b>.")
		if(CONSTRUCTION_NOCIRCUIT)
			. += span_notice("There are no <i>firelock electronics</i> in the frame. The frame could be <b>cut</b> apart.")

/obj/structure/firelock_frame/update_icon_state()
	icon_state = "frame[constructionStep]"

/obj/structure/firelock_frame/attackby(obj/item/C, mob/user)
	switch(constructionStep)
		if(CONSTRUCTION_PANEL_OPEN)
			if(istype(C, /obj/item/stack/sheet/plasteel))
				var/obj/item/stack/sheet/plasteel/P = C
				if(reinforced)
					to_chat(user, span_warning("[src] is already reinforced."))
					return
				if(P.get_amount() < 2)
					to_chat(user, span_warning("You need more plasteel to reinforce [src]."))
					return
				user.visible_message(span_notice("[user] begins reinforcing [src]..."), \
									 span_notice("You begin reinforcing [src]..."))
				playsound(get_turf(src), C.usesound, 50, 1)
				if(do_after(user, 60 * C.toolspeed * gettoolspeedmod(user), target = src))
					if(constructionStep != CONSTRUCTION_PANEL_OPEN || reinforced || P.get_amount() < 2 || !P)
						return
					add_fingerprint(user)
					user.visible_message(span_notice("[user] reinforces [src]."), \
										 span_notice("You reinforce [src]."))
					playsound(get_turf(src), C.usesound, 50, 1)
					P.use(2)
					reinforced = 1
				return
		if(CONSTRUCTION_GUTTED)
			if(iscoil(C))
				var/obj/item/stack/cable_coil/B = C
				if(B.get_amount() < 5)
					to_chat(user, span_warning("You need more wires to add wiring to [src]."))
					return
				user.visible_message(span_notice("[user] begins wiring [src]..."), \
									 span_notice("You begin adding wires to [src]..."))
				playsound(get_turf(src), B.usesound, 50, 1)
				if(do_after(user, 60 * B.toolspeed * gettoolspeedmod(user), target = src))
					if(constructionStep != CONSTRUCTION_GUTTED || B.get_amount() < 5 || !B)
						return
					add_fingerprint(user)
					user.visible_message(span_notice("[user] adds wires to [src]."), \
										 span_notice("You wire [src]."))
					playsound(get_turf(src), B.usesound, 50, 1)
					B.use(5)
					constructionStep = CONSTRUCTION_WIRES_EXPOSED
					update_icon(UPDATE_ICON_STATE)
				return
		if(CONSTRUCTION_NOCIRCUIT)
			if(istype(C, /obj/item/firelock_electronics))
				user.visible_message(span_notice("[user] starts adding [C] to [src]..."), \
									 span_notice("You begin adding a circuit board to [src]..."))
				playsound(get_turf(src), C.usesound, 50, 1)
				if(!do_after(user, 40 * C.toolspeed * gettoolspeedmod(user), target = src))
					return
				if(constructionStep != CONSTRUCTION_NOCIRCUIT)
					return
				add_fingerprint(user)
				user.drop_transfer_item_to_loc(C, src)
				qdel(C)
				user.visible_message(span_notice("[user] adds a circuit to [src]."), \
									 span_notice("You insert and secure [C]."))
				playsound(get_turf(src), C.usesound, 50, 1)
				constructionStep = CONSTRUCTION_GUTTED
				update_icon(UPDATE_ICON_STATE)
				return
	return ..()

/obj/structure/firelock_frame/crowbar_act(mob/user, obj/item/I)
	if(!(constructionStep in list(CONSTRUCTION_WIRES_EXPOSED, CONSTRUCTION_PANEL_OPEN, CONSTRUCTION_GUTTED)))
		return
	. = TRUE
	if(!I.tool_use_check(user, 0))
		return
	if(constructionStep == CONSTRUCTION_WIRES_EXPOSED)
		user.visible_message(span_notice("[user] starts prying a metal plate into [src]..."), \
							 span_notice("You begin prying the cover plate back onto [src]..."))
		if(!I.use_tool(src, user, 50, volume = I.tool_volume))
			return
		if(constructionStep != CONSTRUCTION_WIRES_EXPOSED)
			return
		user.visible_message(span_notice("[user] pries the metal plate into [src]."), \
							 span_notice("You pry [src]'s cover plate into place, hiding the wires."))
		constructionStep = CONSTRUCTION_PANEL_OPEN
	else if(constructionStep == CONSTRUCTION_PANEL_OPEN)
		user.visible_message(span_notice("[user] starts prying something out from [src]..."), \
							 span_notice("You begin prying out the wire cover..."))
		if(!I.use_tool(src, user, 50, volume = I.tool_volume))
			return
		if(constructionStep != CONSTRUCTION_PANEL_OPEN)
			return
		user.visible_message(span_notice("[user] pries out a metal plate from [src], exposing the wires."), \
							 span_notice("You remove the cover plate from [src], exposing the wires."))
		constructionStep = CONSTRUCTION_WIRES_EXPOSED
	else if(constructionStep == CONSTRUCTION_GUTTED)
		user.visible_message(span_notice("[user] begins removing the circuit board from [src]..."), \
							 span_notice("You begin prying out the circuit board from [src]..."))
		if(!I.use_tool(src, user, 50, volume = I.tool_volume))
			return
		if(constructionStep != CONSTRUCTION_GUTTED)
			return
		user.visible_message(span_notice("[user] removes [src]'s circuit board."), \
							 span_notice("You remove the circuit board from [src]."))
		new /obj/item/firelock_electronics(get_turf(src))
		constructionStep = CONSTRUCTION_NOCIRCUIT
	update_icon(UPDATE_ICON_STATE)

/obj/structure/firelock_frame/wirecutter_act(mob/user, obj/item/I)
	if(constructionStep != CONSTRUCTION_WIRES_EXPOSED)
		return
	. = TRUE
	if(!I.tool_start_check(src, user, 0))
		return

	user.visible_message(span_notice("[user] starts cutting the wires from [src]..."), \
						 span_notice("You begin removing [src]'s wires..."))
	if(!I.use_tool(src, user, 50, volume = I.tool_volume))
		return
	if(constructionStep != CONSTRUCTION_WIRES_EXPOSED)
		return
	user.visible_message(span_notice("[user] removes the wires from [src]."), \
						 span_notice("You remove the wiring from [src], exposing the circuit board."))
	new /obj/item/stack/cable_coil(drop_location(), 5)
	constructionStep = CONSTRUCTION_GUTTED
	update_icon(UPDATE_ICON_STATE)

/obj/structure/firelock_frame/wrench_act(mob/user, obj/item/I)
	if(constructionStep != CONSTRUCTION_PANEL_OPEN)
		return
	. = TRUE
	if(locate(/obj/machinery/door/firedoor) in get_turf(src))
		to_chat(user, span_warning("There's already a firelock there."))
		return
	if(!I.tool_start_check(src, user, 0))
		return
	user.visible_message(span_notice("[user] starts bolting down [src]..."), \
						 span_notice("You begin bolting [src]..."))
	if(!I.use_tool(src, user, 50, volume = I.tool_volume))
		return
	if(locate(/obj/machinery/door/firedoor) in get_turf(src))
		return
	user.visible_message(span_notice("[user] finishes the firelock."), \
						 span_notice("You finish the firelock."))
	if(reinforced)
		new /obj/machinery/door/firedoor/heavy(get_turf(src))
	else
		new /obj/machinery/door/firedoor(get_turf(src))
	qdel(src)


/obj/structure/firelock_frame/welder_act(mob/user, obj/item/I)
	if(constructionStep != CONSTRUCTION_NOCIRCUIT)
		return
	. = TRUE
	if(!I.tool_use_check(user, 0))
		return
	WELDER_ATTEMPT_SLICING_MESSAGE
	if(!I.use_tool(src, user, 40, amount = 1, volume = I.tool_volume))
		return
	if(constructionStep != CONSTRUCTION_NOCIRCUIT)
		return
	WELDER_SLICING_SUCCESS_MESSAGE
	new /obj/item/stack/sheet/metal(drop_location(), 3)
	if(reinforced)
		new /obj/item/stack/sheet/plasteel(drop_location(), 2)
	qdel(src)

/obj/structure/firelock_frame/heavy
	name = "heavy firelock frame"
	reinforced = 1

#undef CONSTRUCTION_COMPLETE
#undef CONSTRUCTION_PANEL_OPEN
#undef CONSTRUCTION_WIRES_EXPOSED
#undef CONSTRUCTION_GUTTED
#undef CONSTRUCTION_NOCIRCUIT
