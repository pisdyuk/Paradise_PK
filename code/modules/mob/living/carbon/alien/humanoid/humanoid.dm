/mob/living/carbon/alien/humanoid
	name = "alien"
	icon_state = "alien_s"

	butcher_results = list(/obj/item/reagent_containers/food/snacks/monstermeat/xenomeat= 5, /obj/item/stack/sheet/animalhide/xeno = 1)
	var/obj/item/r_store = null
	var/obj/item/l_store = null
	var/caste = ""
	var/alt_icon = 'icons/mob/alienleap.dmi' //used to switch between the two alien icon files.
	var/next_attack = 0
	var/pounce_cooldown = 0
	var/pounce_cooldown_time = 30
	var/leap_on_click = 0
	var/custom_pixel_x_offset = 0 //for admin fuckery.
	var/custom_pixel_y_offset = 0
	pass_flags = PASSTABLE

//This is fine right now, if we're adding organ specific damage this needs to be updated
/mob/living/carbon/alien/humanoid/New()
	if(name == "alien")
		name = text("alien ([rand(1, 1000)])")
	real_name = name
	add_language(LANGUAGE_XENOS)
	add_language(LANGUAGE_HIVE_XENOS)
	..()
	AddSpell(new /obj/effect/proc_holder/spell/alien_spell/regurgitate)
	AddComponent(/datum/component/footstep, FOOTSTEP_MOB_CLAW, 0.5, -11)
	update_icons()

/mob/living/carbon/alien/humanoid/Process_Spacemove(var/check_drift = 0)
	if(..())
		return 1

	return 0


// Determines if mob has and can use his hands like a human
/mob/living/carbon/alien/humanoid/real_human_being()
	return TRUE


///mob/living/carbon/alien/humanoid/bullet_act(var/obj/item/projectile/Proj) taken care of in living

/mob/living/carbon/alien/humanoid/emp_act(severity)
	if(r_store) r_store.emp_act(severity)
	if(l_store) l_store.emp_act(severity)
	..()

/mob/living/carbon/alien/humanoid/ex_act(severity)
	..()

	var/shielded = 0

	var/b_loss = null
	var/f_loss = null
	switch(severity)
		if(1.0)
			gib()
			return

		if(2.0)
			if(!shielded)
				b_loss += 60

			f_loss += 60

			AdjustDeaf(120 SECONDS)
		if(3.0)
			b_loss += 30
			if(prob(50) && !shielded)
				Paralyse(2 SECONDS)
			AdjustDeaf(60 SECONDS)

	take_overall_damage(b_loss, f_loss)

/mob/living/carbon/alien/humanoid/restrained()
	if(handcuffed)
		return 1
	return 0


/mob/living/carbon/alien/humanoid/var/temperature_resistance = T0C+75

/mob/living/carbon/alien/humanoid/show_inv(mob/user as mob)
	user.set_machine(src)

	var/dat = {"<meta charset="UTF-8"><table>
	<tr><td><B>Left Hand:</B></td><td><A href='?src=[UID()];item=[slot_l_hand]'>[(l_hand && !(l_hand.flags&ABSTRACT)) ? l_hand : "<font color=grey>Empty</font>"]</A></td></tr>
	<tr><td><B>Right Hand:</B></td><td><A href='?src=[UID()];item=[slot_r_hand]'>[(r_hand && !(r_hand.flags&ABSTRACT)) ? r_hand : "<font color=grey>Empty</font>"]</A></td></tr>
	<tr><td>&nbsp;</td></tr>"}

	// No need to even show this right now since its unused.

	/*dat += "<tr><td><B>Head:</B></td><td><A href='?src=[UID()];item=[slot_head]'>[(head && !(head.flags&ABSTRACT)) ? head : "<font color=grey>Empty</font>"]</A></td></tr>"

	dat += "<tr><td>&nbsp;</td></tr>"

	dat += "<tr><td><B>Exosuit:</B></td><td><A href='?src=[UID()];item=[slot_wear_suit]'>[(wear_suit && !(wear_suit.flags&ABSTRACT)) ? wear_suit : "<font color=grey>Empty</font>"]</A></td></tr>"*/

	dat += "<tr><td><B>Chitin pouches:</B></td><td><A href='?src=[UID()];item=[slot_l_store]'>"
	if(l_store && !(l_store.flags&ABSTRACT))
		dat += "Left (Full)"
	else
		dat += "<font color=grey>Left (Empty)</font>"

	dat += "</A>&nbsp;<A href='?src=[UID()];item=[slot_r_store]'>"
	if(r_store && !(r_store.flags&ABSTRACT))
		dat += "Right (Full)"
	else
		dat += "<font color=grey>Right (Empty)</font>"

	if(handcuffed)
		dat += "<tr><td><B>Handcuffed:</B> <A href='?src=[UID()];item=[slot_handcuffed]'>Remove</A></td></tr>"
	if(legcuffed)
		dat += "<tr><td><A href='?src=[UID()];item=[slot_legcuffed]'>Legcuffed</A></td></tr>"

	dat += {"</table>
	<A href='?src=[user.UID()];mach_close=mob\ref[src]'>Close</A>
	"}

	var/datum/browser/popup = new(user, "mob\ref[src]", "[src]", 440, 500)
	popup.set_content(dat)
	popup.open()

/mob/living/carbon/alien/humanoid/canBeHandcuffed()
	return 1

/mob/living/carbon/alien/humanoid/cuff_resist(obj/item/I)
	playsound(src, 'sound/voice/hiss5.ogg', 40, 1, 1)  //Alien roars when starting to break free
	..(I, cuff_break = TRUE)

/mob/living/carbon/alien/humanoid/get_standard_pixel_y_offset(lying = 0)
	if(leaping)
		return -32
	else if(custom_pixel_y_offset)
		return custom_pixel_y_offset
	else
		return initial(pixel_y)

/mob/living/carbon/alien/humanoid/get_standard_pixel_x_offset(lying = 0)
	if(leaping)
		return -32
	else if(custom_pixel_x_offset)
		return custom_pixel_x_offset
	else
		return initial(pixel_x)

/mob/living/carbon/alien/humanoid/get_permeability_protection()
	return 0.8

/mob/living/carbon/alien/humanoid/toggle_move_intent() //because with movement intent change our pose changes
	..()
	update_icons()


/mob/living/carbon/alien/humanoid/examine(mob/user)
	. = ..()
	if(!key)
		. += span_deadsay("[p_their(TRUE)] eyes have no spark of life.")
		. += "<BR>"

	if(handcuffed)
		if(istype(handcuffed, /obj/item/restraints/handcuffs/cable/zipties))
			. += span_warning("[p_they(TRUE)] [p_are()] [bicon(handcuffed)] restrained with zipties!")
		else if(istype(handcuffed, /obj/item/restraints/handcuffs/cable))
			. += span_warning("[p_they(TRUE)] [p_are()] [bicon(handcuffed)] restrained with cable!")
		else
			. += span_warning("[p_they(TRUE)] [p_are()] [bicon(handcuffed)] handcuffed!")

	if(legcuffed)
		. += span_warning("[p_they(TRUE)] [p_are()] [bicon(legcuffed)] restrained with [legcuffed]!")

