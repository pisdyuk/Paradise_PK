/obj/machinery/atmospherics/unary/portables_connector
	icon = 'icons/obj/pipes_and_stuff/atmospherics/atmos/connector.dmi'
	icon_state = "map_connector"

	name = "connector port"
	desc = "For connecting portables devices related to atmospherics control."

	can_unwrench = 1
	layer = GAS_PIPE_VISIBLE_LAYER + GAS_FILTER_OFFSET
	layer_offset = GAS_FILTER_OFFSET

	var/obj/machinery/portable_atmospherics/connected_device

	on = FALSE

/obj/machinery/atmospherics/unary/portables_connector/Destroy()
	if(connected_device)
		connected_device.disconnect()
	return ..()

/obj/machinery/atmospherics/unary/portables_connector/update_icon_state()
	icon_state = "connector"


/obj/machinery/atmospherics/unary/portables_connector/update_underlays()
	if(..())
		underlays.Cut()
		var/turf/T = get_turf(src)
		if(!istype(T))
			return
		add_underlay(T, node, dir)

/obj/machinery/atmospherics/unary/portables_connector/process_atmos()
	..()
	if(!connected_device)
		return 0
	if(parent)
		parent.update = 1

/obj/machinery/atmospherics/unary/portables_connector/attackby(var/obj/item/W as obj, var/mob/user as mob, params)
	if(W.tool_behaviour == TOOL_WRENCH)
		if(connected_device)
			to_chat(user, span_danger("You cannot unwrench this [src], detach [connected_device] first."))
			return 1
	return ..()

/obj/machinery/atmospherics/unary/portables_connector/portableConnectorReturnAir()
	return connected_device.portableConnectorReturnAir()

/obj/proc/portableConnectorReturnAir()
