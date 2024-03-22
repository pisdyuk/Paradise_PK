/obj/machinery/computer/podtracker
	name = "pod tracking console"
	icon = 'icons/obj/machines/computer.dmi'
	icon_keyboard = "tech_key"
	icon_screen = "rdcomp"
	light_color = LIGHT_COLOR_PURPLE
	req_access = list(ACCESS_ROBOTICS)
	circuit = /obj/item/circuitboard/pod_locater

/obj/machinery/computer/podtracker/attack_ai(mob/user)
	return attack_hand(user)

/obj/machinery/computer/podtracker/attack_hand(mob/user)
	if(..())
		return TRUE

	add_fingerprint(user)
	ui_interact(user)

/obj/machinery/computer/podtracker/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "PodTracking", name, 400, 500, master_ui, state)
		ui.open()

/obj/machinery/computer/podtracker/ui_data(mob/user)
	var/list/data = list()
	var/list/pods = list()
	for(var/obj/item/spacepod_equipment/misc/tracker/TR in GLOB.pod_trackers)
		var/obj/spacepod/my_pod = TR.my_atom
		var/podname
		var/pilot
		var/list/passengers
		var/passengers_text = ""
		if(my_pod)
			podname = capitalize(sanitize(my_pod.name))
			pilot = "None"
			passengers = list()
			if(my_pod.pilot)
				pilot = my_pod.pilot
			if(my_pod.passengers)
				for(var/mob/M in my_pod.passengers)
					passengers += M.name
			passengers_text = english_list(passengers, "None")
			pods.Add(list(list("name" = podname, "podx" = my_pod.x, "pody" = my_pod.y, "podz" = my_pod.z, "pilot" = pilot, "passengers" = passengers_text)))
		else
			podname = capitalize(sanitize(TR.name))
			pilot = "None"
			passengers_text = "None"
			pods.Add(list(list("name" = podname, "podx" = TR.x, "pody" = TR.y, "podz" = TR.z, "pilot" = pilot, "passengers" = passengers_text)))

	data["pods"] = pods
	return data

/obj/machinery/computer/podtracker/old_frame
	icon = 'icons/obj/machines/computer3.dmi'
	icon_state = "frame-eng"
	icon_keyboard = "kb1"
