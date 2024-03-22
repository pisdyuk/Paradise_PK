/mob/living/carbon/human/Topic(href, href_list)
	///////Interactions!!///////
	if(href_list["interaction"])
		if (usr.stat == DEAD || usr.stat == UNCONSCIOUS || usr.restrained())
			return

		//CONDITIONS
		var/mob/living/carbon/human/H = usr
		var/mob/living/carbon/human/P = H.partner
		if (!(P in view(H.loc)))
			return
		var/obj/item/organ/external/temp = H.bodyparts_by_name[BODY_ZONE_PRECISE_R_HAND]
		var/hashands = (temp?.is_usable())
		if (!hashands)
			temp = H.bodyparts_by_name[BODY_ZONE_PRECISE_L_HAND]
			hashands = (temp?.is_usable())
		temp = P.bodyparts_by_name[BODY_ZONE_PRECISE_R_HAND]
		var/hashands_p = (temp?.is_usable())
		if (!hashands_p)
			temp = P.bodyparts_by_name[BODY_ZONE_PRECISE_L_HAND]
			hashands = (temp?.is_usable())
		var/mouthfree = !((H.head && (H.head.flags_cover & HEADCOVERSMOUTH)) || (H.wear_mask && (H.wear_mask.flags_cover & MASKCOVERSMOUTH)))
		var/mouthfree_p = !((P.head && (P.head.flags_cover & HEADCOVERSMOUTH)) || (P.wear_mask && (P.wear_mask.flags_cover & MASKCOVERSMOUTH)))

		if(world.time <= H.last_interract + 1 SECONDS)
			return
		else
			H.last_interract = world.time

		if (href_list["interaction"] == "bow")
			H.custom_emote(message = "кланя[pluralize_ru(H.gender,"ет","ют")]ся [P].")
			if (istype(P.loc, /obj/structure/closet) && P.loc == H.loc)
				P.custom_emote(message = "кланя[pluralize_ru(H.gender,"ет","ют")]ся [P].")

		else if (href_list["interaction"] == "pet")
			if(((!istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands && H.Adjacent(P))
				H.custom_emote(message = "[pick("глад[pluralize_ru(H.gender,"ит","ят")]", "поглажива[pluralize_ru(H.gender,"ет","ют")]")] [P].")
				if (istype(P.loc, /obj/structure/closet))
					P.custom_emote(message = "[pick("глад[pluralize_ru(H.gender,"ит","ят")]", "поглажива[pluralize_ru(H.gender,"ет","ют")]")] [P].")

		else if (href_list["interaction"] == "scratch")
			if(((!istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands && H.Adjacent(P))
				if(H.zone_selected == BODY_ZONE_HEAD && !((P.dna.species.name == SPECIES_MACNINEPERSON) || (P.dna.species.name == SPECIES_GREY) || (P.dna.species.name == SPECIES_UNATHI)))
					H.custom_emote(message = "[pick("чеш[pluralize_ru(H.gender,"ет","ут")] за ухом", "чеш[pluralize_ru(H.gender,"ет","ут")] голову")] [P].")
					if (istype(P.loc, /obj/structure/closet))
						P.custom_emote(message = "[pick("чеш[pluralize_ru(H.gender,"ет","ут")] за ухом", "чеш[pluralize_ru(H.gender,"ет","ут")] голову")] [P].")
				else
					H.custom_emote(message = "[pick("чеш[pluralize_ru(H.gender,"ет","ут")]")] [P].")
					if (istype(P.loc, /obj/structure/closet))
						P.custom_emote(message = "[pick("чеш[pluralize_ru(H.gender,"ет","ут")]")] [P].")

		else if (href_list["interaction"] == "give")
			if(H.Adjacent(P))
				if (((!istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands)
					H.give(P)

		else if (href_list["interaction"] == "kiss")
			if( ((H.Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)))
				H.custom_emote(message = "целу[pluralize_ru(H.gender,"ет","ют")] [P].")
				if (istype(P.loc, /obj/structure/closet))
					P.custom_emote(message = "целу[pluralize_ru(H.gender,"ет","ют")] [P].")
			else if (mouthfree)
				H.custom_emote(message = "посыла[pluralize_ru(H.gender,"ет","ют")] [P] воздушный поцелуй.")

		else if (href_list["interaction"] == "lick")
			if( ((H.Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && mouthfree && mouthfree_p)
				if (prob(90))
					H.custom_emote(message = "лизнул[genderize_ru(H.gender,"","а","о","и")] [P] в щеку.")
					if (istype(P.loc, /obj/structure/closet))
						P.custom_emote(message = "лизнул[genderize_ru(H.gender,"","а","о","и")] [P] в щеку.")
				else
					H.custom_emote(message = "особо тщательно лизнул[genderize_ru(H.gender,"","а","о","и")] [P].")
					if (istype(P.loc, /obj/structure/closet))
						P.custom_emote(message = "особо тщательно лизнул[genderize_ru(H.gender,"","а","о","и")] [P].")

		else if (href_list["interaction"] == "hug")
			if(((H.Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands)
				H.custom_emote(message = "обнима[pluralize_ru(H.gender,"ет","ют")] [P].")
				if (istype(P.loc, /obj/structure/closet))
					P.custom_emote(message = "обнима[pluralize_ru(H.gender,"ет","ют")] [P].")
				playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)

		else if (href_list["interaction"] == "cheer")
			if(((H.Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands)
				H.custom_emote(message = "похлопыва[pluralize_ru(H.gender,"ет","ют")] [P] по плечу.")
				if (istype(P.loc, /obj/structure/closet))
					P.custom_emote(message = "похлопыва[pluralize_ru(H.gender,"ет","ют")] [P] по плечу.")

		else if (href_list["interaction"] == "five")
			if(((H.Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands)
				H.custom_emote(message = "да[pluralize_ru(H.gender,"ёт","ют")] [P] пять.")
				if (istype(P.loc, /obj/structure/closet))
					P.custom_emote(message = "да[pluralize_ru(H.gender,"ёт","ют")] [P] пять.")
				playsound(loc, 'sound/effects/snap.ogg', 25, 1, -1)

		else if (href_list["interaction"] == "handshake")
			if(((H.Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands && hashands_p)
				H.custom_emote(message = "жм[pluralize_ru(H.gender,"ёт","ут")] руку [P].")
				if (istype(P.loc, /obj/structure/closet))
					P.custom_emote(message = "жм[pluralize_ru(H.gender,"ёт","ут")] руку [P].")

		else if (href_list["interaction"] == "bow_affably")
			H.custom_emote(message = "приветливо кивнул[genderize_ru(H.gender,"","а","о","и")] в сторону [P].")
			if (istype(P.loc, /obj/structure/closet))
				P.custom_emote(message = "приветливо кивнул[genderize_ru(H.gender,"","а","о","и")] в сторону [P].")

		else if (href_list["interaction"] == "wave")
			if (!(H.Adjacent(P)) && hashands)
				H.custom_emote(message = "приветливо маш[pluralize_ru(H.gender,"ет","ут")] в сторону [P].")
			else
				H.custom_emote(message = "приветливо маш[pluralize_ru(H.gender,"ет","ут")] в сторону [P].")


		else if (href_list["interaction"] == "slap")
			if(((H.Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands)
				switch(H.zone_selected)
					if(BODY_ZONE_HEAD)
						H.custom_emote(message = "<span class='danger'>да[pluralize_ru(H.gender,"ет","ют")] [P] пощечину!</span>")
						if (istype(P.loc, /obj/structure/closet))
							P.custom_emote(message = "<span class='danger'>да[pluralize_ru(H.gender,"ет","ют")] [P] пощечину!</span>")
						playsound(loc, 'sound/effects/snap.ogg', 50, 1, -1)
						var/obj/item/organ/external/head/O = P.get_organ(BODY_ZONE_HEAD)
						if(O.brute_dam < 5)
							O.receive_damage(1)
						H.do_attack_animation(P)

					if(BODY_ZONE_PRECISE_GROIN)
						H.custom_emote(message = "<span class='danger'>шлёпа[pluralize_ru(H.gender,"ет","ют")] [P] по заднице!</span>")
						if (istype(P.loc, /obj/structure/closet))
							P.custom_emote(message = "<span class='danger'>шлёпа[pluralize_ru(H.gender,"ет","ют")] [P] по заднице!</span>")
						playsound(loc, 'sound/effects/snap.ogg', 50, 1, -1)
						var/obj/item/organ/external/groin/G = P.get_organ(BODY_ZONE_PRECISE_GROIN)
						if(G.brute_dam < 5)
							G.receive_damage(1)
						H.do_attack_animation(P)

					if(BODY_ZONE_PRECISE_MOUTH)
						H.custom_emote(message = "<span class='danger'>да[pluralize_ru(H.gender,"ет","ют")] [P] по губе!</span>")
						if (istype(P.loc, /obj/structure/closet))
							P.custom_emote(message = "<span class='danger'>да[pluralize_ru(H.gender,"ет","ют")] [P] по губе!</span>")
						playsound(loc, 'sound/effects/snap.ogg', 50, 1, -1)
						H.do_attack_animation(P)

		else if (href_list["interaction"] == "fuckyou")
			if(hashands)
				H.custom_emote(message = "<span class='danger'>показыва[pluralize_ru(H.gender,"ет","ют")] [P] средний палец!</span>")
				if (istype(P.loc, /obj/structure/closet) && P.loc == H.loc)
					P.custom_emote(message = "<span class='danger'>показыва[pluralize_ru(H.gender,"ет","ют")] [P] средний палец!</span>")

		else if (href_list["interaction"] == "knock")
			if(((H.Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands)
				H.custom_emote(message = "<span class='danger'>да[pluralize_ru(H.gender,"ет","ют")] [P] подзатыльник!</span>")
				if (istype(P.loc, /obj/structure/closet))
					P.custom_emote(message = "<span class='danger'>да[pluralize_ru(H.gender,"ет","ют")] [P] подзатыльник!</span>")
				playsound(loc, 'sound/weapons/throwtap.ogg', 50, 1, -1)
				var/obj/item/organ/external/head/O = P.get_organ(BODY_ZONE_HEAD)
				if(O.brute_dam < 3)
					O.receive_damage(1)
				H.do_attack_animation(P)

		else if (href_list["interaction"] == "spit")
			if(((H.Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && mouthfree)
				H.custom_emote(message = "<span class='danger'>плю[pluralize_ru(H.gender,"ёт","ют")] в [P]!</span>")
				if(prob(20))
					P.AdjustEyeBlurry(3 SECONDS)
				if(istype(P.loc, /obj/structure/closet))
					P.custom_emote(message = "<span class='danger'>плю[pluralize_ru(H.gender,"ёт","ют")] в [P]!</span>")

		else if (href_list["interaction"] == "threaten")
			if(hashands)
				H.custom_emote(message = "<span class='danger'>гроз[pluralize_ru(H.gender,"ит","ят")] [P] кулаком!</span>")
				if (istype(P.loc, /obj/structure/closet) && H.loc == P.loc)
					P.custom_emote(message = "<span class='danger'>гроз[pluralize_ru(H.gender,"ит","ят")] [P] кулаком!</span>")

		else if (href_list["interaction"] == "tongue")
			if(mouthfree)
				H.custom_emote(message = "<span class='danger'>показыва[pluralize_ru(H.gender,"ет","ют")] [P] язык!</span>")
				if (istype(P.loc, /obj/structure/closet) && H.loc == P.loc)
					P.custom_emote(message = "<span class='danger'>показыва[pluralize_ru(H.gender,"ет","ют")] [P] язык!</span>")

		else if (href_list["interaction"] == "pullwing")
			if(((H.Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands && !H.restrained())
				if(!P.bodyparts_by_name[BODY_ZONE_WING])
					H.custom_emote(message = "пыта[pluralize_ru(H.gender,"ет","ют")]ся поймать [P] за крылья  КОТОРЫХ НЕТ!!!")
					if (istype(P.loc, /obj/structure/closet))
						P.custom_emote(message = "пыта[pluralize_ru(H.gender,"ет","ют")]ся поймать [P] за крылья  КОТОРЫХ НЕТ!!!")
					return
				if (prob(30))
					var/obj/item/organ/external/wing/wing = P.get_organ(BODY_ZONE_WING)
					if ((wing.brute_dam == wing.max_damage || wing.is_dead() || wing.has_fracture()) && prob(20))
						H.custom_emote(message = "<span class='danger'>отрыва[pluralize_ru(H.gender,"ет","ют")] [P] крылья!</span>")
						if (istype(P.loc, /obj/structure/closet))
							P.custom_emote(message = "<span class='danger'>отрыва[pluralize_ru(H.gender,"ет","ют")] [P] крылья!</span>")
						wing.droplimb()
						return
					H.custom_emote(message = "<span class='danger'>дёрга[pluralize_ru(H.gender,"ет","ют")] [P] за крылья!</span>")
					if (istype(P.loc, /obj/structure/closet))
						P.custom_emote(message = "<span class='danger'>дёрга[pluralize_ru(H.gender,"ет","ют")] [P] за крылья!</span>")
					if(wing.brute_dam < 10)
						wing.receive_damage(1)
				else
					H.custom_emote(message = "пыта[pluralize_ru(H.gender,"ет","ют")]ся поймать [P] за крылья!")
					if (istype(P.loc, /obj/structure/closet))
						P.custom_emote(message = "пыта[pluralize_ru(H.gender,"ет","ют")]ся поймать [P] за крылья!")

		else if (href_list["interaction"] == "pull")
			if(((H.Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands && !H.restrained())
				if(!P.bodyparts_by_name[BODY_ZONE_TAIL])
					H.custom_emote(message = "пыта[pluralize_ru(H.gender,"ет","ют")]ся поймать [P] за хвост КОТОРОГО НЕТ!!!")
					if (istype(P.loc, /obj/structure/closet))
						P.custom_emote(message = "пыта[pluralize_ru(H.gender,"ет","ют")]ся поймать [P] за хвост КОТОРОГО НЕТ!!!")
					return

				var/obj/item/organ/internal/cyberimp/tail/blade/implant = P.get_organ_slot(INTERNAL_ORGAN_TAIL_DEVICE)
				if(istype(implant) && implant.activated)  // KEEP YOUR HANDS AWAY FROM ME!
					H.custom_emote(message = span_danger("пыта[pluralize_ru(H.gender,"ет","ют")]ся дёрнуть [P] за хвост, но неожиданно одёргива[pluralize_ru(H.gender,"ет","ют")] руки!"))
					H.emote("scream")
					H.apply_damage(5, implant.damage_type, BODY_ZONE_PRECISE_R_HAND)
					H.apply_damage(5, implant.damage_type, BODY_ZONE_PRECISE_L_HAND)
					return


				if (prob(30))
					var/obj/item/organ/external/tail/tail = P.get_organ(BODY_ZONE_TAIL)
					if ((tail.brute_dam == tail.max_damage || tail.is_dead() || tail.has_fracture()) && prob(20))
						H.custom_emote(message = "<span class='danger'>отрыва[pluralize_ru(H.gender,"ет","ют")] [P] хвост!</span>")
						if (istype(P.loc, /obj/structure/closet))
							P.custom_emote(message = "<span class='danger'>отрыва[pluralize_ru(H.gender,"ет","ют")] [P] хвост!</span>")
						tail.droplimb()
						return
					H.custom_emote(message = "<span class='danger'>дёрга[pluralize_ru(H.gender,"ет","ют")] [P] за хвост!</span>")
					if (istype(P.loc, /obj/structure/closet))
						P.custom_emote(message = "<span class='danger'>дёрга[pluralize_ru(H.gender,"ет","ют")] [P] за хвост!</span>")
					if(tail.brute_dam < 10)
						tail.receive_damage(1)
				else
					H.custom_emote(message = "пыта[pluralize_ru(H.gender,"ет","ют")]ся поймать [P] за хвост!")
					if (istype(P.loc, /obj/structure/closet))
						P.custom_emote(message = "пыта[pluralize_ru(H.gender,"ет","ют")]ся поймать [P] за хвост!")
		return
	..()
