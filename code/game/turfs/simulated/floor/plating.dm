/turf/simulated/floor/plating
	name = "plating"
	icon_state = "plating"
	icon = 'icons/turf/floors/plating.dmi'
	intact = FALSE
	floor_tile = null

	var/unfastened = FALSE

	footstep = FOOTSTEP_PLATING
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	real_layer = PLATING_LAYER

/turf/simulated/floor/plating/Initialize(mapload)
	. = ..()
	icon_plating = icon_state
	update_icon()

/turf/simulated/floor/plating/broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/turf/simulated/floor/plating/burnt_states()
	return list("floorscorched1", "floorscorched2")

/turf/simulated/floor/plating/damaged/Initialize(mapload)
	. = ..()
	break_tile()

/turf/simulated/floor/plating/burnt/Initialize(mapload)
	. = ..()
	burn_tile()

/turf/simulated/floor/plating/update_icon_state()
	if(!broken && !burnt)
		icon_state = icon_plating //Because asteroids are 'platings' too.

/turf/simulated/floor/plating/examine(mob/user)
	. = ..()

	if(unfastened)
		. += span_warning("It has been unfastened.")

/turf/simulated/floor/plating/attackby(obj/item/C, mob/user, params)
	if(..())
		return TRUE

	if(istype(C, /obj/item/stack/rods))
		if(broken || burnt)
			to_chat(user, span_warning("Repair the plating first!"))
			return TRUE
		var/obj/item/stack/rods/R = C
		if(R.get_amount() < 2)
			to_chat(user, span_warning("You need two rods to make a reinforced floor!"))
			return TRUE
		else
			to_chat(user, span_notice("You begin reinforcing the floor..."))
			if(do_after(user, 30 * C.toolspeed * gettoolspeedmod(user), target = src))
				if(R.get_amount() >= 2 && !istype(src, /turf/simulated/floor/engine))
					ChangeTurf(/turf/simulated/floor/engine)
					playsound(src, C.usesound, 80, 1)
					R.use(2)
					to_chat(user, span_notice("You reinforce the floor."))
				return TRUE

	else if(istype(C, /obj/item/stack/tile))
		if(!broken && !burnt)
			var/obj/item/stack/tile/W = C
			if(!W.use(1))
				return
			ChangeTurf(W.turf_type)
			playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
		else
			to_chat(user, span_warning("This section is too damaged to support a tile! Use a welder to fix the damage."))
		return TRUE

	else if(is_glass_sheet(C))
		if(broken || burnt)
			to_chat(user, span_warning("Repair the plating first!"))
			return TRUE
		var/obj/item/stack/sheet/R = C
		if(R.get_amount() < 2)
			to_chat(user, span_warning("You need two sheets to build a [C.name] floor!"))
			return TRUE
		to_chat(user, span_notice("You begin swapping the plating for [C]..."))
		if(do_after(user, 3 SECONDS * C.toolspeed * gettoolspeedmod(user), target = src))
			if(R.get_amount() >= 2 && !transparent_floor)
				if(istype(C, /obj/item/stack/sheet/plasmaglass)) //So, what type of glass floor do we want today?
					ChangeTurf(/turf/simulated/floor/transparent/glass/plasma)
				else if(istype(C, /obj/item/stack/sheet/plasmarglass))
					ChangeTurf(/turf/simulated/floor/transparent/glass/reinforced/plasma)
				else if(istype(C, /obj/item/stack/sheet/glass))
					ChangeTurf(/turf/simulated/floor/transparent/glass)
				else if(istype(C, /obj/item/stack/sheet/rglass))
					ChangeTurf(/turf/simulated/floor/transparent/glass/reinforced)
				else if(istype(C, /obj/item/stack/sheet/titaniumglass))
					ChangeTurf(/turf/simulated/floor/transparent/glass/titanium)
				else if(istype(C, /obj/item/stack/sheet/plastitaniumglass))
					ChangeTurf(/turf/simulated/floor/transparent/glass/titanium/plasma)
				playsound(src, C.usesound, 80, TRUE)
				R.use(2)
				to_chat(user, span_notice("You swap the plating for [C]."))
				new /obj/item/stack/sheet/metal(src, 2)
			return TRUE

