GLOBAL_LIST_EMPTY(sybsis_registry)
GLOBAL_VAR_INIT(sibsys_automode, TRUE)

/obj/item/sibyl_system_mod
	name = "модуль Sibyl System"
	desc = "Проприетарный модуль от правоохранительной организации на энергетические оружия для подключения к системе Sibyl System"
	icon = 'icons/obj/weapons/sibyl.dmi'
	icon_state = "sibyl_chip"
	item_state = "sibyl_chip"
	w_class = WEIGHT_CLASS_TINY
	origin_tech = "combat=4;magnets=3;engineering=3"
	hitsound = "swing_hit"
	var/obj/item/gun/energy/weapon = null
	var/obj/item/card/id/auth_id = null
	var/state = SIBSYS_STATE_UNINSTALLED
	var/limit = SIBYL_NONLETHAL
	var/emagged = FALSE

	var/voice_is_enabled = TRUE
	var/voice_cd = null

	var/list/available = list()
	var/list/nonlethal_names = list("stun", "disabler", "disable", "non-lethal paralyzer", "practice", "ion",
								"energy", "bluetag", "redtag", "yield", "mutation",
								"goddamn meteor", "plasma burst", "blue", "orange",
								"lightning beam", "clown", "teleport beam", "gun mimic",
								"kinetic")
	var/list/lethal_names = list("kill", "lethal-eliminator", "scatter", "anti-vehicle",
								"snipe", "precise", "declone", "mindfuck", "bolt",
								"heavy bolt", "toxic dart", "spraydown", "accelerator")
	var/list/destructive_names = list("destroy", "execution-slaughter", "annihilate")

/obj/item/sibyl_system_mod/proc/install(obj/item/gun/energy/W, mob/user = null)
	if(user)
		if(!user.drop_transfer_item_to_loc(src, W))
			return
	else
		forceMove(W)
	weapon = W
	weapon.sibyl_mod = src
	weapon.verbs += /obj/item/gun/energy/proc/toggle_voice
	state = SIBSYS_STATE_INSTALLED
	register(user)
	check_unknown_names()
	sync_limit()
	W.update_icon()
	if(user)
		to_chat(user, span_notice("Вы установили [src] в [W]. Установка доступных режимов в соответствии с уровнем опасности ([get_security_level_ru()])."))
		if(!auth_id)
			to_chat(user, span_notice("Требуется авторизация! Приложите ID-карту."))


/obj/item/sibyl_system_mod/proc/register(mob/user)
	GLOB.sybsis_registry += list(src)

	if(!auth_id)
		sibyl_sound(user, 'sound/voice/dominator/link.ogg', 10 SECONDS)

	return TRUE


/obj/item/sibyl_system_mod/proc/uninstall(obj/item/gun/energy/W)
	GLOB.sybsis_registry -= list(src)
	forceMove(get_turf(src))
	W.verbs -= /obj/item/gun/energy/proc/toggle_voice

	state = SIBSYS_STATE_UNINSTALLED
	lock(silent = TRUE)
	W.sibyl_mod = null
	weapon = null
	set_limit(SIBYL_NONLETHAL)
	W.update_icon()
	return state


/obj/item/sibyl_system_mod/attack_self(mob/user)
	..()
	toggle_voice(user)


/obj/item/sibyl_system_mod/proc/toggle_voice(mob/user)
	voice_is_enabled = !voice_is_enabled
	if(user)
		to_chat(user, span_notice("Голосовая подсистема [voice_is_enabled ? "включена" : "отключена"]."))


/obj/item/sibyl_system_mod/proc/lock(mob/user, silent = FALSE)
	if(emagged)
		return FALSE
	auth_id = null
	weapon.update_icon()
	if(!silent && user)
		to_chat(user, span_notice("Блокировка [weapon] включена."))
	return TRUE

/obj/item/sibyl_system_mod/proc/unlock(mob/user, obj/item/card/id/ID)
	if(state != SIBSYS_STATE_INSTALLED)
		return FALSE
	if(ID)
		auth_id = ID
	else //Если емагнули
		auth_id = TRUE
	weapon.update_icon()
	if(user)
		to_chat(user, span_notice("Блокировка [weapon] отключена."))
	return TRUE

