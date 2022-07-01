/*
	Necromorph Species Base. Parent to all Necromorph Varients.
*/
/datum/species/necromorph
	name = SPECIES_NECROMORPH
	id = SPECIES_NECROMORPH
	sexes = FALSE
	can_have_genitals = FALSE
	default_color = "#FFF"
	limbs_id = "slasher"
	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	eyes_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/eyes.dmi'
	exotic_blood = /datum/reagent/copper
	reagent_flags = PROCESS_ORGANIC
	always_customizable = TRUE
	nojumpsuit = 1
	flavor_text = "Necromorphs are mutated corpses, reshaped into horrific new forms by a recombinant extraterrestrial infection derived from a genetic code etched into the skin of the Markers. The resulting creatures are extremely aggressive and will attack any uninfected organism on sight. The sole purpose of all Necromorphs is to acquire more bodies to convert and spread the infection. They are believed by some to be the heralds of humanity's ascension, but on a more practical level, they are the extremely dangerous result of exposure to the enigmatic devices known as the Markers."
	species_language_holder = /datum/language_holder

	var/marker_spawnable = TRUE //Set this to true to allow the marker to spawn this type of necro. Be sure to unset it on the enhanced version unless desired
	biomass = 80 //This var is defined for all species
	var/require_total_biomass = 0 //If set, this can only be spawned when total biomass is above this value
	var/biomass_reclamation = 1 //The marker recovers cost*reclamation
	var/biomass_reclamation_time = 8 MINUTES //How long does it take for all of the reclaimed biomass to return to the marker? This is a pseudo respawn timer
	var/spawn_method = SPAWN_POINT //What method of spawning from marker should be used? At a point or manual placement? check _defines/necromorph.dm
	var/major_vessel = TRUE //If true, we can fill this mob from the necroqueue
	var/spawner_spawnable = FALSE //If true, a nest can be upgraded to autospawn this unit
	//var/necroshop_item_type = /datum/necroshop_item //Give this a subtype if you want to have special behaviour for when this necromorph is spawned from the necroshop
	var/global_limit = 0 //0 = no limit
	var/ventcrawl = FALSE //Can this necromorph type ventcrawl?
	//lasting_damage_factor = 0.2 //Necromorphs take lasting damage based on incoming hits

	//Single iconstates. These are somewhat of a hack
	var/single_icon = FALSE
	icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/48x48necros.dmi'
	var/icon_normal = "slasher_d"
	var/icon_lying = "slasher_d_lying"
	var/icon_dead = "slasher_d_dead"

//	var/icon_template = 'icons/mob/human_races/species/template.dmi' // Used for mob icon generation for non-32x32 species.
	var/pixel_offset_x = 0                    // Used for offsetting large icons.
	var/pixel_offset_y = 0                    // Used for offsetting large icons.

	/*
		Necromorph customisation system
	*/
	var/list/variants	//Species variants included. This is an assoc list in the format: species_name = list(weight, patron)
						//If patron is true, this variant is not available by default
	var/list/outfits	//Outfits the mob can spawn with, weighted.

	var/list/abilities
	locomotion_limbs = list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)

/////////////////////////////////////////////////////////////////////////////
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		NO_UNDERWEAR,
		FACEHAIR
	)
	inherent_traits = list(
		TRAIT_CAN_STRIP,
		TRAIT_RESISTHEAT,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOMETABOLISM,
		TRAIT_GENELESS,
		TRAIT_TOXIMMUNE,
		TRAIT_OXYIMMUNE,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID


/////////////////////////////////////////////////////////////////////////////
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'

	burnmod = 1.5 // Every 0.1% is 10% above the base.
	brutemod = 1.6
	coldmod = 1.2
	heatmod = 2
	siemens_coeff = 1.4 //Not more because some shocks will outright crit you, which is very unfun

	bodytemp_normal = (BODYTEMP_NORMAL + 70)
	bodytemp_heat_damage_limit = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD
	bodytemp_cold_damage_limit = (T20C - 10)
	changesource_flags = MIRROR_BADMIN | WABBAJACK

/////////////////////////////////////////////////////////////////////////////
////////////////////////// ORGANS FOR ALL SUBTYPES //////////////////////////
/////////////////////////////////////////////////////////////////////////////

	mutant_organs = list(
		/obj/item/organ/brain/necromorph,
		/obj/item/organ/eyes/night_vision/necromorph,
		/obj/item/organ/lungs/necromorph,
		/obj/item/organ/heart/necromorph,
		/obj/item/organ/liver/necromorph,
		/obj/item/organ/tongue/necromorph
	)
	mutanteyes = /obj/item/organ/eyes/night_vision
	mutanttongue = /obj/item/organ/tongue/zombie

	default_mutant_bodyparts = list(
		"tail" = "None",
		"snout" = "None",
		"ears" = "None",
		"legs" = "Normal Legs",
		"wings" = "None",
		"taur" = "None",
		"horns" = "None"
	)


	damage_overlay_type = "xeno"

/////////////////////////////////////////////////////////////////////////////

	bodypart_overides = list(
	BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph,\
	BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph,\
	BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph,\
	BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph,\
	BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph,\
	BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph
	)

	mutant_bodyparts = list(
	BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph,\
	BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph,\
	BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph,\
	BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph,\
	BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph,\
	BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph
	)


	//Audio
	step_volume = 60 //Necromorphs can't wear shoes, so their base footstep volumes are louder
	step_range = 1
	pain_audio_threshold = 0.10
	speech_chance = 100

/datum/species/necromorph/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	.=..()
	C.faction = FACTION_NECROMORPH
	SSnecromorph.major_vessels += C
	C.pixel_x += pixel_offset_x
	C.pixel_y += pixel_offset_y
	add_abilities(C)
	C.set_combat_mode(TRUE)

/datum/species/necromorph/on_species_loss(mob/living/carbon/C, datum/species/old_species, pref_load)
	.=..()
	SSnecromorph.major_vessels -= C
	C.pixel_x -= pixel_offset_x
	C.pixel_y -= pixel_offset_y
	remove_abilities(C)

/datum/species/necromorph/spec_death(gibbed, mob/living/carbon/C)
	.=..()
	SSnecromorph.major_vessels -= C
	remove_abilities(C)

//Individual necromorphs are identified only by their species
/datum/species/necromorph/random_name(gender, unique, lastname)
	var/randname = "[src.name] [rand(0,999)]"
	return randname

/datum/species/necromorph/proc/add_abilities(mob/living/carbon/C)
	C.AddComponent(/datum/component/necro_ability_handler, abilities)

/datum/species/necromorph/proc/remove_abilities(mob/living/carbon/C)
	qdel(C.GetComponent(/datum/component/necro_ability_handler))

/datum/species/necromorph/on_owner_login(mob/living/carbon/human/owner)
	to_chat(owner, "You are a [name]. \n\
	[blurb]\n\
	\n\
	Check the Abilities tab, use the Help ability to find out what your controls and abilities do!")
