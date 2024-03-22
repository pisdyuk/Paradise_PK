// Ion Rifles //
/obj/item/gun/energy/ionrifle
	name = "ion rifle"
	desc = "A man portable anti-armor weapon designed to disable mechanical threats"
	icon_state = "ionrifle"
	item_state = null	//so the human update icon uses the icon_state instead.
	fire_sound = 'sound/weapons/ionrifle.ogg'
	origin_tech = "combat=4;magnets=4"
	w_class = WEIGHT_CLASS_HUGE
	can_holster = FALSE
	flags =  CONDUCT
	slot_flags = SLOT_BACK
	zoomable = TRUE
	zoom_amt = 7
	ammo_type = list(/obj/item/ammo_casing/energy/ion)
	ammo_x_offset = 3
	flight_x_offset = 17
	flight_y_offset = 9

/obj/item/gun/energy/ionrifle/emp_act(severity)
	return

/obj/item/gun/energy/ionrifle/carbine
	name = "ion carbine"
	desc = "The MK.II Prototype Ion Projector is a lightweight carbine version of the larger ion rifle, built to be ergonomic and efficient."
	icon_state = "ioncarbine"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = SLOT_BELT
	zoomable = FALSE
	ammo_x_offset = 2
	flight_x_offset = 18
	flight_y_offset = 11

// Decloner //
/obj/item/gun/energy/decloner
	name = "biological demolecularisor"
	desc = "A gun that discharges high amounts of controlled radiation to slowly break a target into component elements."
	icon_state = "decloner"
	origin_tech = "combat=4;materials=4;biotech=5;plasmatech=6"
	ammo_type = list(/obj/item/ammo_casing/energy/declone)
	ammo_x_offset = 1


/obj/item/gun/energy/decloner/update_icon_state()
	return


/obj/item/gun/energy/decloner/update_overlays()
	. = list()
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	if(cell.charge > shot.e_cost)
		. += "decloner_spin"


// Flora Gun //
/obj/item/gun/energy/floragun
	name = "floral somatoray"
	desc = "A tool that discharges controlled radiation which induces mutation in plant cells."
	icon_state = "flora"
	item_state = "gun"
	fire_sound = 'sound/effects/stealthoff.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/flora/yield, /obj/item/ammo_casing/energy/flora/mut)
	origin_tech = "materials=2;biotech=4"
	modifystate = TRUE
	ammo_x_offset = 1
	selfcharge = TRUE

// Meteor Gun //
/obj/item/gun/energy/meteorgun
	name = "meteor gun"
	desc = "For the love of god, make sure you're aiming this the right way!"
	icon = 'icons/obj/weapons/projectile.dmi'
	icon_state = "riotgun"
	item_state = "c20r"
	fire_sound = 'sound/weapons/gunshots/gunshot_shotgun.ogg'
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = list(/obj/item/ammo_casing/energy/meteor)
	cell_type = /obj/item/stock_parts/cell/potato
	clumsy_check = FALSE //Admin spawn only, might as well let clowns use it.
	selfcharge = TRUE

/obj/item/gun/energy/meteorgun/pen
	name = "meteor pen"
	desc = "The pen is mightier than the sword."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "pen"
	item_state = "pen"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY

// Mind Flayer //
/obj/item/gun/energy/mindflayer
	name = "\improper Mind Flayer"
	desc = "A prototype weapon recovered from the ruins of Research-Station Epsilon."
	icon_state = "xray"
	item_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/mindflayer)
	ammo_x_offset = 2

// Energy Crossbows //
/obj/item/gun/energy/kinetic_accelerator/crossbow
	name = "mini energy crossbow"
	desc = "A weapon favored by syndicate stealth specialists."
	icon_state = "crossbow"
	item_state = "crossbow"
	w_class = WEIGHT_CLASS_SMALL
	materials = list(MAT_METAL=2000)
	origin_tech = "combat=4;magnets=4;syndicate=4"
	suppressed = 1
	ammo_type = list(/obj/item/ammo_casing/energy/bolt)
	weapon_weight = WEAPON_LIGHT
	unique_rename = 0
	overheat_time = 20
	holds_charge = TRUE
	unique_frequency = TRUE
	can_flashlight = 0
	max_mod_capacity = 0
	empty_state = null

