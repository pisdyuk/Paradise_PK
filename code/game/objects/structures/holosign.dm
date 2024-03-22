
//holographic signs and barriers

/obj/structure/holosign
	name = "holo sign"
	icon = 'icons/effects/effects.dmi'
	anchored = TRUE
	max_integrity = 1
	armor = list("melee" = 0, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 20)
	var/obj/item/projector

/obj/structure/holosign/Initialize(mapload, source_projector)
	. = ..()
	if(istype(source_projector, /obj/item/holosign_creator))
		var/obj/item/holosign_creator/holosign = source_projector
		holosign.signs += src
		projector = holosign
	else if(istype(source_projector, /obj/item/mecha_parts/mecha_equipment/holowall))
		var/obj/item/mecha_parts/mecha_equipment/holowall/holoproj = source_projector
		holoproj.barriers += src
		projector = holoproj

/obj/structure/holosign/Destroy()
	if(istype(projector, /obj/item/holosign_creator))
		var/obj/item/holosign_creator/holosign = projector
		holosign.signs -= src
		projector = null
	else if(istype(projector, /obj/item/mecha_parts/mecha_equipment/holowall))
		var/obj/item/mecha_parts/mecha_equipment/holowall/holoproj = projector
		holoproj.barriers -= src
		projector = null
	return ..()

/obj/structure/holosign/has_prints()
	return FALSE

/obj/structure/holosign/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.do_attack_animation(src)
	user.changeNext_move(CLICK_CD_MELEE)
	take_damage(5 , BRUTE, "melee", 1)

/obj/structure/holosign/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(loc, 'sound/weapons/egloves.ogg', 80, TRUE)
		if(BURN)
			playsound(loc, 'sound/weapons/egloves.ogg', 80, TRUE)

/obj/structure/holosign/wetsign
	name = "wet floor sign"
	desc = "The words flicker as if they mean nothing."
	icon_state = "holosign"

/obj/structure/holosign/wetsign/proc/wet_timer_start(obj/item/holosign_creator/HS_C)
	addtimer(CALLBACK(src, PROC_REF(wet_timer_finish), HS_C), 82 SECONDS, TIMER_UNIQUE)

/obj/structure/holosign/wetsign/proc/wet_timer_finish(obj/item/holosign_creator/HS_C)
	playsound(HS_C.loc, 'sound/machines/chime.ogg', 20, 1)
	qdel(src)

/obj/structure/holosign/wetsign/mine
	desc = "The words flicker as if they mean something."

/obj/structure/holosign/wetsign/mine/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(!isliving(AM))
		return
	triggermine(AM)

/obj/structure/holosign/wetsign/mine/proc/triggermine(mob/living/victim)
	empulse(src, 1, 1, TRUE, "[victim] triggered holosign")
	if(ishuman(victim))
		victim.adjustStaminaLoss(100)
	qdel(src)

/obj/structure/holosign/barrier
	name = "holo barrier"
	desc = "A short holographic barrier which can only be passed by walking."
	icon_state = "holosign_sec"
	pass_flags_self = PASSTABLE|PASSGRILLE|PASSGLASS|LETPASSTHROW
	density = TRUE
	max_integrity = 20
	var/allow_walk = TRUE //can we pass through it on walk intent


/obj/structure/holosign/barrier/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(.)
		return TRUE
	if(iscarbon(mover))
		var/mob/living/carbon/carbon_mover = mover
		if(allow_walk && (carbon_mover.m_intent == MOVE_INTENT_WALK || carbon_mover.pulledby?.m_intent == MOVE_INTENT_WALK))
			return TRUE
	else if(issilicon(mover))
		var/mob/living/silicon/silicon_mover = mover
		if(allow_walk && (silicon_mover.m_intent == MOVE_INTENT_WALK || silicon_mover.pulledby?.m_intent == MOVE_INTENT_WALK))
			return TRUE


/obj/structure/holosign/barrier/engineering
	icon_state = "holosign_engi"

/obj/structure/holosign/barrier/atmos
	name = "holo firelock"
	desc = "A holographic barrier resembling a firelock. Though it does not prevent solid objects from passing through, gas is kept out."
	icon_state = "holo_firelock"
	density = FALSE
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	alpha = 150

/obj/structure/holosign/barrier/atmos/Initialize(mapload)
	. = ..()
	air_update_turf(TRUE)

/obj/structure/holosign/barrier/atmos/CanAtmosPass(turf/T)
	return FALSE

/obj/structure/holosign/barrier/atmos/Destroy()
	var/turf/T = get_turf(src)
	. = ..()
	T.air_update_turf(TRUE)

/obj/structure/holosign/barrier/cyborg
	name = "Energy Field"
	desc = "A fragile energy field that blocks movement. Excels at blocking lethal projectiles."
	density = TRUE
	max_integrity = 10
	allow_walk = FALSE

/obj/structure/holosign/barrier/cyborg/bullet_act(obj/item/projectile/P)
	take_damage((P.damage / 5) , BRUTE, "melee", 1)	//Doesn't really matter what damage flag it is.
	if(istype(P, /obj/item/projectile/energy/electrode))
		take_damage(10, BRUTE, "melee", 1)	//Tasers aren't harmful.
	if(istype(P, /obj/item/projectile/beam/disabler))
		take_damage(5, BRUTE, "melee", 1)	//Disablers aren't harmful.

/obj/structure/holosign/barrier/cyborg/hacked
	name = "Charged Energy Field"
	desc = "A powerful energy field that blocks movement. Energy arcs off it."
	max_integrity = 20
	var/shockcd = 0

/obj/structure/holosign/barrier/cyborg/hacked/bullet_act(obj/item/projectile/P)
	take_damage(P.damage, BRUTE, "melee", 1)	//Yeah no this doesn't get projectile resistance.

/obj/structure/holosign/barrier/cyborg/hacked/proc/cooldown()
	shockcd = FALSE

/obj/structure/holosign/barrier/cyborg/hacked/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(!shockcd)
		if(isliving(user))
			var/mob/living/M = user
			M.electrocute_act(15, "Energy Barrier", safety = TRUE)
			shockcd = TRUE
			addtimer(CALLBACK(src, PROC_REF(cooldown)), 5)

/obj/structure/holosign/barrier/cyborg/hacked/Bumped(atom/movable/moving_atom)
	..()

	if(shockcd)
		return

	if(!isliving(moving_atom))
		return

	var/mob/living/M = moving_atom
	M.electrocute_act(15, "Energy Barrier", safety = TRUE)
	shockcd = TRUE
	addtimer(CALLBACK(src, PROC_REF(cooldown)), 5)
