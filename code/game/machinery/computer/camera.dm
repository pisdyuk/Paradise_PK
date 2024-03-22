/obj/machinery/computer/security
	name = "security camera console"
	desc = "Used to access the various cameras networks on the station."

	icon_keyboard = "security_key"
	icon_screen = "cameras"
	light_color = LIGHT_COLOR_RED
	circuit = /obj/item/circuitboard/camera

	var/mapping = 0 // For the overview file (overview.dm), not used on this page

	var/list/network = list("SS13","Mining Outpost")
	var/obj/machinery/camera/active_camera
	var/list/watchers = list()

	// Stuff needed to render the map
	var/map_name
	var/const/default_map_size = 15
	var/obj/screen/map_view/cam_screen
	/// All the plane masters that need to be applied.
	var/list/cam_plane_masters
	var/obj/screen/background/cam_background

	// Parent object this camera is assigned to. Used for camera bugs
	var/atom/movable/parent

/obj/machinery/computer/security/ui_host()
	return parent ? parent : src

/obj/machinery/computer/security/Initialize()
	. = ..()
	// Initialize map objects
	map_name = "camera_console_[UID()]_map"
	cam_screen = new
	cam_screen.name = "screen"
	cam_screen.assigned_map = map_name
	cam_screen.del_on_map_removal = FALSE
	cam_screen.screen_loc = "[map_name]:1,1"
	cam_plane_masters = list()
	for(var/plane in subtypesof(/obj/screen/plane_master))
		var/obj/screen/instance = new plane()
		instance.assigned_map = map_name
		instance.del_on_map_removal = FALSE
		instance.screen_loc = "[map_name]:CENTER"
		cam_plane_masters += instance
	cam_background = new
	cam_background.assigned_map = map_name
	cam_background.del_on_map_removal = FALSE

/obj/machinery/computer/security/Destroy()
	qdel(cam_screen)
	QDEL_LIST(cam_plane_masters)
	qdel(cam_background)
	active_camera = null
	return ..()

/obj/machinery/computer/security/process()
	. = ..()
	update_camera_view()

/obj/machinery/computer/security/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	// Update UI
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	// Show static if can't use the camera
	if(!active_camera?.can_use())
		show_camera_static()
	if(!ui)
		var/user_uid = user.UID()
		var/is_living = isliving(user)
		// Ghosts shouldn't count towards concurrent users, which produces
		// an audible terminal_on click.
		if(is_living)
			watchers += user_uid
		// Turn on the console
		if(length(watchers) == 1 && is_living)
			playsound(src, 'sound/machines/terminal_on.ogg', 25, FALSE)
			use_power(active_power_usage)
		// Register map objects
		user.client.register_map_obj(cam_screen)
		for(var/plane in cam_plane_masters)
			user.client.register_map_obj(plane)
		user.client.register_map_obj(cam_background)
		// Open UI
		ui = new(user, src, ui_key, "CameraConsole", name, 1200, 600, master_ui, state)
		ui.open()

/obj/machinery/computer/security/ui_close(mob/user)
	..()
	watchers -= user.UID()

/obj/machinery/computer/security/ui_data()
	var/list/data = list()
	data["network"] = network
	data["activeCamera"] = null
	if(active_camera)
		data["activeCamera"] = list(
			name = active_camera.c_tag,
			status = active_camera.status,
		)
	var/list/cameras = get_available_cameras()
	data["cameras"] = list()
	for(var/i in cameras)
		var/obj/machinery/camera/C = cameras[i]
		data["cameras"] += list(list(
			name = C.c_tag,
			x = C.x,
			y = C.y,
			z = C.z,
			status = C.status
		))
	return data

/obj/machinery/computer/security/ui_static_data()
	var/list/data = list()
	data["mapRef"] = map_name
	data["stationLevel"] = level_name_to_num(MAIN_STATION)
	return data

/obj/machinery/computer/security/ui_act(action, params)
	if(..())
		return

	if(action == "switch_camera")
		var/c_tag = params["name"]
		var/list/cameras = get_available_cameras()
		var/obj/machinery/camera/C = cameras[c_tag]
		active_camera?.computers_watched_by -= src
		active_camera = C
		active_camera.computers_watched_by += src
		playsound(src, get_sfx("terminal_type"), 25, FALSE)

		// Show static if can't use the camera
		if(!active_camera?.can_use())
			show_camera_static()
			return TRUE

		update_camera_view()

		return TRUE

/obj/machinery/computer/security/proc/update_camera_view()
	if(!active_camera || !active_camera.can_use())
		return
	var/list/visible_turfs = list()
	for(var/turf/T in view(active_camera.view_range, get_turf(active_camera)))
		visible_turfs += T

	var/list/bbox = get_bbox_of_atoms(visible_turfs)
	var/size_x = bbox[3] - bbox[1] + 1
	var/size_y = bbox[4] - bbox[2] + 1

	cam_screen.vis_contents = visible_turfs
	cam_background.icon_state = "clear"
	cam_background.fill_rect(1, 1, size_x, size_y)