/obj/item/gun/energy/kinetic_accelerator/crossbow/large
	name = "energy crossbow"
	desc = "A reverse engineered weapon using syndicate technology."
	icon_state = "crossbowlarge"
	w_class = WEIGHT_CLASS_NORMAL
	materials = list(MAT_METAL=4000)
	origin_tech = "combat=4;magnets=4;syndicate=2"
	suppressed = 0
	ammo_type = list(/obj/item/ammo_casing/energy/bolt/large)

/obj/item/gun/energy/kinetic_accelerator/crossbow/large/cyborg
	desc = "One and done!"
	icon_state = "crossbowlarge"
	origin_tech = null
	materials = list()

/obj/item/gun/energy/kinetic_accelerator/suicide_act(mob/user)
	if(!suppressed)
		playsound(loc, 'sound/weapons/kenetic_reload.ogg', 60, 1)
	user.visible_message("<span class='suicide'>[user] cocks the [name] and pretends to blow [user.p_their()] brains out! It looks like [user.p_theyre()] trying to commit suicide!</b></span>")
	shoot_live_shot(user, user, FALSE, FALSE)
	return OXYLOSS

// Plasma Cutters //
/obj/item/gun/energy/plasmacutter
	name = "plasma cutter"
	desc = "A mining tool capable of expelling concentrated plasma bursts. You could use it to cut limbs off of xenos! Or, you know, mine stuff."
	icon_state = "plasmacutter"
	item_state = "plasmacutter"
	modifystate = FALSE
	origin_tech = "combat=1;materials=3;magnets=2;plasmatech=3;engineering=1"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma)
	usesound = 'sound/items/welder.ogg'
	toolspeed = 1
	container_type = OPENCONTAINER
	flags = CONDUCT
	attack_verb = list("attacked", "slashed", "cut", "sliced")
	force = 12
	sharp = 1
	can_charge = FALSE

/obj/item/gun/energy/plasmacutter/examine(mob/user)
	. = ..()
	if(cell)
		. += "<span class='notice'>[src] is [round(cell.percent())]% charged.</span>"

/obj/item/gun/energy/plasmacutter/attackby(obj/item/A, mob/user)
	if(istype(A, /obj/item/stack/sheet/mineral/plasma))
		if(cell.charge >= cell.maxcharge)
			to_chat(user,"<span class='notice'>[src] is already fully charged.")
			return
		var/obj/item/stack/sheet/S = A
		S.use(1)
		cell.give(1000)
		on_recharge()
		to_chat(user, "<span class='notice'>You insert [A] in [src], recharging it.</span>")
	else if(istype(A, /obj/item/stack/ore/plasma))
		if(cell.charge >= cell.maxcharge)
			to_chat(user,"<span class='notice'>[src] is already fully charged.")
			return
		var/obj/item/stack/ore/S = A
		S.use(1)
		cell.give(500)
		on_recharge()
		to_chat(user, "<span class='notice'>You insert [A] in [src], recharging it.</span>")
	else
		return ..()

/obj/item/gun/energy/plasmacutter/update_overlays()
	return list()

/obj/item/gun/energy/plasmacutter/adv
	name = "advanced plasma cutter"
	icon_state = "adv_plasmacutter"
	item_state = "adv_plasmacutter"
	origin_tech = "combat=3;materials=4;magnets=3;plasmatech=4;engineering=2"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/adv)
	force = 15

/obj/item/gun/energy/plasmacutter/adv/mega
	name = "magmite plasma cutter"
	icon_state = "adv_plasmacutter_m"
	item_state = "plasmacutter_mega"
	desc = "A mining tool capable of expelling concentrated plasma bursts. You could use it to cut limbs off xenos! Or, you know, mine stuff. This one has been enhanced with plasma magmite."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/adv/mega)
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL

/obj/item/gun/energy/plasmacutter/shotgun
	name = "plasma cutter shotgun"
	desc = "An industrial-grade, heavy-duty mining shotgun."
	icon_state = "miningshotgun"
	item_state = "miningshotgun"
	origin_tech = "combat=5;materials=5;magnets=5;plasmatech=6;engineering=5"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/shotgun)
	force = 10

