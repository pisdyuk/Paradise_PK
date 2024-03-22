#define COUNT_PLASMA_QUESTS 3

/datum/station_goal/bfl
	name = "BFL Mining laser"
	gamemode_blacklist = list("extended")

/datum/station_goal/bfl/get_report()
	return {"<b>Mining laser construcion</b><br>
	Our surveillance drone detected an enormous deposit, oozing with plasma. We need you to construct a BFL system to collect plasma and send it to the Central Command via cargo shuttle.
	<br>
	Its base parts should be available for shipping by your cargo shuttle.
	<br>
	In order to complete the mission, you must to order a special pack in cargo called BFL Mission goal, and install it content anywhere on the station.
	<br><br>
	-Nanotrasen Naval Command"}


/datum/station_goal/bfl/on_report()
	//Unlock BFL related things
	var/datum/supply_packs/misc/station_goal/P = SSshuttle.supply_packs["[/datum/supply_packs/misc/station_goal/bfl]"]
	P.special_enabled = TRUE
	supply_list.Add(P)

	P =  SSshuttle.supply_packs["[/datum/supply_packs/misc/station_goal/bfl_lens]"]
	P.special_enabled = TRUE
	supply_list.Add(P)

	P =  SSshuttle.supply_packs["[/datum/supply_packs/misc/station_goal/bfl_goal]"]
	P.special_enabled = TRUE
	supply_list.Add(P)

	if(length(SScargo_quests.plasma_quests) > COUNT_PLASMA_QUESTS)
		return

	for(var/I = 1 to COUNT_PLASMA_QUESTS)
		SScargo_quests.create_new_quest(pick(SScargo_quests.plasma_departaments))

/datum/station_goal/bfl/check_completion()
	if(..())
		return TRUE
	for(var/obj/structure/toilet/golden_toilet/bfl_goal/B)
		if(B && is_station_contact(B.z))
			return TRUE
	return FALSE

/datum/station_goal/bfl/Destroy()
	. = ..()
	if(locate(/datum/station_goal/bfl) in SSticker.mode.station_goals)
		return
	SScargo_quests.remove_bfl_quests(COUNT_PLASMA_QUESTS)

////////////
//Building//
////////////
/obj/item/circuitboard/machine/bfl_emitter
	board_name = "BFL Emitter"
	desc = "Be cautious, when emitter will be done it move up by one step"
	build_path = /obj/machinery/power/bfl_emitter
	origin_tech = "engineering=4;combat=4;bluespace=4"
	req_components = list(
					/obj/item/stack/sheet/plasteel = 10,
					/obj/item/stack/sheet/plasmaglass = 4,
					/obj/item/stock_parts/capacitor/quadratic = 5,
					/obj/item/stock_parts/micro_laser/quadultra = 10,
					/obj/item/stack/sheet/mineral/diamond = 2)

/obj/item/circuitboard/machine/bfl_receiver
	board_name = "BFL Receiver"
	desc = "Must be built in the middle of the deposit"
	build_path = /obj/machinery/bfl_receiver
	origin_tech = "engineering=4;combat=4;bluespace=4"
	req_components = list(
					/obj/item/stack/sheet/metal = 20,
					/obj/item/stack/sheet/plasteel = 10,
					/obj/item/stack/sheet/plasmaglass = 20)

///////////
//Emitter//
///////////
/obj/machinery/power/bfl_emitter
	name = "BFL Emitter"
	icon = 'icons/obj/machines/BFL_mission/Emitter.dmi'
	icon_state = "Emitter_Off"
	anchored = TRUE
	density = TRUE
	use_power = NO_POWER_USE
	idle_power_usage = 100000
	active_power_usage = 500000

	var/emag = FALSE
	var/state = FALSE
	var/obj/singularity/bfl_red/laser = null
	var/obj/machinery/bfl_receiver/receiver = FALSE
	var/deactivate_time = 0
	var/list/obj/structure/fillers = list()
	var/lavaland_z_lvl		// Определяется кодом по имени лаваленда

/obj/machinery/power/bfl_emitter/attack_hand(mob/user as mob)
	if(..())
		return TRUE
	var/response
	src.add_fingerprint(user)
	if(state)
		response = alert(user, "You trying to deactivate BFL emitter machine, are you sure?", "BFL Emitter", "deactivate", "nothing")
	else
		response = alert(user, "You trying to activate BFL emitter machine, are you sure?", "BFL Emitter", "activate", "nothing")

	switch(response)
		if("deactivate")
			if(emag)
				visible_message("BFL software update, please wait.<br> 99% complete")
				playsound(src, 'sound/BFL/prank.ogg', 100, TRUE)
			else
				emitter_deactivate()
				deactivate_time = world.time
		if("activate")
			if(!powernet)
				connect_to_network()
			if(!powernet)
				to_chat(user, "Powernet not found.")
				return
			if(surplus() < active_power_usage)
				to_chat(user, "The connected wire doesn't have enough current.")
				return
			if(world.time - deactivate_time > 30 SECONDS)
				emitter_activate()
			else
				visible_message("Error, emitter is still cooling down")



/obj/machinery/power/bfl_emitter/emag_act(mob/user)
	. = ..()
	if(!emag)
		add_attack_logs(user, src, "emagged")
		emag = TRUE
		if(user)
			to_chat(user, "Emitter successfully sabotaged")

/obj/machinery/power/bfl_emitter/process()
	if(!state)
		add_load(idle_power_usage)
		return
	if(surplus() < active_power_usage)
		emitter_deactivate()
		return
	add_load(active_power_usage)
	if(laser)
		return

	if(!receiver || !receiver.state || emag || !receiver.lens || !receiver.lens.anchored)
		var/turf/rand_location = locate(rand((2*TRANSITIONEDGE), world.maxx - (2*TRANSITIONEDGE)), rand((2*TRANSITIONEDGE), world.maxy - (2*TRANSITIONEDGE)), lavaland_z_lvl)
		laser = new (rand_location)
		for(var/M in GLOB.player_list)
			var/turf/mob_turf = get_turf(M)
			if(mob_turf?.z == lavaland_z_lvl)
				to_chat(M, span_boldwarning("You see bright red flash in the sky. Then clouds of smoke rises, uncovering giant red ray striking from the sky."))
		laser.move = rand_location.x
		if(receiver)
			receiver.mining = FALSE
			if(receiver.lens)
				receiver.lens.deactivate_lens()


/obj/machinery/power/bfl_emitter/proc/receiver_test()
	if(receiver)
		if(receiver.state && receiver.lens)
			receiver.lens.activate_lens()
			receiver.mining = TRUE
		return TRUE


/obj/machinery/power/bfl_emitter/proc/emitter_activate()
	state = TRUE
	update_icon(UPDATE_ICON_STATE)
	var/turf/location = get_step(src, NORTH)
	location.ex_act(1)
	working_sound()

	if(QDELETED(receiver))
		receiver = null

	if(!receiver)
		for(var/obj/machinery/bfl_receiver/bfl_receiver in GLOB.machines)
			var/turf/receiver_turf = get_turf(bfl_receiver)
			if(receiver_turf.z == lavaland_z_lvl)
				receiver = bfl_receiver
				break

	receiver_test()


/obj/machinery/power/bfl_emitter/proc/emitter_deactivate()
	state = FALSE
	update_icon(UPDATE_ICON_STATE)
	if(receiver)
		receiver.mining = FALSE
		if(receiver.lens?.state)
			receiver.lens.deactivate_lens()

	if(laser)
		qdel(laser)
		laser = null


/obj/machinery/power/bfl_emitter/proc/working_sound()
	set waitfor = FALSE
	while(state)
		playsound(src, 'sound/BFL/emitter.ogg', 100, TRUE)
		sleep(25)


/obj/machinery/power/bfl_emitter/update_icon_state()
	icon_state = "Emitter_[state ? "On" : "Off"]"



//code stolen from bluespace_tap, including comment below. He was right about the new datum
//code stolen from dna vault, inculding comment below. Taking bets on that datum being made ever.
//TODO: Replace this,bsa and gravgen with some big machinery datum
/obj/machinery/power/bfl_emitter/Initialize()
	.=..()
	lavaland_z_lvl = level_name_to_num(MINING)
	pixel_x = -32
	pixel_y = 0
	playsound(src, 'sound/BFL/drill_sound.ogg', 100, TRUE)

	var/list/occupied = list()
	for(var/direction in list(NORTH, NORTHWEST, NORTHEAST, EAST, WEST))
		occupied += get_step(src, direction)
	occupied += locate(x, y + 2, z)
	occupied += locate(x + 1, y + 2, z)
	occupied += locate(x - 1, y + 2, z)
	for(var/T in occupied)
		var/obj/structure/filler/F = new(T)
		F.parent = src
		fillers += F

	if(!powernet)
		connect_to_network()

/obj/machinery/power/bfl_emitter/Destroy()
	emitter_deactivate()
	QDEL_LIST(fillers)
	return ..()

////////////
//Receiver//
////////////
#define PLASMA 2
#define SAND 1
#define NOTHING 0

/obj/item/storage/bag/ore/bfl_storage
	storage_slots = 20

/obj/item/storage/bag/ore/bfl_storage/proc/empty_storage(turf/location)
	for(var/obj/item/I in contents)
		remove_from_storage(I, location)
		CHECK_TICK

/obj/machinery/bfl_receiver
	name = "BFL Receiver"
	desc = "Activate button doesn't look right. Probably should open the pit manually, try using a crowbar."
	icon = 'icons/obj/machines/BFL_mission/Hole.dmi'
	icon_state = "Receiver_Off"
	anchored = TRUE
	interact_offline = TRUE

	var/state = FALSE
	var/mining = FALSE
	///Receiver's internal storage for ore
	var/obj/item/storage/bag/ore/bfl_storage/internal
	var/internal_type = /obj/item/storage/bag/ore/bfl_storage
	var/obj/machinery/bfl_lens/lens = null
	var/ore_type = FALSE
	var/last_user_ckey
	///An "overlay"-like light for receiver to indicate storage filling
	var/atom/movable/bfl_receiver_light/receiver_light = null
	///Used to define bits of ore mined, instead of stacks.
	var/ore_count = 0
	///Used for storing last icon update for receiver lights on borders of receiver
	var/last_light_state_number = 0

/obj/machinery/bfl_receiver/attack_hand(mob/user)
	if(..())
		return TRUE
	var/response
	src.add_fingerprint(user)
	if(state)
		response = alert(user, "You trying to deactivate BFL receiver machine, are you sure?", "BFL Receiver", "deactivate", "empty ore storage", "nothing")
	else
		response = alert(user, "You trying to activate BFL receiver machine, are you sure?", "BFL Receiver", "activate", "empty ore storage", "nothing")

	switch(response)
		if("deactivate")
			to_chat(user, "No power. <br> You should open the pit manually, try using a crowbar")
		if("activate")
			to_chat(user, "No power. <br> You should open the pit manually, try using a crowbar")
		if("empty ore storage")
			if(lens)
				to_chat(user, "The Lens interferes, you can't get any ore from storage.")
				return
			if(state && (user.ckey != last_user_ckey))
				to_chat(user, "Your inner voice telling you should close the pit first.")
				last_user_ckey = user.ckey
				return
			var/turf/location = get_turf(src)
			internal.empty_storage(location)
			ore_count = 0
			update_state()


/obj/machinery/bfl_receiver/crowbar_act(mob/user, obj/item/I)
	. = TRUE
	if(!I.use_tool(src, user, 0, volume = 0))
		return
	if(state)
		receiver_deactivate()
	else
		receiver_activate()

///This proc handles light updating on borders of BFL receiver.
/obj/machinery/bfl_receiver/proc/update_state()
	var/light_state = clamp(length(internal.contents), 0, 20)
	if(last_light_state_number == light_state)
		return
	receiver_light.light_amount = light_state
	last_light_state_number = light_state
	receiver_light.update_icon(UPDATE_ICON_STATE)


/obj/machinery/bfl_receiver/process()
	if(!(mining && state))
		return
	if(ore_count >= internal.storage_slots * 50)
		return
	switch(ore_type)
		if(PLASMA)
			internal.handle_item_insertion(new /obj/item/stack/ore/plasma, TRUE)
			ore_count += 1
		if(SAND)
			internal.handle_item_insertion(new /obj/item/stack/ore/glass, TRUE)
			ore_count += 1

	update_state()

/obj/machinery/bfl_receiver/Initialize()
	. = ..()
	pixel_x = -32
	pixel_y = -32
	//it just works ¯\_(ツ)_/¯
	internal = new internal_type(src)
	receiver_light = new (loc)
	playsound(src, 'sound/BFL/drill_sound.ogg', 100, TRUE)

	var/turf/turf_under = get_turf(src)
	if(locate(/obj/bfl_crack) in turf_under)
		ore_type = PLASMA
	else if(istype(turf_under, /turf/simulated/floor/plating/asteroid/basalt/lava_land_surface))
		ore_type = SAND
	else
		ore_type = NOTHING

/obj/machinery/bfl_receiver/Destroy()
	qdel(receiver_light)
	return ..()


/obj/machinery/bfl_receiver/update_icon_state()
	icon_state = "Receiver_[state ? "On" : "Off"]"


/obj/machinery/bfl_receiver/proc/receiver_activate()
	state = TRUE
	update_icon(UPDATE_ICON_STATE)
	var/turf/T = get_turf(src)
	T.ChangeTurf(/turf/simulated/floor/chasm/straight_down/lava_land_surface)

/obj/machinery/bfl_receiver/proc/receiver_deactivate()
	var/turf/turf_under = get_step(src, SOUTH)
	var/turf/T = get_turf(src)
	state = FALSE
	update_icon(UPDATE_ICON_STATE)
	T.ChangeTurf(turf_under.type)

/obj/machinery/bfl_receiver/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(istype(AM, /obj/machinery/bfl_lens))
		var/obj/machinery/bfl_lens/bfl_lens = AM
		bfl_lens.step_count = 0

#undef PLASMA
#undef SAND
#undef NOTHING

/atom/movable/bfl_receiver_light
	name = ""
	icon = 'icons/obj/machines/BFL_Mission/Hole.dmi'
	icon_state = "Receiver_Light_0"
	layer = LOW_ITEM_LAYER
	flags = INDESTRUCTIBLE
	anchored = TRUE
	var/light_amount = 0


/atom/movable/bfl_receiver_light/Initialize(mapload)
	. = ..()
	pixel_x = -32
	pixel_y = -32


/atom/movable/bfl_receiver_light/update_icon_state()
	icon_state = "Receiver_Light_[light_amount]"


////////
//Lens//
////////
/obj/machinery/bfl_lens
	name = "High-precision lens"
	desc = "Extremely fragile, handle with care."
	icon = 'icons/obj/machines/BFL_Mission/Hole.dmi'
	icon_state = "Lens_Pull"
	max_integrity = 40
	layer = ABOVE_MOB_LAYER
	density = 1

	var/step_count = 0
	var/state = FALSE

/obj/machinery/bfl_lens/update_icon_state()
	if(state)
		icon_state = "Lens_On"
	else if(anchored)
		icon_state = "Lens_Off"
	else
		icon_state = "Lens_Pull"


/obj/machinery/bfl_lens/update_overlays()
	. = ..()
	if(state)
		. += image('icons/obj/machines/BFL_Mission/Laser.dmi', icon_state = "Laser_Blue", pixel_y = 64, layer = GASFIRE_LAYER)


/obj/machinery/bfl_lens/proc/activate_lens()
	state = TRUE
	update_icon()
	set_light(8)
	working_sound()


/obj/machinery/bfl_lens/proc/deactivate_lens()
	state = FALSE
	update_icon()
	set_light(0)


/obj/machinery/bfl_lens/proc/working_sound()
	set waitfor = FALSE
	while(state)
		playsound(src, 'sound/BFL/receiver.ogg', 100, TRUE)
		sleep(25)


/obj/machinery/bfl_lens/wrench_act(mob/user, obj/item/I)
	. = TRUE
	if(!I.use_tool(src, user, 0, volume = 0))
		return
	if(default_unfasten_wrench(user, I, time = 140))
		var/obj/machinery/bfl_receiver/receiver = locate() in get_turf(src)
		if(receiver)
			receiver.lens = anchored ? src : null

	update_icon()

/obj/machinery/bfl_lens/Initialize()
	. = ..()
	pixel_x = -32
	pixel_y = -32


/obj/machinery/bfl_lens/Destroy()
	visible_message("Lens shatters in a million pieces")
	playsound(src, "shatter", 70, 1)
	return ..()


/obj/machinery/bfl_lens/Move(atom/newloc, direction, movetime)
	. = ..()
	if(!.)
		return
	if(step_count > 5)
		Destroy()
	step_count++
	pixel_x = -32
	pixel_y = -32 //Explictly stating, that pixel_x and pixel_y will ALWAYS be -32/-32 when moved, because moving objects reset their offset.


//everything else
/obj/bfl_crack
	name = "rich plasma deposit"
	can_be_hit = FALSE
	anchored = TRUE
	icon = 'icons/obj/machines/BFL_Mission/Hole.dmi'
	icon_state = "Crack"
	pixel_x = -32
	pixel_y = -32
	layer = HIGH_TURF_LAYER
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

	//space for gps tracker
	var/obj/item/tank/internal
	var/internal_type = /obj/item/gps/internal/bfl_crack

/obj/bfl_crack/Initialize(mapload)
	. = ..()
	internal = new internal_type(src)

/obj/item/gps/internal/bfl_crack
	gpstag = "NT signal"

/obj/structure/toilet/golden_toilet/bfl_goal
	name = "\[NT REDACTED\]"
/obj/singularity/bfl_red
	name = "BFL"
	desc = "Giant laser, which is supposed for mining"
	icon = 'icons/obj/machines/BFL_Mission/Laser.dmi'
	icon_state = "Laser_Red"
	speed_process = TRUE
	var/move = 0
	var/lavaland_z_lvl		// Определяется кодом по имени лаваленда

/obj/singularity/bfl_red/move(force_move)
	if(!move_self)
		return 0

	var/movement_dir = pick(GLOB.alldirs - last_failed_movement)

	if(force_move)
		movement_dir = force_move
		step(src, movement_dir)
	else
		move++
		forceMove(locate((move % 255) + 1, (sin(move + 1) + 1)*125 + 3, lavaland_z_lvl))

/obj/singularity/bfl_red/expand()
	. = ..()
	icon = 'icons/obj/machines/BFL_Mission/Laser.dmi'
	icon_state = "Laser_Red"
	pixel_x = -32
	pixel_y = 0
	grav_pull = 1

/obj/singularity/bfl_red/singularity_act()
	return 0

/obj/singularity/bfl_red/New(loc, var/starting_energy = 50, var/temp = 0)
	starting_energy = 250
	lavaland_z_lvl = level_name_to_num(MINING)
	. = ..(loc, starting_energy, temp)
