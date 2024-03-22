/****************Explorer's Suit and Mask****************/
/obj/item/clothing/suit/hooded/explorer
	name = "explorer suit"
	desc = "An armoured suit for exploring harsh environments."
	icon_state = "explorer"
	item_state = "explorer"
	item_color = "explorer"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	hoodtype = /obj/item/clothing/head/hooded/explorer
	armor = list("melee" = 30, "bullet" = 20, "laser" = 20, "energy" = 20, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 50)
	allowed = list(/obj/item/flashlight, /obj/item/tank, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe, /obj/item/twohanded/kinetic_crusher, /obj/item/hierophant_club, /obj/item/twohanded/fireaxe/boneaxe)
	resistance_flags = FIRE_PROOF
	hide_tail_by_species = list("Vox" , "Vulpkanin" , "Unathi", "Ash Walker", "Ash Walker Shaman", "Draconid", "Tajaran")

	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/suit.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/suit.dmi',
		"Tajaran" = 'icons/mob/clothing/species/tajaran/suit.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Ash Walker" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Ash Walker Shaman" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Draconid" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/suit.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/suit.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/suit.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/suit.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/suit.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/suit.dmi'
	)

/obj/item/clothing/head/hooded/explorer
	name = "explorer hood"
	desc = "An armoured hood for exploring harsh environments."
	icon_state = "explorer"
	item_state = "explorer"
	body_parts_covered = HEAD
	flags = BLOCKHAIR | NODROP
	flags_cover = HEADCOVERSEYES
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	armor = list("melee" = 30, "bullet" = 20, "laser" = 20, "energy" = 20, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 50)
	resistance_flags = FIRE_PROOF

	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/head.dmi',
		"Tajaran" = 'icons/mob/clothing/species/tajaran/head.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/head.dmi',
		"Ash Walker" = 'icons/mob/clothing/species/unathi/head.dmi',
		"Ash Walker Shaman" = 'icons/mob/clothing/species/unathi/head.dmi',
		"Draconid" = 'icons/mob/clothing/species/unathi/head.dmi',
		"Vox" = 'icons/mob/clothing/species/vox/head.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/head.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/head.dmi',
		"Skrell" = 'icons/mob/clothing/species/skrell/head.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
	)