/obj/item/gun/energy/plasmacutter/shotgun/mega
	name = "magmite plasma cutter shotgun"
	icon_state = "miningshotgun_mega"
	item_state = "miningshotgun_mega"
	desc = "An industrial-grade, heavy-duty mining shotgun. This one seems upgraded with plasma magmite."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/shotgun/mega)
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL

// Wormhole Projectors //
/obj/item/gun/energy/wormhole_projector
	name = "bluespace wormhole projector"
	desc = "A projector that emits high density quantum-coupled bluespace beams."
	ammo_type = list(/obj/item/ammo_casing/energy/wormhole, /obj/item/ammo_casing/energy/wormhole/orange)
	item_state = null
	icon_state = "wormhole_projector1"
	origin_tech = "combat=4;bluespace=6;plasmatech=4;engineering=4"
	charge_delay = 5
	selfcharge = TRUE
	var/obj/effect/portal/wormhole_projector/blue
	var/obj/effect/portal/wormhole_projector/orange


/obj/item/gun/energy/wormhole_projector/update_icon_state()
	icon_state = "wormhole_projector[select]"
	item_state = icon_state


/obj/item/gun/energy/wormhole_projector/process_chamber()
	..()
	select_fire(usr)


/obj/item/gun/energy/wormhole_projector/portal_destroyed(obj/effect/portal/wormhole_projector/portal)
	if(portal.is_orange)
		orange = null
		blue?.target = null
	else
		blue = null
		orange?.target = null


/obj/item/gun/energy/wormhole_projector/proc/create_portal(obj/item/projectile/beam/wormhole/projectile)

	var/obj/effect/portal/wormhole_projector/portal = new(get_turf(projectile), creation_object = src)

	if(projectile.is_orange)
		if(!QDELETED(orange))
			qdel(orange)
		orange = portal
		portal.is_orange = TRUE
		portal.update_icon(UPDATE_ICON_STATE)
	else
		if(!QDELETED(blue))
			qdel(blue)
		blue = portal

	if(orange && blue)
		blue.target = get_turf(orange)
		orange.target = get_turf(blue)


/* 3d printer 'pseudo guns' for borgs */
/obj/item/gun/energy/printer
	name = "cyborg lmg"
	desc = "A machinegun that fires 3d-printed flachettes slowly regenerated using a cyborg's internal power source."
	icon_state = "l6closed0"
	icon = 'icons/obj/weapons/projectile.dmi'
	cell_type = /obj/item/stock_parts/cell/secborg
	ammo_type = list(/obj/item/ammo_casing/energy/c3dbullet)
	can_charge = FALSE

/obj/item/gun/energy/printer/update_overlays()
	return list()

/obj/item/gun/energy/printer/emp_act()
	return

// Instakill Lasers //
/obj/item/gun/energy/laser/instakill
	name = "instakill rifle"
	icon_state = "instagib"
	item_state = "instagib"
	desc = "A specialized ASMD laser-rifle, capable of flat-out disintegrating most targets in a single hit."
	ammo_type = list(/obj/item/ammo_casing/energy/instakill)
	force = 60
	origin_tech = "combat=7;magnets=6"

/obj/item/gun/energy/laser/instakill/emp_act() //implying you could stop the instagib
	return

/obj/item/gun/energy/laser/instakill/red
	desc = "A specialized ASMD laser-rifle, capable of flat-out disintegrating most targets in a single hit. This one has a red design."
	icon_state = "instagibred"
	item_state = "instagibred"
	ammo_type = list(/obj/item/ammo_casing/energy/instakill/red)

/obj/item/gun/energy/laser/instakill/blue
	desc = "A specialized ASMD laser-rifle, capable of flat-out disintegrating most targets in a single hit. This one has a blue design."
	icon_state = "instagibblue"
	item_state = "instagibblue"
	ammo_type = list(/obj/item/ammo_casing/energy/instakill/blue)

