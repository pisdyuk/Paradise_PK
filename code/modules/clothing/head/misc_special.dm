/*
 * Contents:
 *		Welding mask
 *		Cakehat
 *		Ushanka
 *		Pumpkin head
 *		Kitty ears
 *		Cardborg Disguise
 *		Head Mirror
 */

/*
 * Welding mask
 */
/obj/item/clothing/head/welding
	name = "welding helmet"
	desc = "A head-mounted face cover designed to protect the wearer completely from space-arc eye."
	icon_state = "welding"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	item_state = "welding"
	materials = list(MAT_METAL=1750, MAT_GLASS=400)
	flash_protect = 2
	tint = 2
	can_toggle = TRUE
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 60)
	flags_inv = HIDEMASK|HIDEHEADSETS|HIDEGLASSES|HIDENAME
	actions_types = list(/datum/action/item_action/toggle)
	visor_flags_inv = HIDEMASK|HIDEHEADSETS|HIDEGLASSES|HIDENAME
	resistance_flags = FIRE_PROOF
	var/paint = null

	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/head.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Ash Walker" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Ash Walker Shaman" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Draconid" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Tajaran" = 'icons/mob/clothing/species/tajaran/helmet.dmi',
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/helmet.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
		)

/obj/item/clothing/head/welding/flamedecal
	name = "flame decal welding helmet"
	desc = "A welding helmet adorned with flame decals, and several cryptic slogans of varying degrees of legibility."
	icon_state = "welding_redflame"

/obj/item/clothing/head/welding/flamedecal/blue
	name = "blue flame decal welding helmet"
	desc = "A welding helmet with blue flame decals on it."
	icon_state = "welding_blueflame"

/obj/item/clothing/head/welding/flamedecal/white
	name = "white decal welding helmet"
	desc = "A white welding helmet with a character written across it."
	icon_state = "welding_white"

/obj/item/clothing/head/welding/attack_self(mob/user)
	weldingvisortoggle(user)

/obj/item/clothing/head/welding/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/toy/crayon/spraycan))
		if(icon_state != "welding")
			to_chat(user, "<span class = 'warning'>Похоже, тут уже есть слой краски!</span>")
			return
		var/obj/item/toy/crayon/spraycan/C = I
		if(C.capped)
			to_chat(user, "<span class = 'warning'>Вы не можете раскрасить [src], если крышка на банке закрыта!</span>")
			return
		var/list/weld_icons = list("Flame" = image(icon = src.icon, icon_state = "welding_redflame"),
									"Blue Flame" = image(icon = src.icon, icon_state = "welding_blueflame"),
									"White Flame" = image(icon = src.icon, icon_state = "welding_white"))
		var/list/weld = list("Flame" = "welding_redflame",
							"Blue Flame" = "welding_blueflame",
							"White Flame" = "welding_white")
		var/choice = show_radial_menu(user, src, weld_icons)
		if(!choice || I.loc != user || !Adjacent(user))
			return
		if(C.uses <= 0)
			to_chat(user, "<span class = 'warning'>Не похоже что бы осталось достаточно краски.</span>")
			return
		icon_state = weld[choice]
		paint = weld[choice]
		C.uses--
		update_icon()
	if(istype(I, /obj/item/soap) && (icon_state != initial(icon_state)))
		icon_state = initial(icon_state)
		paint = null
		update_icon()
	else
		return ..()


/*
 * Cakehat
 */
/obj/item/clothing/head/cakehat
	name = "cake-hat"
	desc = "It's tasty looking!"
	icon_state = "cake0"
	base_icon_state = "cake"
	flags_cover = HEADCOVERSEYES
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	var/on_fire = FALSE


/obj/item/clothing/head/cakehat/process()
	if(!on_fire)
		return PROCESS_KILL

	var/turf/cake_turf = loc
	if(is_equipped(include_pockets = TRUE, include_hands = TRUE))
		cake_turf = loc.loc

	if(isturf(cake_turf))
		cake_turf.hotspot_expose(700, 1)


/obj/item/clothing/head/cakehat/attack_self(mob/user)
	toggle_cake_light(user)


/obj/item/clothing/head/cakehat/proc/toggle_cake_light(mob/user)
	on_fire = !on_fire
	update_icon(UPDATE_ICON_STATE)
	user?.visible_message(
		span_notice("[user] [on_fire ? "lights up" : "extinguishes"] [src]."),
		span_notice("You [on_fire ? "lighted up" : "extinguished"] [src]."),
	)
	if(on_fire)
		set_light(1.5, 1, LIGHT_COLOR_YELLOW)
		force = 3
		damtype = BURN
		START_PROCESSING(SSobj, src)
	else
		set_light(0)
		force = 0
		damtype = BRUTE
		STOP_PROCESSING(SSobj, src)


/obj/item/clothing/head/cakehat/update_icon_state()
	icon_state = "[base_icon_state][on_fire]"


/obj/item/clothing/head/cakehat/extinguish_light(force = FALSE)
	if(!force || !on_fire)
		return
	toggle_cake_light()


/*
 * Soviet Hats
 */
