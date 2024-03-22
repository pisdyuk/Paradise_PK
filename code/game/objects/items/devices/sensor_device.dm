/obj/item/sensor_device
	name = "handheld crew monitor"
	desc = "A miniature machine that tracks suit sensors across the station."
	icon = 'icons/obj/device.dmi'
	icon_state = "scanner"
	item_state = "electronic"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = SLOT_BELT
	origin_tech = "programming=3;materials=3;magnets=3"
	var/datum/ui_module/crew_monitor/crew_monitor

/obj/item/sensor_device/Initialize(mapload)
	.=..()
	crew_monitor = new(src)

/obj/item/sensor_device/Destroy()
	QDEL_NULL(crew_monitor)
	return ..()

/obj/item/sensor_device/attack_self(mob/user)
	ui_interact(user)


/obj/item/sensor_device/MouseDrop(atom/over_object, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(!.)
		return FALSE

	var/mob/user = usr
	if(user.incapacitated() || !ishuman(user))
		return FALSE

	if(over_object == user)
		attack_self(user)
		return TRUE

	return FALSE


/obj/item/sensor_device/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	crew_monitor.ui_interact(user, ui_key, ui, force_open)

/obj/item/sensor_device/advanced

/obj/item/sensor_device/advanced/command
	name = "command crew monitor"
	item_state = "blueshield_monitor"
	icon_state = "c_scanner"

/obj/item/sensor_device/advanced/command/Initialize(mapload)
	. = ..()
	crew_monitor.crew_vision = CREW_VISION_COMMAND

/obj/item/sensor_device/advanced/security
	name = "security crew monitor"
	item_state = "brig_monitor"
	icon_state = "s_scanner"

/obj/item/sensor_device/advanced/security/Initialize(mapload)
	. = ..()
	crew_monitor.crew_vision = CREW_VISION_SECURITY
