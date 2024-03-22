#define GHETTO_DISINFECT_AMOUNT 5 //Amount of units to transfer from the container to the organs during ghetto surgery disinfection step

/datum/surgery/organ_manipulation
	name = "Organ Manipulation"
	steps = list(/datum/surgery_step/generic/cut_open,/datum/surgery_step/generic/clamp_bleeders, /datum/surgery_step/generic/retract_skin, /datum/surgery_step/open_encased/saw,
	/datum/surgery_step/open_encased/retract, /datum/surgery_step/internal/manipulate_organs, /datum/surgery_step/glue_bone, /datum/surgery_step/set_bone,/datum/surgery_step/finish_bone,/datum/surgery_step/generic/cauterize)
	possible_locs = list(
		BODY_ZONE_CHEST,
		BODY_ZONE_HEAD,
	)
	requires_organic_bodypart = 1

/datum/surgery/organ_manipulation/soft
	possible_locs = list(BODY_ZONE_PRECISE_GROIN, BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH)
	steps = list(/datum/surgery_step/generic/cut_open,/datum/surgery_step/generic/clamp_bleeders, /datum/surgery_step/generic/retract_skin, /datum/surgery_step/internal/manipulate_organs,/datum/surgery_step/generic/cauterize)
	requires_organic_bodypart = 1

/datum/surgery/organ_manipulation_boneless
	name = "Organ Manipulation"
	possible_locs = list(
		BODY_ZONE_CHEST,
		BODY_ZONE_HEAD,
		BODY_ZONE_PRECISE_GROIN,
		BODY_ZONE_PRECISE_EYES,
		BODY_ZONE_PRECISE_MOUTH,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
		BODY_ZONE_TAIL,
	)
	steps = list(/datum/surgery_step/generic/cut_open,/datum/surgery_step/generic/clamp_bleeders, /datum/surgery_step/generic/retract_skin, /datum/surgery_step/internal/manipulate_organs,/datum/surgery_step/generic/cauterize)
	requires_organic_bodypart = 1

/datum/surgery/organ_manipulation/plasmaman
	name = "Plasmaman Organ Manipulation"
	steps = list(/datum/surgery_step/generic/cut_open,/datum/surgery_step/generic/clamp_bleeders, /datum/surgery_step/generic/retract_skin, /datum/surgery_step/open_encased/saw,
	/datum/surgery_step/open_encased/retract, /datum/surgery_step/internal/manipulate_organs, /datum/surgery_step/glue_bone/plasma, /datum/surgery_step/generic/cauterize)
	possible_locs = list(
		BODY_ZONE_CHEST,
		BODY_ZONE_HEAD,
	)
	requires_organic_bodypart = 1

/datum/surgery/organ_manipulation/plasmaman/soft
	possible_locs = list(
		BODY_ZONE_PRECISE_GROIN,
		BODY_ZONE_PRECISE_EYES,
		BODY_ZONE_PRECISE_MOUTH,
	)
	steps = list(/datum/surgery_step/generic/cut_open,/datum/surgery_step/generic/clamp_bleeders, /datum/surgery_step/generic/retract_skin, /datum/surgery_step/internal/manipulate_organs,/datum/surgery_step/generic/cauterize)
	requires_organic_bodypart = 1

/datum/surgery/organ_manipulation/insect
	name = "Insectoid Organ Manipulation"
	steps = list(/datum/surgery_step/open_encased/saw, /datum/surgery_step/generic/retract_skin, /datum/surgery_step/generic/cut_open, /datum/surgery_step/generic/retract_skin,
	/datum/surgery_step/generic/clamp_bleeders, /datum/surgery_step/internal/manipulate_organs, /datum/surgery_step/glue_bone, /datum/surgery_step/set_bone,/datum/surgery_step/finish_bone,/datum/surgery_step/generic/cauterize)
	possible_locs = list(
		BODY_ZONE_CHEST,
		BODY_ZONE_HEAD,
		BODY_ZONE_PRECISE_GROIN,
	)
	requires_organic_bodypart = 1