// Returns the list of cameras accessible from this computer
/obj/machinery/computer/security/proc/get_available_cameras()
	var/list/L = list()
	for (var/obj/machinery/camera/C in GLOB.cameranet.cameras)
		if((is_away_level(z) || is_away_level(C.z)) && (C.z != z))//if on away mission, can only receive feed from same z_level cameras
			continue
		L.Add(C)
	var/list/D = list()
	for(var/obj/machinery/camera/C in L)
		if(!C.network)
			stack_trace("Camera in a cameranet has no camera network")
			continue
		if(!(islist(C.network)))
			stack_trace("Camera in a cameranet has a non-list camera network")
			continue
		var/list/tempnetwork = C.network & network
		if(tempnetwork.len)
			D["[C.c_tag]"] = C
	return D

/obj/machinery/computer/security/attack_hand(mob/user)
	if(stat || ..())
		user.unset_machine()
		return

	add_fingerprint(user)
	ui_interact(user)

/obj/machinery/computer/security/attack_ai(mob/user)
	if(isAI(user))
		to_chat(user, span_notice("You realise its kind of stupid to access a camera console when you have the entire camera network at your metaphorical fingertips"))
		return

	ui_interact(user)


/obj/machinery/computer/security/proc/show_camera_static()
	cam_screen.vis_contents.Cut()
	cam_background.icon_state = "scanline2"
	cam_background.fill_rect(1, 1, default_map_size, default_map_size)



// Other computer monitors.
/obj/machinery/computer/security/telescreen
	name = "telescreen"
	desc = "Used for watching camera networks."
	icon_state = "telescreen_console"
	icon_screen = "telescreen"
	icon_keyboard = null
	density = FALSE
	circuit = /obj/item/circuitboard/camera/telescreen


/obj/machinery/computer/security/telescreen/multitool_act(mob/user, obj/item/I)
	. = TRUE
	if(!I.use_tool(src, user, 0, volume = I.tool_volume))
		return
	var/direction = tgui_input_list(user, "Which direction?", "Select direction!", list("North", "East", "South", "West", "Centre"))
	if(!direction || !Adjacent(user))
		return
	pixel_x = 0
	pixel_y = 0
	switch(direction)
		if("North")
			pixel_y = 32
		if("East")
			pixel_x = 32
		if("South")
			pixel_y = -32
		if("West")
			pixel_x = -32


/obj/machinery/computer/security/telescreen/entertainment
	name = "entertainment monitor"
	desc = "Damn, they better have Paradise TV on these things."
	icon_state = "entertainment_console"
	icon_screen = "entertainment_off"
	light_color = "#FFEEDB"
	light_power_on = LIGHTING_MINIMUM_POWER
	network = list("news")
	layer = 4 //becouse of plasma glass with layer = 3
	circuit = /obj/item/circuitboard/camera/telescreen/entertainment
	/// Icon utilised when feeds_on is true
	var/icon_screen_on = "entertainment"
	/// Used to detect how many video cameras are active
	var/feeds_on = 0


/obj/machinery/computer/security/telescreen/entertainment/update_overlays()
	icon_screen = feeds_on ? icon_screen_on : initial(icon_screen)
	return ..()


/obj/machinery/computer/security/telescreen/singularity
	name = "Singularity Engine Telescreen"
	desc = "Used for watching the singularity chamber."
	network = list("Singularity")
	circuit = /obj/item/circuitboard/camera/telescreen/singularity

/obj/machinery/computer/security/telescreen/toxin_chamber
	name = "Toxins Telescreen"
	desc = "Used for watching the test chamber."
	network = list("Toxins")

/obj/machinery/computer/security/telescreen/test_chamber
	name = "Test Chamber Telescreen"
	desc = "Used for watching the test chamber."
	network = list("TestChamber")

/obj/machinery/computer/security/telescreen/research
	name = "Research Monitor"
	desc = "Used for watching the RD's goons from the safety of his office."
	network = list("Research","Research Outpost","RD")

/obj/machinery/computer/security/telescreen/prison
	name = "Prison Monitor"
	desc = "Used for watching Prison Wing holding areas."
	network = list("Prison")

/obj/machinery/computer/security/wooden_tv
	name = "security camera monitor"
	desc = "An old TV hooked into the station's camera network."
	icon_state = "television"
	icon_keyboard = null
	icon_screen = "detective_tv"
	light_color = "#3848B3"
	light_power_on = 0.5
	network = list("SS13")
	circuit = /obj/item/circuitboard/camera/wooden_tv

/obj/machinery/computer/security/mining
	name = "outpost camera monitor"
	desc = "Used to access the various cameras on the outpost."
	icon_keyboard = "mining_key"
	icon_screen = "mining"
	light_color = "#F9BBFC"
	network = list("Mining Outpost")
	circuit = /obj/item/circuitboard/camera/mining

/obj/machinery/computer/security/engineering
	name = "engineering camera monitor"
	desc = "Used to monitor fires and breaches."
	icon_keyboard = "power_key"
	icon_screen = "engie_cams"
	light_color = "#FAC54B"
	network = list("Power Alarms","Atmosphere Alarms","Fire Alarms")
	circuit = /obj/item/circuitboard/camera/engineering

/obj/machinery/computer/security/old_frame
	icon = 'icons/obj/machines/computer3.dmi'
	icon_screen = "sec_oldframe"
	icon_state = "frame-sec"
	icon_keyboard = "kb15"

/obj/machinery/computer/security/old_frame/macintosh
	icon = 'icons/obj/machines/computer3.dmi'
	icon_screen = "sec_oldcomp"
	icon_state = "oldcomp"
	icon_keyboard = null