// HONK Rifle //
/obj/item/gun/energy/clown
	name = "HONK Rifle"
	desc = "Clown Planet's finest."
	icon_state = "honkrifle"
	item_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/clown)
	clumsy_check = FALSE
	selfcharge = TRUE
	ammo_x_offset = 3

/obj/item/gun/energy/toxgun
	name = "plasma pistol"
	desc = "A specialized firearm designed to fire lethal bolts of toxins."
	icon_state = "toxgun"
	w_class = WEIGHT_CLASS_NORMAL
	origin_tech = "combat=4;magnets=4;powerstorage=3"
	ammo_type = list(/obj/item/ammo_casing/energy/toxplasma)
	shaded_charge = TRUE

// Energy Sniper //
/obj/item/gun/energy/sniperrifle
	name = "L.W.A.P. Sniper Rifle"
	desc = "A rifle constructed of lightweight materials, fitted with a SMART aiming-system scope."
	icon_state = "esniper"
	origin_tech = "combat=6;materials=5;powerstorage=4"
	ammo_type = list(/obj/item/ammo_casing/energy/sniper)
	item_state = null
	weapon_weight = WEAPON_HEAVY
	slot_flags = SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	can_holster = FALSE
	zoomable = TRUE
	zoom_amt = 7 //Long range, enough to see in front of you, but no tiles behind you.
	shaded_charge = TRUE

/obj/item/gun/energy/bsg
	name = "\improper Б.С.П"
	desc = "Большая С*** Пушка. Использует ядро аномалии потока и кристалл блюспейса для производства разрушительных взрывов энергии, вдохновленный дивизионом БСА Нанотрейзен."
	icon_state = "bsg"
	item_state = "bsg"
	origin_tech = "combat=6;materials=6;powerstorage=6;bluespace=6;magnets=6" //cutting edge technology, be my guest if you want to deconstruct one instead of use it.
	ammo_type = list(/obj/item/ammo_casing/energy/bsg)
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	can_holster = FALSE
	slot_flags = SLOT_BACK
	cell_type = /obj/item/stock_parts/cell/bsg
	shaded_charge = TRUE
	var/has_core = FALSE
	var/has_bluespace_crystal = FALSE
	var/admin_model = FALSE //For the admin gun, prevents crystal shattering, so anyone can use it, and you dont need to carry backup crystals.

/obj/item/gun/energy/bsg/examine(mob/user)
	. = ..()
	if(has_core && has_bluespace_crystal)
		. += "<span class='notice'>[src] полностью рабочая!</span>"
	else if(has_core)
		. += "<span class='warning'>Аномалия потока вставлена, но не хватает БС кристалла.</span>"
	else if(has_bluespace_crystal)
		. += "<span class='warning'>Имеет инкрустированный БС кристалл, но нет установленного ядра аномалии потока.</span>"
	else
		. += "<span class='warning'>Не хватает ядра аномалии потока и БС кристалла для работы.</span>"

/obj/item/gun/energy/bsg/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/stack/ore/bluespace_crystal))
		if(has_bluespace_crystal)
			to_chat(user, "<span class='notice'>В [src] уже инкрустирован БС кристалл.</span>")
			return
		var/obj/item/stack/S = O
		if(!loc || !S || S.get_amount() < 1)
			return
		to_chat(user, "<span class='notice'>Вы загрузили [O] в [src].</span>")
		S.use(1)
		has_bluespace_crystal = TRUE
		update_icon(UPDATE_ICON_STATE)
		return

	if(istype(O, /obj/item/assembly/signaler/anomaly/flux))
		if(has_core)
			to_chat(user, "<span class='notice'>[src] уже имеет [O]!</span>")
			return
		to_chat(user, "<span class='notice'>Вы вставили [O] в [src], и [src] начинает разогреваться.</span>")
		has_core = TRUE
		qdel(O)
		update_icon(UPDATE_ICON_STATE)
	else
		return ..()

/obj/item/gun/energy/bsg/process_fire(atom/target, mob/living/user, message = TRUE, params, zone_override, bonus_spread = 0)
	if(!has_bluespace_crystal)
		to_chat(user, "<span class='warning'>[src] не имеет БС кристалла для генерации заряда!</span>")
		return
	if(!has_core)
		to_chat(user, "<span class='warning'>[src] не имеет аномалии потока для генерации заряда!</span>")
		return
	return ..()


