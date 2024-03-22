// ---------- ACTIONS FOR ALL SPIDERS
/datum/action/innate/terrorspider
	background_icon_state = "bg_terror"

/datum/action/innate/terrorspider/web
	name = "Web"
	icon_icon = 'icons/effects/effects.dmi'
	button_icon_state = "stickyweb1"

/datum/action/innate/terrorspider/web/Activate()
	var/mob/living/simple_animal/hostile/poison/terror_spider/user = owner
	user.Web()

/datum/action/innate/terrorspider/wrap
	name = "Wrap"
	icon_icon = 'icons/effects/effects.dmi'
	button_icon_state = "cocoon_large1"

/datum/action/innate/terrorspider/wrap/Activate()
	var/mob/living/simple_animal/hostile/poison/terror_spider/user = owner
	user.FindWrapTarget()
	user.DoWrap()

// ---------- GREEN ACTIONS

/datum/action/innate/terrorspider/greeneggs
	name = "Lay Green Eggs"
	icon_icon = 'icons/effects/effects.dmi'
	button_icon_state = "eggs"

/datum/action/innate/terrorspider/greeneggs/Activate()
	var/mob/living/simple_animal/hostile/poison/terror_spider/healer/user = owner
	user.DoLayGreenEggs()

// ---------- KNIGHT ACTIONS
/datum/action/innate/terrorspider/knight/defaultm
	name = "Default"
	icon_icon = 'icons/mob/terrorspider.dmi'
	button_icon_state = "terror_princess1"

/datum/action/innate/terrorspider/knight/defaultm/Activate()
	var/mob/living/simple_animal/hostile/poison/terror_spider/knight/user = owner
	user.activate_mode(0)

/datum/action/innate/terrorspider/knight/attackm
	name = "Rage"
	icon_icon = 'icons/mob/actions/actions.dmi'
	button_icon_state = "attack"

/datum/action/innate/terrorspider/knight/attackm/Activate()
	var/mob/living/simple_animal/hostile/poison/terror_spider/knight/user = owner
	user.activate_mode(1)

/datum/action/innate/terrorspider/knight/defencem
	name = "Keratosis"
	icon_icon = 'icons/mob/actions/actions.dmi'
	button_icon_state = "defence"

/datum/action/innate/terrorspider/knight/defencem/Activate()
	var/mob/living/simple_animal/hostile/poison/terror_spider/knight/user = owner
	user.activate_mode(2)

// ---------- BOSS ACTIONS

/datum/action/innate/terrorspider/ventsmash
	name = "Smash Welded Vent"
	icon_icon = 'icons/obj/pipes_and_stuff/atmospherics/atmos/vent_pump.dmi'
	button_icon_state = "map_vent"

/datum/action/innate/terrorspider/ventsmash/Activate()
	var/mob/living/simple_animal/hostile/poison/terror_spider/user = owner
	user.DoVentSmash()

/datum/action/innate/terrorspider/remoteview
	name = "Remote View"
	icon_icon = 'icons/obj/eyes.dmi'
	button_icon_state = "heye"

/datum/action/innate/terrorspider/remoteview/Activate()
	var/mob/living/simple_animal/hostile/poison/terror_spider/user = owner
	user.DoRemoteView()

// ---------- QUEEN ACTIONS

/datum/action/innate/terrorspider/queen/queennest
	name = "Nest"
	icon_icon = 'icons/mob/terrorspider.dmi'
	button_icon_state = "terror_queen"

/datum/action/innate/terrorspider/queen/queennest/Activate()
	var/mob/living/simple_animal/hostile/poison/terror_spider/queen/user = owner
	user.NestPrompt()

/datum/action/innate/terrorspider/queen/queensense
	name = "Hive Sense"
	icon_icon = 'icons/mob/actions/actions.dmi'
	button_icon_state = "mindswap"

/datum/action/innate/terrorspider/queen/queensense/Activate()
	var/mob/living/simple_animal/hostile/poison/terror_spider/queen/user = owner
	user.DoHiveSense()

/datum/action/innate/terrorspider/queen/queeneggs
	name = "Lay Queen Eggs"
	icon_icon = 'icons/effects/effects.dmi'
	button_icon_state = "eggs"