/obj/item/sibyl_system_mod/proc/toggleAuthorization(obj/item/card/id/ID, mob/user)
	if(state != SIBSYS_STATE_INSTALLED)
		return FALSE
	if(emagged)
		to_chat(user, span_danger("As you try to swipe [ID], sparks flying out of it!"))
		return
	if(!auth_id)
		unlock(user, ID)
		to_chat(user, span_notice("Вы авторизировали [weapon] в системе Sibyl System под именем [auth_id.registered_name]."))
		sibyl_sound(user, 'sound/voice/dominator/user.ogg', 10 SECONDS)
	else if(auth_id == ID)
		lock(user)
		to_chat(user, span_notice("Вы деавторизировали [weapon] в системе Sibyl System."))
	else if(ACCESS_ARMORY in ID.GetAccess())
		lock(user)
		to_chat(user, span_notice("Вы принудительно деавторизировали [weapon] в системе Sibyl System."))
	weapon.update_icon()
	return TRUE

// Возвращает FALSE если следующий ammo_type[select] ещё пока недоступен, иначе TRUE
/obj/item/sibyl_system_mod/proc/check_select(var/select)
	var/obj/item/ammo_casing/energy/ammo = weapon.ammo_type[select]
	if(lowertext(ammo.select_name) in available)
		return TRUE
	else
		check_unknown_names()
	return FALSE

/obj/item/sibyl_system_mod/proc/check_auth(mob/living/user)
	if(!weapon)
		return FALSE
	if(!emagged)
		if(!auth_id)
			to_chat(user, span_warning("Требуется авторизация! Приложите ID-карту."))
			return FALSE
		if(!find_and_compare_id_cards(user, auth_id))
			to_chat(user, span_warning("Ваша ID-карта не совпадает с авторизованной."))
			return FALSE
	return TRUE


/obj/item/sibyl_system_mod/proc/find_and_compare_id_cards(mob/user, obj/item/card/id/registered_id)
	for(var/obj/item/card/id/found_id in user.get_all_id_cards())
		if(found_id == registered_id)
			return TRUE
	return FALSE

/obj/item/sibyl_system_mod/proc/set_limit(mode)
	if(!weapon)
		return FALSE

	limit = mode
	switch(mode)
		if(SIBYL_NONLETHAL)
			available = nonlethal_names
		if(SIBYL_LETHAL)
			available = nonlethal_names + lethal_names
		if(SIBYL_DESTRUCTIVE)
			available = nonlethal_names + lethal_names + destructive_names

	var/message = "Для [weapon] теперь доступны только данные режимы: [get_available_text()]!"
	weapon.update_icon()
	if(ismob(weapon.loc))
		to_chat(weapon.loc, span_notice("[message]"))
	return TRUE

/obj/item/sibyl_system_mod/proc/sync_limit()
	switch(GLOB.security_level)
		if(SEC_LEVEL_GREEN)
			set_limit(SIBYL_NONLETHAL)
		if(SEC_LEVEL_BLUE)
			set_limit(SIBYL_LETHAL)
		if(SEC_LEVEL_RED)
			set_limit(SIBYL_LETHAL)
		if(SEC_LEVEL_GAMMA)
			set_limit(SIBYL_DESTRUCTIVE)
		if(SEC_LEVEL_EPSILON)
			set_limit(SIBYL_DESTRUCTIVE)
		if(SEC_LEVEL_DELTA)
			set_limit(SIBYL_DESTRUCTIVE)
	if(!check_select(weapon?.select))
		weapon.select_fire()

/obj/item/sibyl_system_mod/proc/check_unknown_names()
	for(var/obj/item/ammo_casing/energy/ammo in weapon.ammo_type)
		if(ammo.select_name in nonlethal_names)
			continue
		if(ammo.select_name in lethal_names)
			continue
		if(ammo.select_name in destructive_names)
			continue
		nonlethal_names += list(ammo.select_name)

/obj/item/sibyl_system_mod/proc/get_available_text()
	var/list/names = list()
	for(var/obj/item/ammo_casing/energy/ammo in weapon.ammo_type)
		if(ammo.select_name in available)
			names += list(ammo.select_name)
	return names.Join(", ")


/obj/item/sibyl_system_mod/proc/sibyl_sound(mob/living/user, sound, time)
	if(user && voice_is_enabled && !voice_cd)
		user.playsound_local(get_turf(user), sound, 50, FALSE)
		voice_cd = addtimer(VARSET_CALLBACK(src, voice_cd, null), time)


/obj/item/sibyl_system_mod/Destroy()
	GLOB.sybsis_registry -= list(src)
	return ..()
