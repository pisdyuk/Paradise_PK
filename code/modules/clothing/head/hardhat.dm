
/obj/item/clothing/head/hardhat
	name = "hard hat"
	desc = "A piece of headgear used in dangerous working conditions to protect the head. Comes with a built-in flashlight."
	icon_state = "hardhat0_yellow"
	item_state = "hardhat0_yellow"
	var/brightness_on = 4 //luminosity when on
	var/on = FALSE
	item_color = "yellow" //Determines used sprites: hardhat[on]_[color] and hardhat[on]_[color]2 (lying down sprite)
	armor = list("melee" = 15, "bullet" = 5, "laser" = 20, "energy" = 10, "bomb" = 20, "bio" = 10, "rad" = 20, "fire" = 100, "acid" = 50)
	flags_inv = 0
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	resistance_flags = FIRE_PROOF
	dog_fashion = /datum/dog_fashion/head/hardhat
	sprite_sheets = list(
		"Grey" = 'icons/mob/clothing/species/grey/head.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
	)

/obj/item/clothing/head/hardhat/attack_self()
	toggle_helmet_light()


/obj/item/clothing/head/hardhat/proc/toggle_helmet_light()
	on = !on
	if(on)
		turn_on()
	else
		turn_off()
	update_icon(UPDATE_ICON_STATE)


/obj/item/clothing/head/hardhat/update_icon_state()
	icon_state = "hardhat[on]_[item_color]"
	item_state = "hardhat[on]_[item_color]"
	update_equipped_item()


/obj/item/clothing/head/hardhat/proc/turn_on()
	set_light(brightness_on)

/obj/item/clothing/head/hardhat/proc/turn_off()
	set_light(0)

/obj/item/clothing/head/hardhat/emp_act(severity)
	. = ..()
	extinguish_light()

/obj/item/clothing/head/hardhat/extinguish_light(force = FALSE)
	if(on)
		on = FALSE
		turn_off()
		update_icon()
		visible_message(span_danger("[src]'s light fades and turns off."))

/obj/item/clothing/head/hardhat/orange
	icon_state = "hardhat0_orange"
	item_state = "hardhat0_orange"
	item_color = "orange"
	dog_fashion = null

/obj/item/clothing/head/hardhat/red
	icon_state = "hardhat0_red"
	item_state = "hardhat0_red"
	item_color = "red"
	dog_fashion = null
	name = "firefighter helmet"
	flags = STOPSPRESSUREDMAGE
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/hardhat/white
	icon_state = "hardhat0_white"
	item_state = "hardhat0_white"
	item_color = "white"
	flags = STOPSPRESSUREDMAGE
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	dog_fashion = /datum/dog_fashion/head/hardhat

/obj/item/clothing/head/hardhat/dblue
	icon_state = "hardhat0_dblue"
	item_state = "hardhat0_dblue"
	item_color = "dblue"
	dog_fashion = null

/obj/item/clothing/head/hardhat/atmos
	icon_state = "hardhat0_atmos"
	item_state = "hardhat0_atmos"
	item_color = "atmos"
	name = "atmospheric technician's firefighting helmet"
	desc = "A firefighter's helmet, able to keep the user cool in any situation."
	flags = STOPSPRESSUREDMAGE
	flags_inv = HIDEMASK|HIDEHEADSETS|HIDEGLASSES|HIDENAME
	flags_cover = HEADCOVERSMOUTH|HEADCOVERSEYES
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	dog_fashion = null
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/helmet.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
	)