/datum/action/innate/terrorspider/queen/queeneggs/Activate()
	var/mob/living/simple_animal/hostile/poison/terror_spider/queen/user = owner
	user.LayQueenEggs()


// ---------- EMPRESS

/datum/action/innate/terrorspider/queen/empress/empresserase
	name = "Empress Erase Brood"
	icon_icon = 'icons/effects/blood.dmi'
	button_icon_state = "mgibbl1"

/datum/action/innate/terrorspider/queen/empress/empresserase/Activate()
	var/mob/living/simple_animal/hostile/poison/terror_spider/queen/empress/user = owner
	user.EraseBrood()

/datum/action/innate/terrorspider/queen/empress/empresslings
	name = "Empresss Spiderlings"
	icon_icon = 'icons/effects/effects.dmi'
	button_icon_state = "spiderling"

/datum/action/innate/terrorspider/queen/empress/empresslings/Activate()
	var/mob/living/simple_animal/hostile/poison/terror_spider/queen/empress/user = owner
	user.EmpressLings()


// ---------- WEB

/mob/living/simple_animal/hostile/poison/terror_spider/proc/Web()
	if(!web_type)
		return
	if(!isturf(loc))
		to_chat(src, "<span class='danger'>Webs can only be spun while standing on a floor.</span>")
		return
	var/turf/mylocation = loc
	visible_message("<span class='notice'>[src] begins to secrete a sticky substance.</span>")
	playsound(src.loc, 'sound/creatures/terrorspiders/web.ogg', 50, 1)
	if(do_after(src, delay_web, target = loc))
		if(loc != mylocation)
			return
		else if(istype(loc, /turf/space))
			to_chat(src, "<span class='danger'>Webs cannot be spun in space.</span>")
		else
			var/obj/structure/spider/terrorweb/T = locate() in get_turf(src)
			if(T)
				to_chat(src, "<span class='danger'>There is already a web here.</span>")
			else
				var/obj/structure/spider/terrorweb/W = new web_type(loc)
				W.creator_ckey = ckey

/obj/structure/spider/terrorweb
	name = "terror web"
	desc = "it's stringy and sticky"
	icon = 'icons/effects/effects.dmi'
	anchored = TRUE // prevents people dragging it
	density = 0 // prevents it blocking all movement
	max_integrity = 20 // two welders, or one laser shot (15 for the normal spider webs)
	creates_cover = TRUE
	icon_state = "stickyweb1"
	var/creator_ckey = null

/obj/structure/spider/terrorweb/Initialize(mapload)
	. = ..()
	if(prob(50))
		icon_state = "stickyweb2"


/obj/structure/spider/terrorweb/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()

	if(checkpass(mover))
		return TRUE

	if(istype(mover, /mob/living/simple_animal/hostile/poison/giant_spider) || isterrorspider(mover))
		return TRUE

	if(istype(mover, /obj/item/projectile/terrorspider))
		return TRUE

	if(isliving(mover))
		var/mob/living/living_mover = mover
		if(living_mover.lying)
			return TRUE

		if(prob(80))
			to_chat(mover, span_danger("You get stuck in [src] for a moment."))
			living_mover.Weaken(2 SECONDS) // 2 seconds, wow
			living_mover.Slowed(10 SECONDS)
			if(iscarbon(mover))
				web_special_ability(mover)
			return TRUE

		return FALSE

	if(isprojectile(mover))
		return prob(20)


/obj/structure/spider/terrorweb/bullet_act(obj/item/projectile/Proj)
	if(Proj.damage_type != BRUTE && Proj.damage_type != BURN)
		visible_message("<span class='danger'>[src] is undamaged by [Proj]!</span>")
		// Webs don't care about disablers, tasers, etc. Or toxin damage. They're organic, but not alive.
		return
	..()

/obj/structure/spider/terrorweb/proc/web_special_ability(mob/living/carbon/C)
	return

// ---------- WRAP

/mob/living/simple_animal/hostile/poison/terror_spider/proc/mobIsWrappable(mob/living/M)
	if(!istype(M))
		return FALSE
	if(M.stat != DEAD)
		return FALSE
	if(M.anchored)
		return FALSE
	if(!Adjacent(M))
		return FALSE
	if(isterrorspider(M))
		return FALSE
	return TRUE