/obj/item/clothing/suit/space/hostile_environment
	name = "H.E.C.K. suit"
	desc = "Hostile Environment Cross-Kinetic Suit: A suit designed to withstand the wide variety of hazards from Lavaland. It wasn't enough for its last owner."
	icon_state = "hostile_env"
	item_state = "hostile_env"
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | LAVA_PROOF | ACID_PROOF
	slowdown = 0
	armor = list("melee" = 70, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	allowed = list(/obj/item/flashlight, /obj/item/tank, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe, /obj/item/twohanded/kinetic_crusher, /obj/item/hierophant_club, /obj/item/twohanded/fireaxe/boneaxe)
	jetpack = /obj/item/tank/jetpack/suit


/obj/item/clothing/suit/space/hostile_environment/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	START_PROCESSING(SSobj, src)


/obj/item/clothing/suit/space/hostile_environment/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()


/obj/item/clothing/suit/space/hostile_environment/process()
	var/mob/living/carbon/C = loc
	if(istype(C) && prob(2)) //cursed by bubblegum
		if(prob(15))
			new /obj/effect/hallucination/delusion(C.loc, C, force_kind = "demon", duration = 100, skip_nearby = 0)
			to_chat(C, "<span class='colossus'><b>[pick("I AM IMMORTAL.","KILL THEM ALL!","I SEE YOU.","WE ARE THE SAME!","DEATH CANNOT HOLD ME.")]</b></span>")
		else
			to_chat(C, "<span class='warning'>[pick("You hear faint whispers.","You smell ash.","You feel hot.","You hear a roar in the distance.")]</span>")

/obj/item/clothing/head/helmet/space/hostile_environment
	name = "H.E.C.K. helmet"
	desc = "Hostile Environiment Cross-Kinetic Helmet: A helmet designed to withstand the wide variety of hazards from Lavaland. It wasn't enough for its last owner."
	icon_state = "hostile_env"
	item_state = "hostile_env"
	w_class = WEIGHT_CLASS_NORMAL
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	armor = list("melee" = 70, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | LAVA_PROOF | ACID_PROOF


/obj/item/clothing/head/helmet/space/hostile_environment/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	update_icon(UPDATE_OVERLAYS)


/obj/item/clothing/head/helmet/space/hostile_environment/update_overlays()
	. = ..()
	. += mutable_appearance(icon, "hostile_env_glass", appearance_flags = RESET_COLOR)


/obj/item/clothing/head/helmet/space/hardsuit/champion
	name = "champion's helmet"
	desc = "Peering into the eyes of the helmet is enough to seal damnation."
	icon_state = "hardsuit0-berserker"
	item_color = "berserker"
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	heat_protection = HEAD
	armor = list(melee = 65, bullet = 50, laser = 50, energy = 50, bomb = 50, bio = 100, rad = 100, fire = 80, acid = 80)
	sprite_sheets = list(
		"Grey" = 'icons/mob/clothing/species/grey/helmet.dmi',
		"Tajaran" = 'icons/mob/clothing/species/tajaran/helmet.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Ash Walker" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Ash Walker Shaman" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Draconid" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Vox" = 'icons/mob/clothing/species/vox/helmet.dmi',
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi'
		)

/obj/item/clothing/suit/space/hardsuit/champion
	name = "champion's hardsuit"
	desc = "Voices echo from the hardsuit, driving the user insane."
	icon_state = "hardsuit-berserker"
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	slowdown = 0.25 // you are wearing a POWERFUL energy suit, after all
	cant_be_faster = TRUE // no heretic magic
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/champion
	allowed = list(/obj/item/flashlight, /obj/item/tank, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe, /obj/item/twohanded/kinetic_crusher, /obj/item/hierophant_club, /obj/item/twohanded/fireaxe/boneaxe)
	armor = list(melee = 65, bullet = 50, laser = 50, energy = 50, bomb = 50, bio = 100, rad = 100, fire = 80, acid = 80)
	sprite_sheets = list(
		"Tajaran" = 'icons/mob/clothing/species/tajaran/suit.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Ash Walker" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Ash Walker Shaman" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Draconid" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Vox" = 'icons/mob/clothing/species/vox/suit.dmi',
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/suit.dmi'
		)

/obj/item/clothing/head/helmet/space/hardsuit/champion/templar
	name = "dark templar's helmet"
	desc = "Through darkness we see the light"
	icon_state = "hardsuit0-templar"
	item_color = "templar"

/obj/item/clothing/suit/space/hardsuit/champion/templar
	name = "dark templar's hardsuit"
	desc = "No Pity! No Remorse! No Fear!"
	icon_state = "darktemplar-follower0"
	item_color = "darktemplar-follower0"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/champion/templar
	species_restricted = list("Human", "Slime People", "Skeleton", "Nucleation", "Machine", "Plasmaman", "Diona", "Kidan", "Shadow") // only humanoids. And we don't have animal sprites.

/obj/item/clothing/head/helmet/space/hardsuit/champion/templar/premium
	name = "high dark templar's helmet"
	desc = "The galaxy is the Emperor's.."
	icon_state = "hardsuit0-hightemplar"
	item_color = "hightemplar"

/obj/item/clothing/suit/space/hardsuit/champion/templar/premium
	name = "high dark templar's hardsuit"
	desc = "..And anyone or anything who challenges that claim is an enemy who must be destroyed."
	icon_state = "darktemplar-chaplain0"
	item_color = "darktemplar-chaplain0"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/champion/templar/premium

/obj/item/clothing/suit/hooded/pathfinder
	name = "pathfinder cloak"
	desc = "A thick cloak woven from sinew and hides, designed to protect its wearer from hazardous weather."
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/pickaxe, /obj/item/twohanded/spear, /obj/item/organ/internal/regenerative_core/legion, /obj/item/kitchen/knife/combat/survival, /obj/item/twohanded/kinetic_crusher, /obj/item/hierophant_club, /obj/item/twohanded/fireaxe/boneaxe)
	icon_state = "pathcloak"
	item_state = "pathcloak"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 35, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 50)
	resistance_flags = FIRE_PROOF
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	hide_tail_by_species = list("Vox" , "Vulpkanin" , "Unathi", "Ash Walker", "Ash Walker Shaman", "Draconid", "Tajaran")
	hoodtype = /obj/item/clothing/head/hooded/pathfinder
	species_restricted = list("exclude", "lesser form")

	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/suit.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/suit.dmi',
		"Tajaran" = 'icons/mob/clothing/species/tajaran/suit.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Ash Walker" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Ash Walker Shaman" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Draconid" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/suit.dmi',
	)

/obj/item/clothing/head/hooded/pathfinder
	name = "pathfinder kasa"
	desc = "A helmet crafted from bones and sinew meant to protect its wearer from hazardous weather."
	icon_state = "pathhead"
	item_state = "pathhead"
	body_parts_covered = HEAD
	flags = BLOCKHAIR | NODROP
	flags_cover = HEADCOVERSEYES
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 35, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 50)
	resistance_flags = FIRE_PROOF
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi',
		"Vox" = 'icons/mob/clothing/species/vox/helmet.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/head.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/head.dmi',
		"Tajaran" = 'icons/mob/clothing/species/tajaran/helmet.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Ash Walker" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Ash Walker Shaman" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Draconid" = 'icons/mob/clothing/species/unathi/helmet.dmi',
	)