/datum/surgery/organ_manipulation/insect/soft
	possible_locs = list(
		BODY_ZONE_PRECISE_EYES,
		BODY_ZONE_PRECISE_MOUTH,
	)
	steps = list(/datum/surgery_step/generic/cut_open,/datum/surgery_step/generic/clamp_bleeders, /datum/surgery_step/generic/retract_skin, /datum/surgery_step/internal/manipulate_organs,/datum/surgery_step/generic/cauterize)
	requires_organic_bodypart = 1

/datum/surgery/organ_manipulation/alien
	name = "Alien Organ Manipulation"
	possible_locs = list(
		BODY_ZONE_CHEST,
		BODY_ZONE_HEAD,
		BODY_ZONE_PRECISE_GROIN,
		BODY_ZONE_PRECISE_EYES,
		BODY_ZONE_PRECISE_MOUTH,
	)
	allowed_mob = list(/mob/living/carbon/alien/humanoid)
	steps = list(/datum/surgery_step/saw_carapace,/datum/surgery_step/cut_carapace, /datum/surgery_step/retract_carapace,/datum/surgery_step/internal/manipulate_organs)


/datum/surgery/organ_manipulation/can_start(mob/user, mob/living/carbon/target)
	if(istype(target,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = target
		var/obj/item/organ/external/affected = H.get_organ(user.zone_selected)
		if(isplasmaman(H) || iskidan(H) || iswryn(H))
			return FALSE
		if(!affected)
			// I'd like to see you do surgery on LITERALLY NOTHING
			return FALSE
		if(affected.is_robotic())
			return FALSE
		if(!affected.encased) //no bone, problem.
			return FALSE
		return TRUE

/datum/surgery/organ_manipulation_boneless/can_start(mob/user, mob/living/carbon/target)
	if(istype(target,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = target
		var/obj/item/organ/external/affected = H.get_organ(user.zone_selected)

		if(affected && affected.is_robotic())
			return FALSE//no operating on robotic limbs in an organic surgery
		if(!affected)
			// I'd like to see you do surgery on LITERALLY NOTHING
			return FALSE

		if(affected && affected.encased) //no bones no problem.
			return FALSE
		return TRUE

/datum/surgery/organ_manipulation/alien/can_start(mob/user, mob/living/carbon/target)
	if(istype(target,/mob/living/carbon/alien/humanoid))
		return TRUE
	else return FALSE

/datum/surgery/organ_manipulation/plasmaman/can_start(mob/user, mob/living/carbon/target)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/obj/item/organ/external/affected = H.get_organ(user.zone_selected)
		if(!affected)
			return FALSE
		if(affected.is_robotic())
			return FALSE
		if(!affected.encased)
			return FALSE
		if(isplasmaman(H))
			return TRUE
	return FALSE

/datum/surgery/organ_manipulation/insect/can_start(mob/user, mob/living/carbon/target)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/obj/item/organ/external/affected = H.get_organ(user.zone_selected)
		if(!affected)
			return FALSE
		if(affected.is_robotic())
			return FALSE
		if(!affected.encased)
			return FALSE
		if(iswryn(H) || iskidan(H))
			return TRUE
	return FALSE


// Internal surgeries.
/datum/surgery_step/internal
	priority = 2
	can_infect = 1
	blood_level = 1


/datum/surgery_step/internal/manipulate_organs
	name = "manipulate organs"
	allowed_tools = list(/obj/item/organ/internal = 100, /obj/item/reagent_containers/food/snacks/organ = 0)
	var/implements_extract = list(/obj/item/hemostat = 100, /obj/item/kitchen/utensil/fork = 70)
	var/implements_mend = list(/obj/item/stack/medical/bruise_pack = 20,/obj/item/stack/medical/bruise_pack/advanced = 100,/obj/item/stack/nanopaste = 100)
	var/implements_clean = list(/obj/item/reagent_containers/dropper = 100,
                				/obj/item/reagent_containers/syringe = 100,
								/obj/item/reagent_containers/glass/bottle = 90,
								/obj/item/reagent_containers/food/drinks/drinkingglass = 85,
								/obj/item/reagent_containers/food/drinks/bottle = 80,
								/obj/item/reagent_containers/glass/beaker = 75,
								/obj/item/reagent_containers/spray = 60,
								/obj/item/reagent_containers/glass/bucket = 50)

	//Finish is just so you can close up after you do other things.
	var/implements_finsh = list(/obj/item/scalpel/laser/manager = 100,/obj/item/retractor = 100 ,/obj/item/crowbar = 90)
	var/current_type
	var/obj/item/organ/internal/I = null
	var/obj/item/organ/external/affected = null
	time = 64

/datum/surgery_step/internal/manipulate_organs/New()
	..()
	allowed_tools = allowed_tools + implements_extract + implements_mend + implements_clean + implements_finsh


/datum/surgery_step/internal/manipulate_organs/begin_step(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	I = null
	var/mob/living/carbon/human/H
	if(ishuman(target))
		H = target
		affected = H.get_organ(target_zone)

	if(is_int_organ(tool))
		current_type = "insert"
		I = tool

		if(target_zone != I.parent_organ_zone || target.get_organ_slot(I.slot))
			to_chat(user, "<span class='notice'>There is no room for [I] in [target]'s [parse_zone(target_zone)]!</span>")
			return -1

		if((RUNIC_MIND in target.dna.species.species_traits) && istype(I, /obj/item/organ/internal/brain) && !istype(I, /obj/item/organ/internal/brain/golem))
			to_chat(user, "<span class='notice'>There is no room for [I] in [target]'s [parse_zone(target_zone)]!</span>")
			return -1

		if(I.damage > (I.max_damage * 0.75))
			to_chat(user, "<span class='notice'>[I] is in no state to be transplanted.</span>")
			return -1

		if(target.get_int_organ(I) && !affected)
			to_chat(user, "<span class='warning'>[target] already has [I].</span>")
			return -1

		if(affected)
			user.visible_message("[user] starts transplanting [tool] into [target]'s [affected.name].", \
				"You start transplanting [tool] into [target]'s [affected.name].")
			H.custom_pain("Someone's rooting around in your [affected.name]!")
		else
			user.visible_message("[user] starts transplanting [tool] into [target]'s [parse_zone(target_zone)].", \
				"You start transplanting [tool] into [target]'s [parse_zone(target_zone)].")

	else if(implement_type in implements_clean)
		current_type = "clean"

		if(!istype(tool, /obj/item/reagent_containers))
			return

		var/obj/item/reagent_containers/C = tool

		if(C.reagents.has_reagent("mitocholide", 5))
			var/list/dead_organs = list()

			for(var/obj/item/organ/internal/organ as anything in affected.internal_organs)
				if(organ.is_dead())
					dead_organs[organ] = organ.name
			if(dead_organs.len >= 1)
				if(dead_organs.len == 1)
					I = dead_organs[1]
				else
					I = input("Choose organ to rejuvenate:", "Rejuvenation", null, null) as null|anything in dead_organs
				if(istype(C,/obj/item/reagent_containers/syringe))
					user.visible_message("[user] begins injecting [tool] into [target]'s [I.name].", \
						"You begin injecting [tool] into [target]'s [I.name].")
				else
					user.visible_message("[user] starts pouring some of [tool] over [target]'s [I.name].", \
						"You start pouring some of [tool] over [target]'s [I.name].")
			else
				user.visible_message("[user] notices that no dead organs in [target]'s [affected.name].", \
					"You notice that no dead organs in [target]'s [affected.name].")
			return FALSE
		if(C.reagents.has_reagent("mitocholide"))
			user.visible_message("[user] notices there is not enough mitocholide in [tool].", \
				"You notice there is not enough mitocholide in [tool].")
			return FALSE
		if(C.reagents.total_volume <= 0) //end_step handles if there is not enough reagent
			user.visible_message("[user] notices [tool] is empty.", "You notice [tool] is empty.")
			return FALSE

		for(var/obj/item/organ/internal/organ as anything in affected.internal_organs)
			var/msg = "[user] starts pouring some of [tool] over [target]'s [organ.name]."
			var/self_msg = "You start pouring some of [tool] over [target]'s [organ.name]."
			if(istype(C,/obj/item/reagent_containers/syringe))
				msg = "[user] begins injecting [tool] into [target]'s [organ.name]."
				self_msg = "You begin injecting [tool] into [target]'s [organ.name]."
			user.visible_message(msg, self_msg)
			if(H && affected)
				H.custom_pain("Something burns horribly in your [affected.name]!")

	else if(implement_type in implements_finsh)
	//same as surgery step /datum/surgery_step/open_encased/close/
		current_type = "finish"

		if(affected && affected.encased)
			var/msg = "[user] starts bending [target]'s [affected.encased] back into place with [tool]."
			var/self_msg = "You start bending [target]'s [affected.encased] back into place with [tool]."
			user.visible_message(msg, self_msg)
		else
			var/msg = "[user] starts pulling [target]'s skin back into place with [tool]."
			var/self_msg = "You start pulling [target]'s skin back into place with [tool]."
			user.visible_message(msg, self_msg)

		if(H && affected)
			H.custom_pain("Something hurts horribly in your [affected.name]!")

	else if(implement_type in implements_extract)
		current_type = "extract"
		var/list/organs = target.get_organs_zone(target_zone)
		var/mob/living/simple_animal/borer/B = target.has_brain_worms()
		if(target_zone == BODY_ZONE_HEAD && B)
			user.visible_message("[user] begins to extract [B] from [target]'s [parse_zone(target_zone)].",
				"<span class='notice'>You begin to extract [B] from [target]'s [parse_zone(target_zone)]...</span>")
			return TRUE
		if(!organs.len)
			to_chat(user, "<span class='notice'>There are no removeable organs in [target]'s [parse_zone(target_zone)]!</span>")
			return -1

		for(var/obj/item/organ/internal/O as anything in organs)
			if(O.unremovable)
				continue
			O.on_find(user)
			organs -= O
			organs[O.name] = O

		I = tgui_input_list(user, "Remove which organ?", "Surgery", organs)
		if(I && user && target && user.Adjacent(target) && user.get_active_hand() == tool)
			I = organs[I]
			if(!I)
				return -1
			user.visible_message("[user] starts to separate [target]'s [I] with [tool].", \
				"You start to separate [target]'s [I] with [tool] for removal.")
			if(H && affected)
				H.custom_pain("The pain in your [affected.name] is living hell!")
		else
			return -1

	else if(implement_type in implements_mend)
		current_type = "mend"
		var/tool_name = "[tool]"
		if(istype(tool, /obj/item/stack/medical/bruise_pack))
			tool_name = "the bandaid"
		if(istype(tool, /obj/item/stack/medical/bruise_pack/advanced))
			tool_name = "regenerative membrane"
		else if(istype(tool, /obj/item/stack/nanopaste))
			tool_name = "[tool.name]" //what else do you call nanopaste medically?

		if(!hasorgans(target))
			to_chat(user, "They do not have organs to mend!")
			return

		for(var/obj/item/organ/internal/organ as anything in affected.internal_organs)
			if(organ.damage)
				var/can_treat_robotic = organ.is_robotic() && istype(tool, /obj/item/stack/nanopaste)
				var/can_treat_organic = !organ.is_robotic() && !istype(tool, /obj/item/stack/nanopaste)
				if(can_treat_robotic || can_treat_organic)
					if(organ.is_dead())
						to_chat(user, "<span class='warning'>You can't treat [organ]! Dead organs can't be treated with [tool_name]!</span>")
						continue
					user.visible_message("[user] starts treating damage to [target]'s [organ.name] with [tool_name].", \
						"You start treating damage to [target]'s [organ.name] with [tool_name].")
					if(can_treat_organic && !organ.sterile)
						spread_germs_to_organ(organ, user, tool)
				else
					to_chat(user, "[organ] can't be treated with [tool_name].")

			else
				to_chat(user, "[organ] does not appear to be damaged.")

		if(affected)
			H.custom_pain("The pain in your [affected.name] is living hell!")

	else if(istype(tool, /obj/item/reagent_containers/food/snacks/organ))
		to_chat(user, "<span class='warning'>[tool] was bitten by someone! It's too damaged to use!</span>")
		return -1

	..()

/datum/surgery_step/internal/manipulate_organs/end_step(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool,datum/surgery/surgery)
	if(current_type == "mend")
		var/tool_name = "[tool]"
		if(istype(tool, /obj/item/stack/medical/bruise_pack))
			tool_name = "the bandaid"
		if(istype(tool, /obj/item/stack/medical/bruise_pack/advanced))
			tool_name = "regenerative membrane"
		if(istype(tool, /obj/item/stack/nanopaste))
			tool_name = "[tool.name]" //what else do you call nanopaste medically?

		if(!hasorgans(target))
			return

		for(var/obj/item/organ/internal/organ as anything in affected.internal_organs)
			var/treated_robotic = organ.is_robotic() && istype(tool, /obj/item/stack/nanopaste)
			var/treated_organic = !organ.is_robotic() && !istype(tool, /obj/item/stack/nanopaste)
			if(treated_robotic || treated_organic)
				if(organ.is_dead())
					continue
				if(organ.damage)
					user.visible_message("<span class='notice'>[user] treats damage to [target]'s [organ.name] with [tool_name].</span>", \
						"<span class='notice'>You treat damage to [target]'s [organ.name] with [tool_name].</span>")
					organ.damage = 0
				organ.surgeryize()

	else if(current_type == "insert")
		I = tool
		if(!user.drop_item_ground(I))
			to_chat(user, "<span class='warning'>[I] is stuck to your hand, you can't put it in [target]!</span>")
			return FALSE
		I.insert(target)
		if(istype(I, /obj/item/organ/internal/cyberimp))
			add_attack_logs(user, target, "Surgically inserted [I]([I.type])", ATKLOG_ALMOSTALL)
		spread_germs_to_organ(I, user, tool)

		if(affected)
			user.visible_message("<span class='notice'>[user] has transplanted [tool] into [target]'s [affected.name].</span>",
				"<span class='notice'>You have transplanted [tool] into [target]'s [affected.name].</span>")
		else
			user.visible_message("<span class='notice'>[user] has transplanted [tool] into [target]'s [parse_zone(target_zone)].</span>",
				"<span class='notice'>You have transplanted [tool] into [target]'s [parse_zone(target_zone)].</span>")

	else if(current_type == "extract")
		var/mob/living/simple_animal/borer/B = target.has_brain_worms()
		if(target_zone == BODY_ZONE_HEAD && B && B.host == target)
			user.visible_message("[user] successfully extracts [B] from [target]'s [parse_zone(target_zone)]!",
				"<span class='notice'>You successfully extract [B] from [target]'s [parse_zone(target_zone)].</span>")
			add_attack_logs(user, target, "Surgically removed [B]. INTENT: [uppertext(user.a_intent)]")
			B.leave_host()
			return FALSE
		if(I && I.owner == target)
			user.visible_message("<span class='notice'>[user] has separated and extracts [target]'s [I] with [tool].</span>",
				"<span class='notice'>You have separated and extracted [target]'s [I] with [tool].</span>")

			add_attack_logs(user, target, "Surgically removed [I.name]. INTENT: [uppertext(user.a_intent)]")
			spread_germs_to_organ(I, user, tool)
			var/obj/item/thing = I.remove(target)
			if(!QDELETED(thing)) // some "organs", like egg infections, can have I.remove(target) return null, and so we can't use "thing" in that case
				if(istype(thing))
					thing.forceMove(get_turf(target))
					user.put_in_hands(thing, ignore_anim = FALSE)
				else
					thing.forceMove(get_turf(target))
			target.update_icons()
		else
			user.visible_message("<span class='notice'>[user] can't seem to extract anything from [target]'s [parse_zone(target_zone)]!</span>",
				"<span class='notice'>You can't extract anything from [target]'s [parse_zone(target_zone)]!</span>")

	else if(current_type == "clean")
		if(!hasorgans(target))
			return
		if(!istype(tool,/obj/item/reagent_containers))
			return

		var/obj/item/reagent_containers/C = tool
		var/datum/reagents/R = C.reagents

		if(R.has_reagent("mitocholide", 5))
			if(I == null)
				user.visible_message("[user] didn't find dead organs in [target]'s [affected.name]", \
					"You didn't find dead organs in [target]'s [affected.name]")
				return FALSE
			I.rejuvenate()
			R.remove_reagent("mitocholide", 5)
			if(istype(C,/obj/item/reagent_containers/syringe))
				user.visible_message("<span class='notice'>[user] has injected [tool] into [target]'s [I.name].</span>",
					"<span class='notice'>You have injected [tool] into [target]'s [I.name].</span>")
			else
				user.visible_message("<span class='notice'>[user] has poured some of [tool] over [target]'s [I.name].</span>",
					"<span class='notice'>You have poured some of [tool] over [target]'s [I.name].</span>")
			return FALSE
		else if(C.reagents.has_reagent("mitocholide"))
			user.visible_message("[user] notices there is not enough mitocholide in [tool].", \
				"You notice there is not enough mitocholide in [tool].")
			return FALSE

		var/ethanol = 0 //how much alcohol is in the thing
		var/spaceacillin = 0 //how much actual antibiotic is in the thing

		if(R.reagent_list.len)
			for(var/datum/reagent/consumable/ethanol/alcohol in R.reagent_list)
				ethanol += alcohol.alcohol_perc * 300
			ethanol /= R.reagent_list.len

			spaceacillin = R.get_reagent_amount("spaceacillin")


		for(var/obj/item/organ/internal/organ as anything in affected.internal_organs)
			if(R.total_volume < GHETTO_DISINFECT_AMOUNT)
				user.visible_message("[user] notices there is not enough in [tool].", \
					"You notice there is not enough in [tool].")
				return FALSE
			if(organ.germ_level < INFECTION_LEVEL_ONE / 2)
				to_chat(user, "[organ.name] does not appear to be infected.")
			if(organ.germ_level >= INFECTION_LEVEL_ONE / 2)
				if(spaceacillin >= GHETTO_DISINFECT_AMOUNT)
					organ.germ_level = 0
				else
					organ.germ_level = max(organ.germ_level-ethanol, 0)
				if(istype(C,/obj/item/reagent_containers/syringe))
					user.visible_message("<span class='notice'>[user] has injected [tool] into [target]'s [organ.name].</span>",
						"<span class='notice'>You have injected [tool] into [target]'s [organ.name].</span>")
				else
					user.visible_message("<span class='notice'>[user] has poured some of [tool] over [target]'s [organ.name].</span>",
						"<span class='notice'>You have poured some of [tool] over [target]'s [organ.name].</span>")
				R.trans_to(target, GHETTO_DISINFECT_AMOUNT)
				R.reaction(target, REAGENT_INGEST)

	else if(current_type == "finish")
		if(affected && affected.encased)
			var/msg = "<span class='notice'>[user] bends [target]'s [affected.encased] back into place with [tool].</span>"
			var/self_msg = "<span class='notice'>You bend [target]'s [affected.encased] back into place with [tool].</span>"
			user.visible_message(msg, self_msg)
			affected.open = 2.5
		else
			var/msg = "<span class='notice'>[user] pulls [target]'s flesh back into place with [tool].</span>"
			var/self_msg = "<span class='notice'>You pull [target]'s flesh back into place with [tool].</span>"
			user.visible_message(msg, self_msg)

		return TRUE

	return FALSE

/datum/surgery_step/internal/manipulate_organs/fail_step(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool,datum/surgery/surgery)
	if(current_type == "mend")
		if(!hasorgans(target))
			return

		user.visible_message("<span class='warning'>[user]'s hand slips, getting mess and tearing the inside of [target]'s [affected.name] with [tool]!</span>", \
			"<span class='warning'>Your hand slips, getting mess and tearing the inside of [target]'s [affected.name] with [tool]!</span>")

		var/dam_amt = 2

		if(istype(tool, /obj/item/stack/medical/bruise_pack/advanced))
			target.adjustToxLoss(5)

		else if(istype(tool, /obj/item/stack/medical/bruise_pack) || istype(tool, /obj/item/stack/nanopaste))
			dam_amt = 5
			target.adjustToxLoss(10)
			affected.receive_damage(5)

		for(var/obj/item/organ/internal/organ as anything in affected.internal_organs)
			if(organ.damage && !organ.tough)
				organ.receive_damage(dam_amt, 0)

		return FALSE

	else if(current_type == "insert")
		user.visible_message("<span class='warning'>[user]'s hand slips, damaging [tool]!</span>", \
			"<span class='warning'>Your hand slips, damaging [tool]!</span>")
		var/obj/item/organ/internal/I = tool
		if(istype(I) && !I.tough)
			I.receive_damage(rand(3,5),0)

		return FALSE

	else if(current_type == "clean")
		if(!hasorgans(target))
			return
		if(!istype(tool,/obj/item/reagent_containers))
			return

		var/obj/item/reagent_containers/C = tool
		var/datum/reagents/R = C.reagents
		var/ethanol = 0 //how much alcohol is in the thing

		if(R.reagent_list.len)
			for(var/datum/reagent/consumable/ethanol/alcohol in R.reagent_list)
				ethanol += alcohol.alcohol_perc * 300
			ethanol /= C.reagents.reagent_list.len

		for(var/obj/item/organ/internal/organ as anything in affected.internal_organs)
			organ.germ_level = max(organ.germ_level - ethanol, 0)
			organ.receive_damage(rand(4,8), 0)

		R.trans_to(target, GHETTO_DISINFECT_AMOUNT * 10)
		R.reaction(target, REAGENT_INGEST)

		user.visible_message("<span class='warning'>[user]'s hand slips, splashing the contents of [tool] all over [target]'s [affected.name] incision!</span>", \
			"<span class='warning'>Your hand slips, splashing the contents of [tool] all over [target]'s [affected.name] incision!</span>")
		return FALSE

	else if(current_type == "extract")
		if(I && I.owner == target)
			if(affected)
				user.visible_message("<span class='warning'>[user]'s hand slips, damaging [target]'s [affected.name] with [tool]!</span>", \
					"<span class='warning'>Your hand slips, damaging [target]'s [affected.name] with [tool]!</span>")
				affected.receive_damage(20)
			else
				user.visible_message("<span class='warning'>[user]'s hand slips, damaging [target]'s [parse_zone(target_zone)] with [tool]!</span>", \
					"<span class='warning'>Your hand slips, damaging [target]'s [parse_zone(target_zone)] with [tool]!</span>")
		else
			user.visible_message("[user] can't seem to extract anything from [target]'s [parse_zone(target_zone)]!",
				"<span class='notice'>You can't extract anything from [target]'s [parse_zone(target_zone)]!</span>")
		return FALSE

	else if(current_type == "finish")
		if(affected && affected.encased)
			var/msg = "<span class='warning'>[user]'s hand slips, bending [target]'s [affected.encased] the wrong way!</span>"
			var/self_msg = "<span class='warning'>Your hand slips, bending [target]'s [affected.encased] the wrong way!</span>"
			user.visible_message(msg, self_msg)
			affected.fracture()
		else
			var/msg = "<span class='warning'>[user]'s hand slips, tearing the skin!</span>"
			var/self_msg = "<span class='warning'>Your hand slips, tearing skin!</span>"
			user.visible_message(msg, self_msg)
		if(affected)
			affected.receive_damage(20)
		return FALSE


	return FALSE


//////////////////////////////////////////////////////////////////
//						SPESHUL AYLIUM STUPS					//
//////////////////////////////////////////////////////////////////

/datum/surgery_step/saw_carapace
	name = "saw carapace"
	allowed_tools = list(
	/obj/item/circular_saw = 100, \
	/obj/item/melee/energy/sword/cyborg/saw = 100, \
	/obj/item/hatchet = 90, \
	/obj/item/wirecutters = 70
	)

	time = 54


/datum/surgery_step/saw_carapace/begin_step(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool,datum/surgery/surgery)
	user.visible_message("[user] begins to cut through [target]'s [target_zone] with [tool].", \
		"You begin to cut through [target]'s [target_zone] with [tool].")
	..()

/datum/surgery_step/saw_carapace/end_step(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool,datum/surgery/surgery)
	user.visible_message("<span class='notice'>[user] has cut [target]'s [target_zone] open with [tool].</span>", \
		"<span class='notice'>You have cut [target]'s [target_zone] open with [tool].</span>")
	return TRUE

/datum/surgery_step/saw_carapace/fail_step(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool,datum/surgery/surgery)
	user.visible_message("<span class='warning'>[user]'s hand slips, cracking [target]'s [target_zone] with [tool]!</span>", \
		"<span class='warning'>Your hand slips, cracking [target]'s [target_zone] with [tool]!</span>")
	return FALSE

/datum/surgery_step/cut_carapace
	name = "cut carapace"
	allowed_tools = list(
	/obj/item/scalpel = 100,		\
	/obj/item/kitchen/knife = 90,	\
	/obj/item/shard = 60, 		\
	/obj/item/scissors = 12,		\
	/obj/item/twohanded/chainsaw = 1, \
	/obj/item/claymore = 6, \
	/obj/item/melee/energy/ = 6, \
	/obj/item/pen/edagger = 6, \
	)

	time = 16

/datum/surgery_step/cut_carapace/begin_step(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool,datum/surgery/surgery)
	user.visible_message("[user] starts the incision on [target]'s [target_zone] with [tool].", \
		"You start the incision on [target]'s [target_zone] with [tool].")
	..()

/datum/surgery_step/cut_carapace/end_step(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool,datum/surgery/surgery)
	user.visible_message("<span class='notice'>[user] has made an incision on [target]'s [target_zone] with [tool].</span>", \
		"<span class='notice'>You have made an incision on [target]'s [target_zone] with [tool].</span>",)
	return TRUE

/datum/surgery_step/cut_carapace/fail_step(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool,datum/surgery/surgery)
	user.visible_message("<span class='warning'>[user]'s hand slips, slicing open [target]'s [target_zone] in a wrong spot with [tool]!</span>", \
		"<span class='warning'>Your hand slips, slicing open [target]'s [target_zone] in a wrong spot with [tool]!</span>")
	return FALSE

/datum/surgery_step/retract_carapace
	name = "retract carapace"

	allowed_tools = list(
	/obj/item/scalpel/laser/manager = 100, \
	/obj/item/retractor = 100, 	\
	/obj/item/crowbar = 90,	\
	/obj/item/kitchen/utensil/fork = 60
	)

	time = 24

/datum/surgery_step/retract_carapace/begin_step(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool,datum/surgery/surgery)
	var/msg = "[user] starts to pry open the incision on [target]'s [target_zone] with [tool]."
	var/self_msg = "You start to pry open the incision on [target]'s [target_zone] with [tool]."
	if(target_zone == BODY_ZONE_CHEST)
		msg = "[user] starts to separate the ribcage and rearrange the organs in [target]'s torso with [tool]."
		self_msg = "You start to separate the ribcage and rearrange the organs in [target]'s torso with [tool]."
	if(target_zone == BODY_ZONE_PRECISE_GROIN)
		msg = "[user] starts to pry open the incision and rearrange the organs in [target]'s lower abdomen with [tool]."
		self_msg = "You start to pry open the incision and rearrange the organs in [target]'s lower abdomen with [tool]."
	user.visible_message(msg, self_msg)
	..()

/datum/surgery_step/retract_carapace/end_step(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool,datum/surgery/surgery)
	var/msg = "<span class='notice'>[user] keeps the incision open on [target]'s [target_zone] with [tool]</span>."
	var/self_msg = "<span class='notice'>You keep the incision open on [target]'s [target_zone] with [tool].</span>"
	if(target_zone == BODY_ZONE_CHEST)
		msg = "<span class='notice'>[user] keeps the ribcage open on [target]'s torso with [tool].</span>"
		self_msg = "<span class='notice'>You keep the ribcage open on [target]'s torso with [tool].</span>"
	if(target_zone == BODY_ZONE_PRECISE_GROIN)
		msg = "<span class='notice'>[user] keeps the incision open on [target]'s lower abdomen with [tool].</span>"
		self_msg = "<span class='notice'>You keep the incision open on [target]'s lower abdomen with [tool].</span>"
	user.visible_message(msg, self_msg)
	return TRUE

/datum/surgery_step/generic/retract_carapace/fail_step(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool,datum/surgery/surgery)
	var/msg = "<span class='warning'>[user]'s hand slips, tearing the edges of incision on [target]'s [target_zone] with [tool]!</span>"
	var/self_msg = "<span class='warning'>Your hand slips, tearing the edges of incision on [target]'s [target_zone] with [tool]!</span>"
	if(target_zone == BODY_ZONE_CHEST)
		msg = "<span class='warning'>[user]'s hand slips, damaging several organs [target]'s torso with [tool]!</span>"
		self_msg = "<span class='warning'>Your hand slips, damaging several organs [target]'s torso with [tool]!</span>"
	if(target_zone == BODY_ZONE_PRECISE_GROIN)
		msg = "<span class='warning'>[user]'s hand slips, damaging several organs [target]'s lower abdomen with [tool]</span>"
		self_msg = "<span class='warning'>Your hand slips, damaging several organs [target]'s lower abdomen with [tool]!</span>"
	user.visible_message(msg, self_msg)
	return FALSE