/turf/simulated/floor/plating/screwdriver_act(mob/user, obj/item/I)
	. = TRUE
	if(!I.tool_use_check(user, 0))
		return
	to_chat(user, span_notice("You start [unfastened ? "fastening" : "unfastening"] [src]."))
	. = TRUE
	if(!I.use_tool(src, user, 20, volume = I.tool_volume))
		return
	to_chat(user, span_notice("You [unfastened ? "fasten" : "unfasten"] [src]."))
	unfastened = !unfastened

/turf/simulated/floor/plating/welder_act(mob/user, obj/item/I)
	if(!broken && !burnt && !unfastened)
		return
	. = TRUE
	if(!I.tool_use_check(user, 0))
		return
	if(unfastened)
		to_chat(user, span_warning("You start removing [src], exposing space after you're done!"))
		if(!I.use_tool(src, user, 50, volume = I.tool_volume * 2)) //extra loud to let people know something's going down
			return
		new /obj/item/stack/tile/plasteel(get_turf(src))
		remove_plating(user)
		return
	if(I.use_tool(src, user, volume = I.tool_volume)) //If we got this far, something needs fixing
		to_chat(user, span_notice("You fix some dents on the broken plating."))
		cut_overlay(current_overlay)
		current_overlay = null
		burnt = FALSE
		broken = FALSE
		update_icon()

/turf/simulated/floor/plating/remove_plating(mob/user)
	if(baseturf == /turf/space)
		ReplaceWithLattice()
	else
		TerraformTurf(baseturf)

/turf/simulated/floor/plating/airless
	icon_state = "plating"
	name = "airless plating"
	oxygen = 0
	nitrogen = 0
	temperature = TCMB

/turf/simulated/floor/plating/airless/Initialize(mapload)
	. = ..()
	name = "plating"

/turf/simulated/floor/engine
	name = "reinforced floor"
	icon_state = "engine"
	thermal_conductivity = 0.025
	var/insulated
	heat_capacity = 325000
	floor_tile = /obj/item/stack/rods
	footstep = FOOTSTEP_PLATING
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/simulated/floor/engine/break_tile()
	return //unbreakable

/turf/simulated/floor/engine/burn_tile()
	return //unburnable

/turf/simulated/floor/engine/make_plating(make_floor_tile = FALSE, mob/user, force = FALSE)
	if(force)
		..(make_floor_tile, user)
	return //unplateable

/turf/simulated/floor/engine/attack_hand(mob/user)
	user.Move_Pulled(src)

/turf/simulated/floor/engine/pry_tile(obj/item/C, mob/user, silent = FALSE)
	return

/turf/simulated/floor/engine/acid_act(acidpwr, acid_volume)
	acidpwr = min(acidpwr, 50) //we reduce the power so reinf floor never get melted.
	. = ..()

/turf/simulated/floor/engine/attackby(obj/item/C, mob/user, params)
	if(!C || !user)
		return
	if(C.tool_behaviour == TOOL_WRENCH)
		to_chat(user, span_notice("You begin removing rods..."))
		playsound(src, C.usesound, 80, 1)
		if(do_after(user, 30 * C.toolspeed * gettoolspeedmod(user), target = src))
			if(!istype(src, /turf/simulated/floor/engine))
				return
			new /obj/item/stack/rods(src, 2)
			make_plating(make_floor_tile = FALSE, force = TRUE)
			return

	if(istype(C, /obj/item/stack/sheet/plasteel) && !insulated) //Insulating the floor
		to_chat(user, span_notice("You begin insulating [src]..."))
		if(do_after(user, 40, target = src) && !insulated) //You finish insulating the insulated insulated insulated insulated insulated insulated insulated insulated vacuum floor
			to_chat(user, span_notice("You finish insulating [src]."))
			var/obj/item/stack/sheet/plasteel/W = C
			W.use(1)
			thermal_conductivity = 0
			insulated = 1
			name = "insulated " + name
			return

