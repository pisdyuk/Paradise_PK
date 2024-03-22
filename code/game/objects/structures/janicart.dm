//TG style Janicart

/obj/structure/janitorialcart
	name = "janitorial cart"
	desc = "This is the alpha and omega of sanitation."
	icon = 'icons/obj/janitor.dmi'
	icon_state = "cart"
	anchored = FALSE
	density = TRUE
	container_type = OPENCONTAINER
	pull_push_speed_modifier = 1
	//copypaste sorry
	var/amount_per_transfer_from_this = 5 //shit I dunno, adding this so syringes stop runtime erroring. --NeoFite
	var/obj/item/storage/bag/trash/mybag	= null
	var/obj/item/mop/mymop = null
	var/obj/item/reagent_containers/spray/cleaner/myspray = null
	var/obj/item/lightreplacer/myreplacer = null
	var/signs = 0
	var/const/max_signs = 4


/obj/structure/janitorialcart/Initialize(mapload)
	. = ..()
	create_reagents(100)
	GLOB.janitorial_equipment += src

/obj/structure/janitorialcart/Destroy()
	GLOB.janitorial_equipment -= src
	QDEL_NULL(mybag)
	QDEL_NULL(mymop)
	QDEL_NULL(myspray)
	QDEL_NULL(myreplacer)
	return ..()


/obj/structure/janitorialcart/proc/put_in_cart(obj/item/I, mob/user)
	user.drop_transfer_item_to_loc(I, src)
	updateUsrDialog()
	to_chat(user, "<span class='notice'>You put [I] into [src].</span>")
	update_icon(UPDATE_OVERLAYS)


/obj/structure/janitorialcart/on_reagent_change()
	update_icon(UPDATE_OVERLAYS)

/obj/structure/janitorialcart/attackby(obj/item/I, mob/user, params)
	var/fail_msg = "<span class='notice'>There is already one of those in [src].</span>"

	if(!I.is_robot_module())
		if(istype(I, /obj/item/mop))
			var/obj/item/mop/m=I
			if(m.reagents.total_volume < m.reagents.maximum_volume)
				m.wet_mop(src, user)
				return
			if(!mymop)
				add_fingerprint(user)
				m.janicart_insert(user, src)
			else
				to_chat(user, fail_msg)

		else if(istype(I, /obj/item/storage/bag/trash))
			if(!mybag)
				add_fingerprint(user)
				var/obj/item/storage/bag/trash/t=I
				t.janicart_insert(user, src)
			else
				to_chat(user, fail_msg)
		else if(istype(I, /obj/item/reagent_containers/spray/cleaner))
			if(!myspray)
				add_fingerprint(user)
				myspray=I
				put_in_cart(I, user)
			else
				to_chat(user, fail_msg)
		else if(istype(I, /obj/item/lightreplacer))
			if(!myreplacer)
				add_fingerprint(user)
				var/obj/item/lightreplacer/l=I
				l.janicart_insert(user,src)
			else
				to_chat(user, fail_msg)
		else if(istype(I, /obj/item/caution))
			if(signs < max_signs)
				add_fingerprint(user)
				signs++
				put_in_cart(I, user)
			else
				to_chat(user, "<span class='notice'>[src] can't hold any more signs.</span>")
		else if(I.tool_behaviour == TOOL_CROWBAR)
			user.visible_message("<span class='warning'>[user] begins to empty the contents of [src].</span>")
			if(do_after(user, 30 * I.toolspeed * gettoolspeedmod(user), target = src))
				add_fingerprint(user)
				to_chat(usr, "<span class='notice'>You empty the contents of [src]'s bucket onto the floor.</span>")
				reagents.reaction(src.loc)
				src.reagents.clear_reagents()
		else if(I.tool_behaviour == TOOL_WRENCH)
			add_fingerprint(user)
			if(!anchored && !isinspace())
				playsound(src.loc, I.usesound, 50, 1)
				user.visible_message( \
					"[user] tightens \the [src]'s casters.", \
					"<span class='notice'> You have tightened \the [src]'s casters.</span>", \
					"You hear ratchet.")
				anchored = TRUE
			else if(anchored)
				playsound(src.loc, I.usesound, 50, 1)
				user.visible_message( \
					"[user] loosens \the [src]'s casters.", \
					"<span class='notice'> You have loosened \the [src]'s casters.</span>", \
					"You hear ratchet.")
				anchored = FALSE
		else if(mybag)
			add_fingerprint(user)
			mybag.attackby(I, user, params)
	else
		to_chat(usr, "<span class='warning'>You cannot interface your modules [src]!</span>")