/obj/item/gun/energy/bsg/update_icon_state()
	if(has_core)
		if(has_bluespace_crystal)
			icon_state = "bsg_finished"
		else
			icon_state = "bsg_core"
	else if(has_bluespace_crystal)
		icon_state = "bsg_crystal"
	else
		icon_state = "bsg"


/obj/item/gun/energy/bsg/emp_act(severity)
	..()
	if(prob(75 / severity))
		if(has_bluespace_crystal)
			shatter()

/obj/item/gun/energy/bsg/proc/shatter()
	if(admin_model)
		return
	visible_message("<span class='warning'>БС кристалл [src] треснул!</span>")
	playsound(src, 'sound/effects/pylon_shatter.ogg', 50, TRUE)
	has_bluespace_crystal = FALSE
	update_icon(UPDATE_ICON_STATE)

/obj/item/gun/energy/bsg/prebuilt
	icon_state = "bsg_finished"
	has_bluespace_crystal = TRUE

/obj/item/gun/energy/bsg/prebuilt/Initialize(mapload)
	. = ..()
	has_core = TRUE
	update_icon(UPDATE_ICON_STATE)

/obj/item/gun/energy/bsg/prebuilt/admin
	desc = "Большая С*** Пушка. Лучшим людям - лучшее творение. У этой версии БС кристалл никогда не треснет, и уже загружено ядро аномалии потока."
	admin_model = TRUE

// Temperature Gun //
/obj/item/gun/energy/temperature
	name = "temperature gun"
	icon = 'icons/obj/weapons/gun_temperature.dmi'
	icon_state = "tempgun_4"
	item_state = "tempgun_4"
	slot_flags = SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	desc = "A gun that changes the body temperature of its targets."
	var/temperature = 300
	var/target_temperature = 300
	origin_tech = "combat=4;materials=4;powerstorage=3;magnets=2"

	ammo_type = list(/obj/item/ammo_casing/energy/temp)
	selfcharge = TRUE

	var/powercost = ""
	var/powercostcolor = ""

	var/emagged = FALSE			//ups the temperature cap from 500 to 1000, targets hit by beams over 500 Kelvin will burst into flames
	var/dat = ""

/obj/item/gun/energy/temperature/Initialize(mapload, ...)
	. = ..()
	update_icon(UPDATE_ICON_STATE)
	START_PROCESSING(SSobj, src)


/obj/item/gun/energy/temperature/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/gun/energy/temperature/newshot()
	..()

/obj/item/gun/energy/temperature/attack_self(mob/living/user)
	user.set_machine(src)
	update_dat()
	user << browse({"<meta charset="UTF-8"><TITLE>Temperature Gun Configuration</TITLE><HR>[dat]"}, "window=tempgun;size=510x120")
	onclose(user, "tempgun")

/obj/item/gun/energy/temperature/emag_act(mob/user)
	if(!emagged)
		add_attack_logs(user, src, "emagged")
		emagged = TRUE
		if(user)
			to_chat(user, "<span class='caution'>You double the gun's temperature cap! Targets hit by searing beams will burst into flames!</span>")
		desc = "A gun that changes the body temperature of its targets. Its temperature cap has been hacked."

/obj/item/gun/energy/temperature/Topic(href, href_list)
	if(..())
		return
	usr.set_machine(src)
	add_fingerprint(usr)

	if(href_list["temp"])
		var/amount = text2num(href_list["temp"])
		if(amount > 0)
			target_temperature = min((500 + 500*emagged), target_temperature+amount)
		else
			target_temperature = max(0, target_temperature+amount)
	if(ismob(loc))
		attack_self(loc)
	add_fingerprint(usr)
	return