/obj/item/clothing/head/ushanka
	name = "ushanka"
	desc = "Perfect for winter in Siberia, da?"
	icon_state = "ushanka"
	item_state = "ushanka"
	flags_inv = HIDEHEADSETS
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	dog_fashion = /datum/dog_fashion/head/ushanka
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	can_toggle = TRUE
	toggle_on_message = "You raise the ear flaps on"
	toggle_off_message = "You lower the ear flaps on"
	sprite_sheets = list(
		"Grey" = 'icons/mob/clothing/species/grey/head.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
	)

/obj/item/clothing/head/sovietsidecap
	name = "\improper Soviet side cap"
	desc = "A simple military cap with a Soviet star on the front. What it lacks in protection it makes up for in revolutionary spirit."
	icon_state = "sovietsidecap"
	item_state = "sovietsidecap"

/obj/item/clothing/head/sovietofficerhat
	name = "\improper Soviet officer hat"
	desc = "A military officer hat designed to stand out so the conscripts know who is in charge."
	icon_state = "sovietofficerhat"
	item_state = "sovietofficerhat"

/obj/item/clothing/head/sovietadmiralhat
	name = "\improper Soviet admiral hat"
	desc = "This hat clearly belongs to someone very important."
	icon_state = "sovietadmiralhat"
	item_state = "sovietadmiralhat"

/obj/item/clothing/head/soviethelmet
	name = "SSh-68"
	desc = "Soviet steel combat helmet."
	icon_state = "soviethelm"
	item_state = "soviethelm"
	flags = BLOCKHAIR
	flags_inv = HIDEHEADSETS
	armor = list("melee" = 25, "bullet" = 35, "laser" = 15, "energy" = 10, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)
	materials = list(MAT_METAL=2500)

/*
 * Pumpkin head
 */
/obj/item/clothing/head/hardhat/pumpkinhead
	name = "carved pumpkin"
	desc = "A jack o' lantern! Believed to ward off evil spirits."
	icon_state = "hardhat0_pumpkin"//Could stand to be renamed
	item_state = "hardhat0_pumpkin"
	item_color = "pumpkin"
	flags = BLOCKHAIR
	flags_inv = HIDEMASK|HIDEHEADSETS|HIDEGLASSES|HIDENAME
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/head.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/head.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
	)

	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	brightness_on = 2 //luminosity when on


/obj/item/clothing/head/hardhat/reindeer
	name = "novelty reindeer hat"
	desc = "Some fake antlers and a very fake red nose."
	icon_state = "hardhat0_reindeer"
	item_state = "hardhat0_reindeer"
	item_color = "reindeer"
	flags_inv = 0
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	brightness_on = 1 //luminosity when on
	dog_fashion = /datum/dog_fashion/head/reindeer


/*
 * Kitty ears
 */
/obj/item/clothing/head/kitty
	name = "kitty ears"
	desc = "A pair of kitty ears. Meow!"
	icon_state = "kitty"
	dog_fashion = /datum/dog_fashion/head/kitty
	var/mob/living/carbon/human/previous_owner
	var/outer_state = "kitty"
	var/inner_state = "kittyinner"


/obj/item/clothing/head/kitty/mouse
	name = "mouse ears"
	desc = "A pair of mouse ears. Squeak!"
	icon_state = "mousey"
	outer_state = "mousey"
	inner_state = "mouseyinner"


/obj/item/clothing/head/kitty/Destroy()
	previous_owner = null
	return ..()


/obj/item/clothing/head/kitty/equipped(mob/user, slot, initial)
	. = ..()
	if(. && slot == slot_head)
		update_look(user)


/obj/item/clothing/head/kitty/proc/update_look(mob/living/carbon/human/user)
	if(!ishuman(user) || user == previous_owner)
		return
	previous_owner = user
	var/obj/item/organ/external/head/head_organ = user.get_organ(BODY_ZONE_HEAD)
	var/icon/new_look = icon('icons/mob/clothing/head.dmi', outer_state)
	new_look.Blend(head_organ.hair_colour, ICON_ADD)
	new_look.Blend(icon('icons/mob/clothing/head.dmi', inner_state), ICON_OVERLAY)
	icon_override = new_look
	user.update_inv_head()


/obj/item/clothing/head/cardborg
	name = "cardborg helmet"
	desc = "A helmet made out of a box."
	icon_state = "cardborg_h"
	item_state = "cardborg_h"
	flags_inv = HIDEMASK|HIDEHEADSETS|HIDEGLASSES|HIDENAME
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	species_disguise = "High-tech robot"
	dog_fashion = /datum/dog_fashion/head/cardborg
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/head.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/head.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
	)


/obj/item/clothing/head/cardborg/equipped(mob/living/carbon/human/user, slot, initial)
	. = ..()
	if(ishuman(user) && slot == slot_head && istype(user.wear_suit, /obj/item/clothing/suit/cardborg))
		var/obj/item/clothing/suit/cardborg/user_suit = user.wear_suit
		user_suit.disguise(user, src)


/obj/item/clothing/head/cardborg/dropped(mob/living/user, silent = FALSE)
	. = ..()
	user.remove_alt_appearance("standard_borg_disguise")


/*
 * Head Mirror
 */
/obj/item/clothing/head/headmirror
	name = "head mirror"
	desc = "A band of rubber with a very reflective looking mirror attached to the front of it. One of the early signs of medical budget cuts."
	icon_state = "head_mirror"
	item_state = "head_mirror"

	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/head.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/head.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/head.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
	)

