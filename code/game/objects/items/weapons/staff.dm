/obj/item/twohanded/staff
	name = "wizards staff"
	desc = "Apparently a staff used by the wizard."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "staff"
	force = 3.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	armour_penetration = 100
	attack_verb = list("bludgeoned", "whacked", "disciplined")
	resistance_flags = FLAMMABLE

/obj/item/twohanded/staff/broom
	name = "broom"
	desc = "Used for sweeping, and flying into the night while cackling. Black cat not included."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "broom"
	item_state = "broom0"


/obj/item/twohanded/staff/broom/update_icon_state()
	item_state = "broom[HAS_TRAIT(src, TRAIT_WIELDED)]"
	update_equipped_item()


/obj/item/twohanded/staff/broom/wield(obj/item/source, mob/living/carbon/user)
	force =  5
	attack_verb = list("rammed into", "charged at")
	if(!user)
		return

	update_icon(UPDATE_ICON_STATE)
	if(user.mind && (user.mind in SSticker.mode.wizards))
		user.flying = TRUE
		user.float(TRUE)
		user.say("QUID 'ITCH")
		animate(user, pixel_y = pixel_y + 10 , time = 10, loop = 1, easing = SINE_EASING)

	to_chat(user, "<span class='notice'>You hold \the [src] between your legs.</span>")


/obj/item/twohanded/staff/broom/unwield(obj/item/source, mob/living/carbon/user)
	update_icon(UPDATE_ICON_STATE)
	force = 3
	attack_verb = list("bludgeoned", "whacked", "cleaned")
	user.flying = FALSE
	user.update_gravity(user.mob_has_gravity())
	animate(user)


/obj/item/twohanded/staff/broom/attackby(obj/O, mob/user)
	if(istype(O, /obj/item/clothing/mask/horsehead))
		new/obj/item/twohanded/staff/broom/horsebroom(get_turf(src))
		user.temporarily_remove_item_from_inventory(O)
		qdel(O)
		qdel(src)
		return
	..()

/obj/item/twohanded/staff/broom/horsebroom
	name = "broomstick horse"
	desc = "Saddle up!"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "horsebroom"
	item_state = "horsebroom0"

/obj/item/twohanded/staff/broom/horsebroom/attack_self(mob/user as mob)
	..()
	item_state = "horsebroom[wielded ? 1 : 0]"

/obj/item/twohanded/staff/stick
	name = "stick"
	desc = "A great tool to drag someone else's drinks across the bar."
	icon_state = "stick"
	item_state = "stick"
	force = 3.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