/obj/item/gun/energy/temperature/process()
	..()
	var/obj/item/ammo_casing/energy/temp/T = ammo_type[select]
	T.temp = temperature
	switch(temperature)
		if(0 to 100)
			T.e_cost = 300
			powercost = "High"
		if(100 to 250)
			T.e_cost = 200
			powercost = "Medium"
		if(251 to 300)
			T.e_cost = 100
			powercost = "Low"
		if(301 to 400)
			T.e_cost = 200
			powercost = "Medium"
		if(401 to 1000)
			T.e_cost = 300
			powercost = "High"
	switch(powercost)
		if("High")
			powercostcolor = "orange"
		if("Medium")
			powercostcolor = "green"
		else
			powercostcolor = "blue"
	if(target_temperature != temperature)
		var/difference = abs(target_temperature - temperature)
		if(difference >= (10 + 40*emagged)) //so emagged temp guns adjust their temperature much more quickly
			if(target_temperature < temperature)
				temperature -= (10 + 40*emagged)
			else
				temperature += (10 + 40*emagged)
		else
			temperature = target_temperature
		update_icon()

		if(istype(loc, /mob/living/carbon))
			var/mob/living/carbon/M = loc
			if(src == M.machine)
				update_dat()
				M << browse("<TITLE>Temperature Gun Configuration</TITLE><HR>[dat]", "window=tempgun;size=510x102")
	return

/obj/item/gun/energy/temperature/proc/update_dat()
	dat = ""
	dat += "Current output temperature: "
	if(temperature > 500)
		dat += "<FONT color=red><B>[temperature]</B> ([round(temperature-T0C)]&deg;C)</FONT>"
		dat += "<FONT color=red><B> SEARING!</B></FONT>"
	else if(temperature > (T0C + 50))
		dat += "<FONT color=red><B>[temperature]</B> ([round(temperature-T0C)]&deg;C)</FONT>"
	else if(temperature > (T0C - 50))
		dat += "<FONT color=black><B>[temperature]</B> ([round(temperature-T0C)]&deg;C)</FONT>"
	else
		dat += "<FONT color=blue><B>[temperature]</B> ([round(temperature-T0C)]&deg;C)</FONT>"
	dat += "<BR>"
	dat += "Target output temperature: "	//might be string idiocy, but at least it's easy to read
	dat += "<A href='?src=[UID()];temp=-100'>-</A> "
	dat += "<A href='?src=[UID()];temp=-10'>-</A> "
	dat += "<A href='?src=[UID()];temp=-1'>-</A> "
	dat += "[target_temperature] "
	dat += "<A href='?src=[UID()];temp=1'>+</A> "
	dat += "<A href='?src=[UID()];temp=10'>+</A> "
	dat += "<A href='?src=[UID()];temp=100'>+</A>"
	dat += "<BR>"
	dat += "Power cost: "
	dat += "<FONT color=[powercostcolor]><B>[powercost]</B></FONT>"


/obj/item/gun/energy/temperature/update_icon_state()
	switch(temperature)
		if(501 to INFINITY)
			item_state = "tempgun_8"
		if(400 to 500)
			item_state = "tempgun_7"
		if(360 to 400)
			item_state = "tempgun_6"
		if(335 to 360)
			item_state = "tempgun_5"
		if(295 to 335)
			item_state = "tempgun_4"
		if(260 to 295)
			item_state = "tempgun_3"
		if(200 to 260)
			item_state = "tempgun_2"
		if(120 to 260)
			item_state = "tempgun_1"
		if(-INFINITY to 120)
			item_state = "tempgun_0"

	icon_state = item_state


/obj/item/gun/energy/temperature/update_overlays()
	. = ..()
	switch(cell.charge)
		if(900 to INFINITY)
			. += "900"
		if(800 to 900)
			. += "800"
		if(700 to 800)
			. += "700"
		if(600 to 700)
			. += "600"
		if(500 to 600)
			. += "500"
		if(400 to 500)
			. += "400"
		if(300 to 400)
			. += "300"
		if(200 to 300)
			. += "200"
		if(100 to 202)
			. += "100"
		if(-INFINITY to 100)
			. += "0"


// Mimic Gun //
/obj/item/gun/energy/mimicgun
	name = "mimic gun"
	desc = "A self-defense weapon that exhausts organic targets, weakening them until they collapse. Why does this one have teeth?"
	icon_state = "disabler"
	ammo_type = list(/obj/item/ammo_casing/energy/mimic)
	clumsy_check = FALSE //Admin spawn only, might as well let clowns use it.
	selfcharge = TRUE
	ammo_x_offset = 3
	var/mimic_type = /obj/item/gun/projectile/automatic/pistol //Setting this to the mimicgun type does exactly what you think it will.

