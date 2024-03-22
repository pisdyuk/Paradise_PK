/*
 * Contains:
 * 	Traitor fiber wire
 * 	Improvised garrotes
 */

/obj/item/twohanded/garrote // 12TC traitor item
	name = "fiber wire"
	desc = "A length of razor-thin wire with an elegant wooden handle on either end.<br>You suspect you'd have to be behind the target to use this weapon effectively."
	icon_state = "garrot_wrap"
	w_class = WEIGHT_CLASS_TINY
	var/mob/living/carbon/human/strangling
	var/improvised = 0
	var/garrote_time

/obj/item/twohanded/garrote/Destroy()
	if(strangling)
		strangling.garroted_by.Remove(src)
	strangling = null
	return ..()

/obj/item/twohanded/garrote/update_icon_state()
	if(strangling) // If we're strangling someone we want our icon to stay wielded
		icon_state = "garrot_unwrap"
		return
	icon_state = "garrot_[HAS_TRAIT(src, TRAIT_WIELDED) ? "un" : ""]wrap"

/obj/item/twohanded/garrote/improvised // Made via tablecrafting
	name = "garrote"
	desc = "A length of cable with a shoddily-carved wooden handle tied to either end.<br>You suspect you'd have to be behind the target to use this weapon effectively."
	icon_state = "garrot_I_wrap"
	improvised = 1

/obj/item/twohanded/garrote/improvised/update_icon_state()
	if(strangling)
		icon_state = "garrot_I_unwrap"
		return
	icon_state = "garrot_I_[HAS_TRAIT(src, TRAIT_WIELDED) ? "un" : ""]wrap"


/obj/item/twohanded/garrote/unwield(obj/item/source, mob/living/carbon/user)
	if(strangling)
		usr.visible_message("<span class='info'>[usr] removes the [src] from [strangling]'s neck.</span>", \
				"<span class='warning'>You remove the [src] from [strangling]'s neck.</span>")
		strangling.garroted_by.Remove(src)
		strangling = null
		update_icon(UPDATE_ICON_STATE)
		STOP_PROCESSING(SSobj, src)


/obj/item/twohanded/garrote/attack(mob/living/carbon/M as mob, mob/user as mob)
	if(garrote_time > world.time) // Cooldown
		return

	if(!istype(user, /mob/living/carbon/human)) // spap_hand is a proc of /mob/living, user is simply /mob
		return

	var/mob/living/carbon/human/U = user

	if(!wielded)
		to_chat(user, "<span class = 'warning'>You must use both hands to garrote [M]!</span>")
		return

	if(!istype(M, /mob/living/carbon/human))
		to_chat(user, "<span class = 'warning'>You don't think that garroting [M] would be very effective...</span>")
		return

	if(M == U)
		U.suicide() // This will display a prompt for confirmation first.
		return

	if(M.dir != U.dir)
		to_chat(user, "<span class='warning'>You cannot use [src] on [M] from that angle!</span>")
		return

	if(improvised && ((M.head && (M.head.flags_cover & HEADCOVERSMOUTH)) || (M.wear_mask && (M.wear_mask.flags_cover & MASKCOVERSMOUTH)))) // Improvised garrotes are blocked by mouth-covering items.
		to_chat(user, "<span class = 'warning'>[M]'s neck is blocked by something [M.p_theyre()] wearing!</span>")

	if(strangling)
		to_chat(user, "<span class = 'warning'>You cannot use [src] on two people at once!</span>")
		return

	user.mode()

	U.swap_hand() // For whatever reason the grab will not properly work if we don't have the free hand active.
	var/obj/item/grab/G = M.grabbedby(U, 1)
	U.swap_hand()

	if(G && istype(G))
		if(improvised) // Not a trash anymore:|
			G.state = GRAB_AGGRESSIVE
			G.hud.icon_state = "kill"
			G.hud.name = "kill"
		else
			G.state = GRAB_NECK
			G.hud.icon_state = "kill"
			G.hud.name = "kill"
			M.AdjustSilence(2 SECONDS)

	garrote_time = world.time + 10
	START_PROCESSING(SSobj, src)
	strangling = M
	update_icon(UPDATE_ICON_STATE)

	playsound(src.loc, 'sound/weapons/cablecuff.ogg', 15, 1, -1)

	M.visible_message("<span class='danger'>[U] comes from behind and begins garroting [M] with the [src]!</span>", \
				  "<span class='userdanger'>[U] begins garroting you with the [src]![improvised ? "" : " You are unable to speak!"]</span>", \
				  "You hear struggling and wire strain against flesh!")


/obj/item/twohanded/garrote/process()
	if(!strangling)
		// Our mark got gibbed or similar
		update_icon(UPDATE_ICON_STATE)
		STOP_PROCESSING(SSobj, src)
		return


	if(!istype(loc, /mob/living/carbon/human))
		strangling = null
		update_icon(UPDATE_ICON_STATE)
		STOP_PROCESSING(SSobj, src)
		return

	var/mob/living/carbon/human/user = loc
	var/obj/item/grab/G

	if(src == user.r_hand && istype(user.l_hand, /obj/item/grab))
		G = user.l_hand

	else if(src == user.l_hand && istype(user.r_hand, /obj/item/grab))
		G = user.r_hand

	else
		user.visible_message("<span class='warning'>[user] loses [user.p_their()] grip on [strangling]'s neck.</span>", \
				 "<span class='warning'>You lose your grip on [strangling]'s neck.</span>")

		strangling.garroted_by.Remove(src)
		strangling = null
		update_icon(UPDATE_ICON_STATE)
		STOP_PROCESSING(SSobj, src)

		return

	if(!G.affecting)
		user.visible_message("<span class='warning'>[user] loses [user.p_their()] grip on [strangling]'s neck.</span>", \
				"<span class='warning'>You lose your grip on [strangling]'s neck.</span>")

		strangling.garroted_by.Remove(src)
		strangling = null
		update_icon(UPDATE_ICON_STATE)
		STOP_PROCESSING(SSobj, src)

		return


	if(improvised)
		strangling.Stuttering(6 SECONDS)
		strangling.apply_damage(2, OXY, BODY_ZONE_HEAD)
		return


	if(!(src in strangling.garroted_by))
		strangling.garroted_by+=src
	strangling.Silence(6 SECONDS) // Non-improvised effects
	strangling.apply_damage(20, OXY, BODY_ZONE_HEAD)


/obj/item/twohanded/garrote/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is wrapping the [src] around [user.p_their()] neck and pulling the handles! It looks like [user.p_theyre()] trying to commit suicide.</span>")
	playsound(src.loc, 'sound/weapons/cablecuff.ogg', 15, 1, -1)
	return OXYLOSS
