
#define MAX_ICON_STATES_FOR_NOTICES 12

/obj/structure/noticeboard
	name = "notice board"
	desc = "A board for pinning important notices upon."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "nboard"
	density = 0
	anchored = TRUE
	max_integrity = 150
	var/notices = 0

/obj/structure/noticeboard/Initialize()
	. = ..()
	for(var/obj/item/paper/paper in loc)
		paper.loc = src
		notices++
	update_icon(UPDATE_OVERLAYS)

/obj/structure/noticeboard/update_overlays()
	. = list()
	for(var/I in 1 to notices)
		if(I > MAX_ICON_STATES_FOR_NOTICES)
			break
		. += image(src.icon, icon_state = "[src.icon_state][I]")


//attaching papers!!
/obj/structure/noticeboard/attackby(obj/item/item, mob/user, params)
	if(istype(item, /obj/item/paper))
		item.add_fingerprint(user)
		add_fingerprint(user)
		if(!user.drop_transfer_item_to_loc(item, src))
			return
		notices++
		update_icon(UPDATE_OVERLAYS)
		to_chat(user, span_notice("You pin the paper to the noticeboard."))
		return
	return ..()

/obj/structure/noticeboard/attack_hand(mob/user)
	add_fingerprint(user)
	var/list/dat = list({"<meta charset="UTF-8">"})
	dat += "<HEAD><TITLE>Notices</TITLE></HEAD>"
	dat += "<B>Noticeboard</B><BR>"
	var/uid = UID()
	for(var/obj/item/paper/P in src)
		dat += "<A href='?src=[uid];read=[P.UID()]'>[P.name]</A> <A href='?src=[uid];write=[P.UID()]'>Write</A> <A href='?src=[uid];remove=[P.UID()]'>Remove</A><BR>"
	user << browse(dat.Join(""),"window=noticeboard")
	onclose(user, "noticeboard")

/obj/structure/noticeboard/screwdriver_act(mob/living/user, obj/item/I)
	. = TRUE
	if(!I.use_tool(src, user, 1 SECONDS, volume = I.tool_volume))
		return
	to_chat(user, span_notice("You unfasten [src.name] with [I]."))
	new /obj/item/noticeboard(src.loc)
	for(var/obj/item/paper/paper in src)
		paper.forceMove_turf()
	qdel(src)

/obj/structure/noticeboard/deconstruct(disassembled = TRUE)
	if(!(flags & NODECONSTRUCT))
		new /obj/item/stack/sheet/wood(loc, 5)
		..()

/obj/structure/noticeboard/Topic(href, href_list)
	..()
	usr.set_machine(src)
	if(href_list["remove"])
		if((usr.stat || usr.restrained()))	//For when a player is handcuffed while they have the notice window open
			return
		var/obj/item/paper/paper = locateUID(href_list["remove"])
		if(istype(paper) && paper.loc == src)
			paper.forceMove_turf()	//dump paper on the floor because you're a clumsy fuck
			paper.add_fingerprint(usr)
			add_fingerprint(usr)
			notices--
			update_icon(UPDATE_OVERLAYS)

	if(href_list["write"])
		if((usr.stat || usr.restrained())) //For when a player is handcuffed while they have the notice window open
			return
		var/obj/item/paper/paper = locateUID(href_list["write"])
		if(istype(paper) && paper.loc == src) //ifthe paper's on the board
			if(is_pen(usr.r_hand)) //and you're holding a pen
				add_fingerprint(usr)
				paper.attackby(usr.r_hand, usr) //then do ittttt
			else if(is_pen(usr.l_hand)) //check other hand for pen
				add_fingerprint(usr)
				paper.attackby(usr.l_hand, usr)
			else
				to_chat(usr, span_notice("You'll need something to write with!"))

	if(href_list["read"])
		var/obj/item/paper/paper = locateUID(href_list["read"])
		if(istype(paper) && paper.loc == src)
			paper.show_content(usr)
	return

/obj/item/noticeboard
	name = "notice board"
	desc = "A board for pinning important notices upon."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "nboard"
	resistance_flags = FLAMMABLE

/obj/item/noticeboard/screwdriver_act(mob/living/user, obj/item/I)
	if(!isturf(user.loc))
		return
	var/direction = input("In which direction?", "Select direction.") in list("North", "East", "South", "West", "Cancel")
	if(direction == "Cancel")
		return
	if(QDELETED(src))
		return
	if(!isturf(user.loc) || !Adjacent(user))
		return
	var/obj/structure/noticeboard/noticeboard = new(user.loc)
	switch(direction)
		if("North")
			noticeboard.pixel_y = 32
		if("East")
			noticeboard.pixel_x = 32
		if("South")
			noticeboard.pixel_y = -32
		if("West")
			noticeboard.pixel_x = -32
	src.transfer_fingerprints_to(noticeboard)
	to_chat(user, span_notice("You fasten [noticeboard.name] with your [I]."))
	qdel(src)

#undef MAX_ICON_STATES_FOR_NOTICES
