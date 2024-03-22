#define IV_TAKING 0
#define IV_INJECTING 1

/obj/machinery/iv_drip
	name = "\improper IV drip"
	icon = 'icons/goonstation/objects/iv.dmi'
	icon_state = "stand"
	anchored = FALSE
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	var/obj/item/reagent_containers/iv_bag/bag = null

/obj/machinery/iv_drip/process()
	if(istype(bag) && bag.injection_target)
		update_icon(UPDATE_OVERLAYS)
		return
	return PROCESS_KILL


/obj/machinery/iv_drip/update_overlays()
	. = ..()
	if(bag)
		. += "hangingbag"
		if(bag.reagents.total_volume)
			var/image/filling = image('icons/goonstation/objects/iv.dmi', src, "hangingbag-fluid")
			filling.icon += mix_color_from_reagents(bag.reagents.reagent_list)
			. += filling


/obj/machinery/iv_drip/MouseDrop(atom/over_object, src_location, over_location, src_control, over_control, params)
	if(usr.incapacitated() || !ishuman(usr) || !ishuman(over_object) || !Adjacent(over_object) || !usr.Adjacent(over_object))
		return FALSE

	add_fingerprint(usr)
	if(!bag)
		to_chat(usr, span_warning("There's no IV bag connected to [src]!"))
		return FALSE
	bag.afterattack(over_object, usr, TRUE)
	START_PROCESSING(SSmachines, src)


/obj/machinery/iv_drip/attack_hand(mob/user)
	if(bag)
		add_fingerprint(user)
		bag.forceMove_turf()
		user.put_in_hands(bag, ignore_anim = FALSE)
		bag.update_icon(UPDATE_OVERLAYS)
		bag = null
		update_icon(UPDATE_OVERLAYS)

/obj/machinery/iv_drip/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/iv_bag))
		if(bag)
			to_chat(user, span_warning("[src] already has an IV bag!"))
			return
		if(!user.drop_transfer_item_to_loc(I, src))
			return

		add_fingerprint(user)
		bag = I
		to_chat(user, span_notice("You attach [I] to [src]."))
		update_icon(UPDATE_OVERLAYS)
		START_PROCESSING(SSmachines, src)
	else if (bag && istype(I, /obj/item/reagent_containers))
		add_fingerprint(user)
		bag.attackby(I)
		I.afterattack(bag, usr, TRUE)
		update_icon(UPDATE_OVERLAYS)
	else
		return ..()

/obj/machinery/iv_drip/deconstruct(disassembled = TRUE)
	if(!(flags & NODECONSTRUCT))
		new /obj/item/stack/sheet/metal(loc)
	qdel(src)

/obj/machinery/iv_drip/examine(mob/user)
	. = ..()
	if(bag)
		. += bag.examine(user)

/obj/machinery/iv_drip/Move(NewLoc, direct)
	. = ..()
	if(!.) // ..() will return 0 if we didn't actually move anywhere.
		return .
	playsound(loc, pick('sound/items/cartwheel1.ogg', 'sound/items/cartwheel2.ogg'), 100, 1, ignore_walls = FALSE)

#undef IV_TAKING
#undef IV_INJECTING
