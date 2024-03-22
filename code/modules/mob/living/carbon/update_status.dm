/mob/living/carbon/update_stat(reason = "none given", should_log = FALSE)
	if(status_flags & GODMODE)
		return ..()
	if(stat != DEAD)
		if(health <= HEALTH_THRESHOLD_DEAD && check_death_method())
			death()
			return
		if(IsParalyzed() || IsSleeping() || (check_death_method() && getOxyLoss() > 50) || HAS_TRAIT(src, TRAIT_FAKEDEATH) || health <= HEALTH_THRESHOLD_CRIT && check_death_method())
			if(stat == CONSCIOUS)
				KnockOut()
		else
			if(stat == UNCONSCIOUS)
				WakeUp()
	..()

/mob/living/carbon/update_stamina()
	var/stam = getStaminaLoss()
	if(stam > DAMAGE_PRECISION && (maxHealth - stam) <= HEALTH_THRESHOLD_CRIT && !stat)
		enter_stamcrit()
	else if(stam_paralyzed)
		stam_paralyzed = FALSE
		update_canmove()

/mob/living/carbon/can_hear()
	. = ..()
	var/obj/item/organ/internal/ears/ears = get_organ_slot(INTERNAL_ORGAN_EARS)
	if(!ears)
		return FALSE