/mob/living/simple_animal/hostile/poison/terror_spider/proc/FindWrapTarget()
	if(!cocoon_target)
		var/list/choices = list()
		for(var/mob/living/L in oview(1,src))
			if(!mobIsWrappable(L))
				continue
			choices += L
		for(var/obj/O in oview(1,src))
			if(Adjacent(O) && !O.anchored)
				if(!istype(O, /obj/structure/spider))
					choices += O
		if(choices.len)
			cocoon_target = input(src,"What do you wish to cocoon?") in null|choices
		else
			to_chat(src, "<span class='danger'>There is nothing nearby you can wrap.</span>")

/mob/living/simple_animal/hostile/poison/terror_spider/proc/DoWrap()
	if(cocoon_target && busy != SPINNING_COCOON)
		if(cocoon_target.anchored)
			cocoon_target = null
			return
		busy = SPINNING_COCOON
		visible_message("<span class='notice'>[src] begins to secrete a sticky substance around [cocoon_target].</span>")
		playsound(src.loc, 'sound/creatures/terrorspiders/wrap.ogg', 120, 1)
		stop_automated_movement = 1
		walk(src,0)
		if(do_after(src, 40, target = cocoon_target.loc))
			if(busy == SPINNING_COCOON)
				if(cocoon_target && isturf(cocoon_target.loc) && get_dist(src,cocoon_target) <= 1)
					var/obj/structure/spider/cocoon/C = new(cocoon_target.loc)
					var/large_cocoon = 0
					C.pixel_x = cocoon_target.pixel_x
					C.pixel_y = cocoon_target.pixel_y
					for(var/obj/O in C.loc)
						if(!O.anchored)
							if(istype(O, /obj/item))
								O.loc = C
							else if(istype(O, /obj/machinery))
								O.loc = C
								large_cocoon = 1
							else if(istype(O, /obj/structure) && !istype(O, /obj/structure/spider)) // can't wrap spiderlings/etc
								O.loc = C
								large_cocoon = 1
					for(var/mob/living/L in C.loc)
						if(!mobIsWrappable(L))
							continue
						if(iscarbon(L))
							apply_status_effect(STATUS_EFFECT_TERROR_FOOD_REGEN)
							fed++
							visible_message("<span class='danger'>[src] sticks a proboscis into [L] and sucks a viscous substance out.</span>")
							to_chat(src, "<span class='notice'>You begin to regenerate quickly!</span>")
						else
							visible_message("<span class='danger'>[src] wraps [L] in a web.</span>")
						large_cocoon = 1
						last_cocoon_object = 0
						L.loc = C
						C.pixel_x = L.pixel_x
						C.pixel_y = L.pixel_y
						break
					if(large_cocoon)
						C.icon_state = pick("cocoon_large1","cocoon_large2","cocoon_large3")
		cocoon_target = null
		busy = 0
		stop_automated_movement = 0

/mob/living/simple_animal/hostile/poison/terror_spider/proc/DoVentSmash()
	var/valid_target = FALSE
	for(var/obj/machinery/atmospherics/unary/vent_pump/P in range(1, get_turf(src)))
		if(P.welded)
			valid_target = TRUE
	for(var/obj/machinery/atmospherics/unary/vent_scrubber/C in range(1, get_turf(src)))
		if(C.welded)
			valid_target = TRUE
	if(!valid_target)
		to_chat(src, "<span class='warning'>No welded vent or scrubber nearby!</span>")
		return
	playsound(get_turf(src), 'sound/creatures/terrorspiders/ventbreak.ogg', 75, 0)
	if(do_after(src, 43, target = loc))
		for(var/obj/machinery/atmospherics/unary/vent_pump/P in range(1, get_turf(src)))
			if(P.welded)
				P.welded = 0
				P.update_icon()
				P.update_pipe_image()
				forceMove(P.loc)
				P.visible_message("<span class='danger'>[src] smashes the welded cover off [P]!</span>")
				return
		for(var/obj/machinery/atmospherics/unary/vent_scrubber/C in range(1, get_turf(src)))
			if(C.welded)
				C.welded = 0
				C.update_icon()
				C.update_pipe_image()
				forceMove(C.loc)
				C.visible_message("<span class='danger'>[src] smashes the welded cover off [C]!</span>")
				return
		to_chat(src, "<span class='danger'>There is no welded vent or scrubber close enough to do this.</span>")

