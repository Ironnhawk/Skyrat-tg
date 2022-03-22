

/*
	## TEMPORARY FILE FOR FUNCTION ONLY ##
	## MOBS SHOULD NOT BE STORED IN THE MARKER CODE##
	## ALL MOBS EITHER NEED TO BE SEPERATE SIMPLE MOBS OR CARBONS##


	This is only temporary, as the marker should spawn carbons that are player controlled, not
	simple mobs. All mobs are spawned based on a currency system known as BIOMASS which will need
	to be implemented and a value applied to all /datum/species/necromorph/(variants)

	Currently the species are not loading properly, they are missing their head and torsos and appear
	to be still wearing underwear even with the "NO_UNDERWEAR" trait applied at the parent and individual
	level.

*/
////////////////
// BASE TYPE //
////////////////

//Do not spawn
/mob/living/simple_animal/hostile/necromorph
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	//icon_state = "slasher_d"
	pass_flags = PASSMARKER
	faction = list(ROLE_NECROMORPH)
	bubble_icon = "slasher"
	speak_emote = null //so we use verb_yell/verb_say/etc
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = INFINITY
	unique_name = 1
	combat_mode = TRUE
	see_in_dark = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	initial_language_holder = /datum/language_holder/empty
	var/mob/camera/marker/master = null
	var/obj/structure/necromorph/growth/special/factory = null
	var/independent = FALSE

/mob/living/simple_animal/hostile/necromorph/update_icons()
		remove_atom_colour(FIXED_COLOUR_PRIORITY)

/mob/living/simple_animal/hostile/necromorph/Initialize()
	. = ..()
	if(!independent) //no pulling people deep into the necromorph
		remove_verb(src, /mob/living/verb/pulled)
	else
		pass_flags &= ~PASSMARKER

/mob/living/simple_animal/hostile/necromorph/Destroy()
	if(master)
		master.marker_mobs -= src
	return ..()

/mob/living/simple_animal/hostile/necromorph/get_status_tab_items()
	. = ..()
	if(master)
		. += "Markers to Win: [master.growths_legit.len]/[master.markerwincount]"

/mob/living/simple_animal/hostile/necromorph/growth_act(obj/structure/necromorph/growth/B)
	if(stat != DEAD && health < maxHealth)
		for(var/i in 1 to 2)
			var/obj/effect/temp_visual/heal/H = new /obj/effect/temp_visual/heal(get_turf(src)) //hello yes you are being healed
			H.color = "#000000"
		adjustHealth(-maxHealth*MARKERMOB_HEALING_MULTIPLIER)

/mob/living/simple_animal/hostile/necromorph/fire_act(exposed_temperature, exposed_volume)
	..()
	if(exposed_temperature)
		adjustFireLoss(clamp(0.01 * exposed_temperature, 1, 5))
	else
		adjustFireLoss(5)

/mob/living/simple_animal/hostile/necromorph/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(istype(mover, /obj/structure/necromorph/growth))
		return TRUE

/mob/living/simple_animal/hostile/necromorph/Process_Spacemove(movement_dir = 0)
	for(var/obj/structure/necromorph/growth/B in range(1, src))
		return 1
	return ..()

/mob/living/simple_animal/hostile/necromorph/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	var/spanned_message = say_quote(message)
	var/rendered = "<font color=\"#EE4000\"><b>\[Marker Telepathy\] [real_name]</b> [spanned_message]</font>"
	for(var/M in GLOB.mob_list)
		if(ismarkerovermind(M) || istype(M, /mob/living/simple_animal/hostile/necromorph))
			to_chat(M, rendered)
		if(isobserver(M))
			var/link = FOLLOW_LINK(M, src)
			to_chat(M, "[link] [rendered]")