/obj/structure/janitorialcart/attack_hand(mob/user)
	add_fingerprint(user)
	user.set_machine(src)
	var/dat = {"<meta charset="UTF-8">"}
	if(mybag)
		dat += "<a href='?src=[UID()];garbage=1'>[mybag.name]</a><br>"
	if(mymop)
		dat += "<a href='?src=[UID()];mop=1'>[mymop.name]</a><br>"
	if(myspray)
		dat += "<a href='?src=[UID()];spray=1'>[myspray.name]</a><br>"
	if(myreplacer)
		dat += "<a href='?src=[UID()];replacer=1'>[myreplacer.name]</a><br>"
	if(signs)
		dat += "<a href='?src=[UID()];sign=1'>[signs] sign\s</a><br>"
	var/datum/browser/popup = new(user, "janicart", name, 240, 160)
	popup.set_content(dat)
	popup.open()


/obj/structure/janitorialcart/Topic(href, href_list)
	if(!in_range(src, usr))
		return
	if(!isliving(usr))
		return
	var/mob/living/user = usr
	if(href_list["garbage"])
		if(mybag)
			mybag.forceMove_turf()
			user.put_in_hands(mybag, ignore_anim = FALSE)
			to_chat(user, "<span class='notice'>You take [mybag] from [src].</span>")
			mybag = null
	if(href_list["mop"])
		if(mymop)
			mymop.forceMove_turf()
			user.put_in_hands(mymop, ignore_anim = FALSE)
			to_chat(user, "<span class='notice'>You take [mymop] from [src].</span>")
			mymop = null
	if(href_list["spray"])
		if(myspray)
			myspray.forceMove_turf()
			user.put_in_hands(myspray, ignore_anim = FALSE)
			to_chat(user, "<span class='notice'>You take [myspray] from [src].</span>")
			myspray = null
	if(href_list["replacer"])
		if(myreplacer)
			myreplacer.forceMove_turf()
			user.put_in_hands(myreplacer, ignore_anim = FALSE)
			to_chat(user, "<span class='notice'>You take [myreplacer] from [src].</span>")
			myreplacer = null
	if(href_list["sign"])
		if(signs)
			var/obj/item/caution/Sign = locate() in src
			if(Sign)
				Sign.forceMove_turf()
				user.put_in_hands(Sign, ignore_anim = FALSE)
				to_chat(user, "<span class='notice'>You take \a [Sign] from [src].</span>")
				signs--
			else
				WARNING("Signs ([signs]) didn't match contents")
				signs = 0

	update_icon(UPDATE_OVERLAYS)
	updateUsrDialog()


/obj/structure/janitorialcart/update_overlays()
	. = ..()
	if(mybag)
		. += "cart_garbage"
	if(mymop)
		. += "cart_mop"
	if(myspray)
		. += "cart_spray"
	if(myreplacer)
		. += "cart_replacer"
	if(signs)
		. += "cart_sign[signs]"
	if(reagents.total_volume > 0)
		var/image/reagentsImage = image(icon,src,"cart_reagents0")
		reagentsImage.alpha = 150
		switch((reagents.total_volume / reagents.maximum_volume) * 100)
			if(1 to 25)
				reagentsImage.icon_state = "cart_reagents1"
			if(26 to 50)
				reagentsImage.icon_state = "cart_reagents2"
			if(51 to 75)
				reagentsImage.icon_state = "cart_reagents3"
			if(76 to 100)
				reagentsImage.icon_state = "cart_reagents4"
		reagentsImage.icon += mix_color_from_reagents(reagents.reagent_list)
		. += reagentsImage

