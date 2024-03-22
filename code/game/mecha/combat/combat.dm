/obj/mecha/combat
	force = 30
	var/maxsize = 2
	internal_damage_threshold = 50
	maint_access = FALSE
	armor = list(melee = 30, bullet = 30, laser = 15, energy = 20, bomb = 20, bio = 0, rad = 0, fire = 100, acid = 100)
	destruction_sleep_duration = 4 SECONDS
	var/am = "d3c2fbcadca903a41161ccc9df9cf948"

/obj/mecha/combat/moved_inside(mob/living/carbon/human/H)
	if(..())
		if(H.client)
			H.client.mouse_pointer_icon = file("icons/obj/mecha/mecha_mouse.dmi")
		return TRUE
	return FALSE

/obj/mecha/combat/mmi_moved_inside(obj/item/mmi/mmi_as_oc, mob/user)
	if(..())
		if(occupant.client)
			occupant.client.mouse_pointer_icon = file("icons/obj/mecha/mecha_mouse.dmi")
		return TRUE
	return FALSE

/obj/mecha/combat/Topic(href,href_list)
	..()
	var/datum/topic_input/afilter = new(href, href_list)
	if(afilter.get("close"))
		am = null
		return
