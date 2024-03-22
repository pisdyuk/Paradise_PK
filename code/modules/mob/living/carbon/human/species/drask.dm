/datum/species/drask
	name = SPECIES_DRASK
	name_plural = "Drask"
	icobase = 'icons/mob/human_races/r_drask.dmi'
	deform = 'icons/mob/human_races/r_drask.dmi'
	language = LANGUAGE_DRASK
	eyes = "drask_eyes_s"

	speech_sounds = list('sound/voice/drasktalk.ogg')
	speech_chance = 20
	male_scream_sound = list('sound/voice/drasktalk2.ogg')
	female_scream_sound = list('sound/voice/drasktalk2.ogg')
	male_cough_sounds = list('sound/voice/draskcough.ogg')
	female_cough_sounds = list('sound/voice/draskcough.ogg')
	male_sneeze_sound = list('sound/voice/drasksneeze.ogg')
	female_sneeze_sound = list('sound/voice/drasksneeze.ogg')

	burn_mod = 1.5
	oxy_mod = 2
	exotic_blood = "cryoxadone"
	body_temperature = 273
	toolspeedmod = 1.2 //20% slower
	punchdamagelow = 5
	punchdamagehigh = 12
	punchstunthreshold = 12
	obj_damage = 10

	blurb = "Hailing from Hoorlm, planet outside what is usually considered a habitable \
	orbit, the Drask evolved to live in extreme cold. Their strange bodies seem \
	to operate better the colder their surroundings are, and can regenerate rapidly \
	when breathing supercooled gas. <br/><br/> On their homeworld, the Drask live long lives \
	in their labyrinthine settlements, carved out beneath Hoorlm's icy surface, where the air \
	is of breathable density."

	suicide_messages = list(
		"трёт себя до возгорания!",
		"давит пальцами на свои большие глаза!",
		"втягивает теплый воздух!",
		"задерживает дыхание!")

	species_traits = list(LIPS, IS_WHITELISTED, EXOTIC_COLOR)
	clothing_flags = HAS_UNDERWEAR | HAS_UNDERSHIRT
	bodyflags = HAS_SKIN_TONE | HAS_BODY_MARKINGS
	has_gender = FALSE

	cold_level_1 = 260 //Default 260 - Lower is better
	cold_level_2 = 200 //Default 200
	cold_level_3 = 120 //Default 120
	coldmod = -1

	heat_level_1 = 310 //Default 370 - Higher is better
	heat_level_2 = 340 //Default 400
	heat_level_3 = 400 //Default 460
	heatmod = 3

	flesh_color = "#a3d4eb"
	reagent_tag = PROCESS_ORG
	base_color = "#a3d4eb"
	blood_species = "Drask"
	blood_color = "#a3d4eb"
	butt_sprite = "drask"

	has_organ = list(
		INTERNAL_ORGAN_HEART = /obj/item/organ/internal/heart/drask,
		INTERNAL_ORGAN_LUNGS = /obj/item/organ/internal/lungs/drask,
		INTERNAL_ORGAN_LIVER = /obj/item/organ/internal/liver/drask,
		INTERNAL_ORGAN_EYES = /obj/item/organ/internal/eyes/drask, //5 darksight.
		INTERNAL_ORGAN_EARS = /obj/item/organ/internal/ears,
		INTERNAL_ORGAN_BRAIN = /obj/item/organ/internal/brain/drask,
	)

	meat_type = /obj/item/reagent_containers/food/snacks/meat/humanoid/drask

	disliked_food = SUGAR | GROSS
	liked_food = DAIRY

/datum/species/drask/get_species_runechat_color(mob/living/carbon/human/H)
	var/obj/item/organ/internal/eyes/E = H.get_int_organ(/obj/item/organ/internal/eyes)
	return E.eye_colour

/datum/species/drask/on_species_gain(mob/living/carbon/human/H)
	..()
	H.verbs |= /mob/living/carbon/human/proc/emote_hum

/datum/species/drask/on_species_loss(mob/living/carbon/human/H)
	..()
	H.verbs -= /mob/living/carbon/human/proc/emote_hum

/datum/species/drask/handle_life(mob/living/carbon/human/H)
	..()
	if(H.stat == DEAD)
		return
	if(H.bodytemperature < TCRYO)
		H.adjustCloneLoss(-1)
		H.adjustOxyLoss(-2)
		H.adjustToxLoss(-0.5)
		H.adjustBruteLoss(-2)
		H.adjustFireLoss(-4)
		var/obj/item/organ/external/head/head = H.get_organ(BODY_ZONE_HEAD)
		head?.undisfigure()


/datum/species/drask/handle_reagents(mob/living/carbon/human/H, datum/reagent/R)
	if(R.id == "iron")
		return TRUE
	if(R.id == "salglu_solution")
		return TRUE
	return ..()