/turf/simulated/floor/engine/ex_act(severity)
	switch(severity)
		if(1)
			ChangeTurf(baseturf)
		if(2)
			if(prob(50))
				ChangeTurf(baseturf)

/turf/simulated/floor/engine/blob_act(obj/structure/blob/B)
	if(prob(25))
		ChangeTurf(baseturf)

/turf/simulated/floor/engine/cult
	name = "engraved floor"
	icon_state = "cult"
	var/holy = FALSE


/turf/simulated/floor/engine/cult/Initialize(mapload)
	. = ..()
	update_icon(UPDATE_ICON_STATE)


/turf/simulated/floor/engine/cult/update_icon_state()
	if(SSticker?.cultdat && !holy)
		icon_state = SSticker.cultdat.cult_floor_icon_state
		return
	icon_state = initial(icon_state)


/turf/simulated/floor/engine/cult/narsie_act()
	return

/turf/simulated/floor/engine/cult/ratvar_act()
	. = ..()
	if(istype(src, /turf/simulated/floor/engine/cult)) //if we haven't changed type
		var/previouscolor = color
		color = "#FAE48C"
		animate(src, color = previouscolor, time = 8)

/turf/simulated/floor/engine/cult/holy
	icon_state = "holy"
	holy = TRUE

//air filled floors; used in atmos pressure chambers

/turf/simulated/floor/engine/n20
	name = "\improper N2O floor"
	sleeping_agent = 6000
	oxygen = 0
	nitrogen = 0

/turf/simulated/floor/engine/co2
	name = "\improper CO2 floor"
	carbon_dioxide = 50000
	oxygen = 0
	nitrogen = 0

/turf/simulated/floor/engine/plasma
	name = "plasma floor"
	toxins = 70000
	oxygen = 0
	nitrogen = 0

/turf/simulated/floor/engine/o2
	name = "\improper O2 floor"
	oxygen = 100000
	nitrogen = 0

/turf/simulated/floor/engine/n2
	name = "\improper N2 floor"
	nitrogen = 100000
	oxygen = 0

/turf/simulated/floor/engine/air
	name = "air floor"
	oxygen = 2644
	nitrogen = 10580


/turf/simulated/floor/engine/singularity_pull(S, current_size)
	if(current_size >= STAGE_FIVE)
		if(floor_tile)
			if(prob(30))
				make_plating(make_floor_tile = TRUE, force = TRUE)
		else if(prob(30))
			ReplaceWithLattice()

/turf/simulated/floor/engine/vacuum
	name = "vacuum floor"
	icon_state = "engine"
	oxygen = 0
	nitrogen = 0
	temperature = TCMB

/turf/simulated/floor/engine/insulated
	name = "insulated reinforced floor"
	icon_state = "engine"
	insulated = 1
	thermal_conductivity = 0

/turf/simulated/floor/engine/insulated/vacuum
	name = "insulated vacuum floor"
	icon_state = "engine"
	oxygen = 0
	nitrogen = 0

/turf/simulated/floor/plating/ironsand
	name = "Iron Sand"
	icon = 'icons/turf/floors/ironsand.dmi'
	icon_state = "ironsand1"

/turf/simulated/floor/plating/ironsand/Initialize(mapload)
	. = ..()
	icon_state = "ironsand[rand(1,15)]"

/turf/simulated/floor/plating/ironsand/remove_plating()
	return

/turf/simulated/floor/plating/snow
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	icon_state = "snow"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/simulated/floor/plating/snow/ex_act(severity)
	return

/turf/simulated/floor/plating/snow/remove_plating()
	return

