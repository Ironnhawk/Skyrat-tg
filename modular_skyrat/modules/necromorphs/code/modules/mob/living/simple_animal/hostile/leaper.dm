//Changelings in their true form.
//Massive health and damage, but move slowly.

/mob/living/simple_animal/hostile/necroleaper
	name = "Leaper"
	real_name = "Leaper"
	desc = "Holy shit, what the fuck is that thing?!"
	speak_emote = list("says with one of its faces")
	emote_hear = list("says with one of its faces")
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/leaper.dmi'
	icon_state = "leaper"
	icon_living = "leaper"
	icon_dead = "leaper"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC
	speed = 1
//	a_intent = "harm"
	stop_automated_movement = 1
	status_flags = CANPUSH
//	ventcrawler = 2
	see_in_dark = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxHealth = 500 //Very durable
	health = 500
	healable = 0
	environment_smash = 15
	melee_damage_lower = 50
	melee_damage_upper = 90
//	see_in_dark = 8
//	see_invisible = SEE_INVISIBLE_MINIMUM
	wander = 1
	attack_verb_continuous = "rips into"
	attack_verb_simple = "rip into"
	attack_sound = 'sound/effects/blobattack.ogg'
	next_move_modifier = 0.5 //Faster attacks
	butcher_results = list(/obj/item/food/meat/slab/human = 15) //It's a pretty big dude. Actually killing one is a feat.
	gold_core_spawnable = 0 //Should stay exclusive to changelings tbh, otherwise makes it much less significant to sight one
	var/datum/action/innate/turn_to_human
	var/datum/action/innate/devour
	var/transformed_time = 0
	var/playstyle_string = "<b><font size=3 color='red'>We have entered our true form!</font> We are unbelievably powerful, and regenerate life at a steady rate. However, most of \
	our abilities are useless in this form, and we must utilise the abilities that we have gained as a result of our transformation. Currently, we are incapable of returning to a human. \
	After several minutes, we will once again be able to revert into a human. Taking too much damage will also turn us back into a human in addition to knocking us out for a long time.</b>"
	var/mob/living/carbon/human/stored_changeling = null //The changeling that transformed
	var/devouring = FALSE //If the true changeling is currently devouring a human
	var/spam_flag = 0 //To stop spam

/mob/living/simple_animal/hostile/true_changeling/New()
	. = ..()
	transformed_time = world.time
	emote("scream")

/mob/living/simple_animal/hostile/true_changeling/Initialize()
	. = ..()
	src << playstyle_string
	turn_to_human = new /datum/action/innate/turn_to_human
	devour = new /datum/action/innate/devour
	turn_to_human.Grant(src)
	devour.Grant(src)