/obj/item/gun/energy/mimicgun/newshot()
	var/obj/item/ammo_casing/energy/mimic/M = ammo_type[select]
	M.mimic_type = mimic_type
	..()

// Sibyl System's Dominator //
/obj/item/gun/energy/dominator
	name = "Доминатор"
	desc = "Проприетарное высокотехнологичное оружие правоохранительной организации Sibyl System, произведённое специально для борьбы с преступностью."
	icon = 'icons/obj/weapons/sibyl.dmi'
	icon_state = "dominator"
	base_icon_state = "dominator"
	item_state = null

	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = SLOT_BELT
	force = 10
	flags =  CONDUCT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	origin_tech = "combat=4;magnets=4"

	ammo_type = list(/obj/item/ammo_casing/energy/dominator/stun, /obj/item/ammo_casing/energy/dominator/paralyzer, /obj/item/ammo_casing/energy/dominator/eliminator)
	var/sound_voice = list(null, 'sound/voice/dominator/nonlethal-paralyzer.ogg','sound/voice/dominator/lethal-eliminator.ogg','sound/voice/dominator/execution-slaughter.ogg')
	var/sound_cd = null
	cell_type = /obj/item/stock_parts/cell/dominator
	can_charge = TRUE
	charge_sections = 3

	can_flashlight = TRUE
	flight_x_offset = 27
	flight_y_offset = 12

	var/is_equipped = FALSE

/obj/item/gun/energy/dominator/select_fire(mob/living/user)
	..()
	if(sibyl_mod && sibyl_mod.voice_is_enabled && !sound_cd)
		var/temp_select = select
		if(sound_voice[select] && select == temp_select)
			sound_cd = addtimer(CALLBACK(src, PROC_REF(select_playvoice), user, temp_select), 2 SECONDS)


/obj/item/gun/energy/dominator/proc/select_playvoice(mob/living/user, temp_select)
	user.playsound_local(get_turf(src), sound_voice[select], 50, FALSE)
	sound_cd = null


/obj/item/gun/energy/dominator/update_icon(updates = ALL)
	is_equipped = ismob(loc)
	..()


/obj/item/gun/energy/dominator/update_icon_state()
	icon_state = base_icon_state

	if(!is_equipped)
		if(!sibyl_mod)
			return
		icon_state = "[base_icon_state][sibyl_mod.auth_id ? "_unlock" : "_lock" ]"
		return

	ratio = CEILING((cell.charge / cell.maxcharge) * charge_sections, 1)
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	var/shot_name = shot.alt_select_name
	var/new_item_state = base_icon_state

	if(cell.charge < shot.e_cost)
		icon_state = "empty"
		item_state = "[new_item_state]_empty"
	else
		icon_state = "[shot_name][ratio]"
		item_state = "[new_item_state][shot_name]"


/obj/item/gun/energy/dominator/update_overlays()
	. = list()
	if(gun_light && can_flashlight)
		var/iconF = gun_light_overlay
		if(gun_light.on)
			iconF = "[gun_light_overlay]_on"
		. += image(icon = icon, icon_state = iconF, pixel_x = flight_x_offset, pixel_y = flight_y_offset)


/obj/item/gun/energy/dominator/equipped(mob/user, slot, initial)
	. = ..()
	update_icon()


/obj/item/gun/energy/dominator/dropped(mob/user, silent = FALSE)
	. = ..()
	update_icon()


/obj/item/gun/energy/emittergun
	name = "Handicraft Emitter Rifle"
	desc = "A rifle constructed of some trash materials. Looks rough but very powerful."
	icon_state = "emittercannonvgovne"
	item_state = null
	origin_tech = "combat=3;materials=3;powerstorage=2;magnets=2"
	weapon_weight = WEAPON_HEAVY
	slot_flags = SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	can_holster = FALSE
	cell_type = /obj/item/stock_parts/cell/emittergun
	ammo_type = list(/obj/item/ammo_casing/energy/emittergun)
	can_charge = TRUE