/turf/simulated/floor/snow
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	icon_state = "snow"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/simulated/floor/snow/ex_act(severity)
	return

/turf/simulated/floor/snow/pry_tile(obj/item/C, mob/user, silent = FALSE)
	return

/turf/simulated/floor/plating/metalfoam
	name = "foamed metal plating"
	icon_state = "metalfoam"
	var/metal = MFOAM_ALUMINUM

/turf/simulated/floor/plating/metalfoam/iron
	icon_state = "ironfoam"
	metal = MFOAM_IRON

/turf/simulated/floor/plating/metalfoam/update_icon_state()
	switch(metal)
		if(MFOAM_ALUMINUM)
			icon_state = "metalfoam"
		if(MFOAM_IRON)
			icon_state = "ironfoam"

/turf/simulated/floor/plating/metalfoam/attackby(var/obj/item/C, mob/user, params)
	if(..())
		return TRUE

	if(istype(C, /obj/item/stack/sheet/metal))
		var/obj/item/stack/sheet/metal/metal = C
		if(metal.get_amount() < 2)
			to_chat(user, span_warning("You need at least 2 [metal] to make a plating!"))
			return TRUE
		else
			to_chat(user, span_notice("You begin swapping the plating for [metal]..."))
			if(do_after(user, 3 SECONDS * metal.toolspeed * gettoolspeedmod(user), target = src))
				if(metal.get_amount() >= 2)
					ChangeTurf(/turf/simulated/floor/plating, FALSE, FALSE)
					playsound(src, metal.usesound, 80, TRUE)
					metal.use(2)
					to_chat(user, span_notice("You swap the plating for [metal]."))
				return TRUE

	if(istype(C) && C.force)
		user.changeNext_move(CLICK_CD_MELEE)
		user.do_attack_animation(src)
		var/smash_prob = max(0, C.force*17 - metal*25) // A crowbar will have a 60% chance of a breakthrough on alum, 35% on iron
		if(prob(smash_prob))
			// YAR BE CAUSIN A HULL BREACH
			visible_message(span_danger("[user] smashes through \the [src] with \the [C]!"))
			smash()
		else
			visible_message(span_warning("[user]'s [C.name] bounces against \the [src]!"))

/turf/simulated/floor/plating/metalfoam/attack_animal(mob/living/simple_animal/M)
	M.do_attack_animation(src)
	if(M.melee_damage_upper == 0)
		M.visible_message(span_notice("[M] nudges \the [src]."))
	else
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 50, 1, 1)
		M.visible_message(span_danger("\The [M] [M.attacktext] [src]!"))
		smash(src)

/turf/simulated/floor/plating/metalfoam/attack_alien(mob/living/carbon/alien/humanoid/M)
	M.visible_message(span_danger("[M] tears apart \the [src]!"))
	smash(src)

/turf/simulated/floor/plating/metalfoam/burn_tile()
	smash()

/turf/simulated/floor/plating/metalfoam/proc/smash()
	ChangeTurf(baseturf)

/turf/simulated/floor/plating/ice
	name = "ice sheet"
	desc = "A sheet of solid ice. Looks slippery."
	icon = 'icons/turf/floors/ice_turfs.dmi'
	icon_state = "unsmooth"
	oxygen = 22
	nitrogen = 82
	temperature = 180
	baseturf = /turf/simulated/floor/plating/ice
	slowdown = TRUE
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/simulated/floor/plating/ice/smooth, /turf/simulated/floor/plating/ice)

/turf/simulated/floor/plating/ice/Initialize(mapload)
	. = ..()
	MakeSlippery(TURF_WET_PERMAFROST, INFINITY)

/turf/simulated/floor/plating/ice/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/simulated/floor/plating/ice/smooth
	icon_state = "smooth"
	smooth = SMOOTH_MORE | SMOOTH_BORDER
	canSmoothWith = list(/turf/simulated/floor/plating/ice/smooth, /turf/simulated/floor/plating/ice)
