/obj/structure/tribune
	name = "Tribune"
	icon = 'icons/obj/tribune.dmi'
	icon_state = "nt_tribune"
	desc = "Sturdy wooden tribune. When you look at it, you want to start making a speech."
	density = TRUE
	anchored = FALSE
	max_integrity = 100
	resistance_flags = FLAMMABLE
	pass_flags_self = PASSGLASS
	var/buildstacktype = /obj/item/stack/sheet/wood
	var/buildstackamount = 5
	var/mover_dir = null
	var/ini_dir = null

/obj/structure/tribune/wrench_act(mob/user, obj/item/I)
	. = TRUE
	default_unfasten_wrench(user, I)

/obj/structure/tribune/screwdriver_act(mob/user, obj/item/I)
	. = TRUE
	if(flags & NODECONSTRUCT)
		to_chat(user, "<span class='warning'>Try as you might, you can't figure out how to deconstruct [src].</span>")
		return
	if(!I.use_tool(src, user, 30, volume = I.tool_volume))
		return
	deconstruct(TRUE)

/obj/structure/tribune/deconstruct()
	// If we have materials, and don't have the NOCONSTRUCT flag
	if(buildstacktype && (!(flags & NODECONSTRUCT)))
		new buildstacktype(loc, buildstackamount)
	..()

/obj/structure/tribune/proc/after_rotation(mob/user)
	add_fingerprint(user)

/obj/structure/tribune/Initialize(mapload) //Only for mappers
	..()
	handle_layer()

/obj/structure/tribune/setDir(newdir)
	..()
	handle_layer()

/obj/structure/tribune/Move(newloc, direct, movetime)
	. = ..()
	handle_layer()

/obj/structure/tribune/proc/handle_layer()
	if(dir == NORTH)
		layer = LOW_ITEM_LAYER
	else
		layer = ABOVE_MOB_LAYER

/obj/structure/tribune/AltClick(mob/user)
	if(!Adjacent(user))
		return
	if(anchored)
		to_chat(user, "It is fastened to the floor!")
		return
	setDir(turn(dir, 90))
	after_rotation(user)


/obj/structure/tribune/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(. || dir != border_dir)
		return TRUE


/obj/structure/tribune/CanExit(atom/movable/mover, moving_direction)
	. = ..()
	if(dir == moving_direction)
		return !density || checkpass(mover, PASSGLASS)


/obj/structure/tribune/centcom
	name = "CentCom tribune"
	icon = 'icons/obj/tribune.dmi'
	icon_state = "nt_tribune_cc"
	desc = "A richly decorated tribune. Just looking at her makes your heart skip a beat."
