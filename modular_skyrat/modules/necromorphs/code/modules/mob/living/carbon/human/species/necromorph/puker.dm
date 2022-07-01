/*
	Slasher variant, the most common necromorph. Has an additional pair of arms with scything blades on the end
*/

/datum/species/necromorph/puker
	name = SPECIES_NECROMORPH_PUKER
	id = SPECIES_NECROMORPH_PUKER
	can_have_genitals = FALSE
	say_mod = "hisses"
	limbs_id = "puker"
	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/puker.dmi'

	bodytype = SPECIES_NECROMORPH_PUKER
	name_plural = "pukers"
	total_health = 176
	biomass = 130
//	require_total_biomass	=	BIOMASS_REQ_T2
	mass = 120
//	view_range = 9
	limb_health_factor = 1.15
//	icon_template = 'icons/mob/necromorph/puker/puker.dmi'
	icon_lying = null
	lying_rotation = 90
	pixel_offset_x = -8
	single_icon = FALSE
	blurb = "A tough and flexible elite who fights by dousing enemies in acid, and is effective at all ranges. Good for crowd control and direct firefights"
	evasion = -10	//Not agile
//	unarmed_types = list(/datum/unarmed_attack/claws/puker)

	//Acid has long since burned out its eyes, somehow the puker sees without them
	//override_organ_types = list(BP_EYES = null)
	//vision_organ = null

	//The puker has functional arms to grapple with
	grasping_limbs = list(BP_R_ARM, BP_L_ARM)
/*
	mob_type = /mob/living/carbon/human/necromorph/puker

	inherent_verbs = list(/mob/living/proc/puker_snapshot, /mob/living/proc/puker_longshot, /mob/living/carbon/human/proc/puker_vomit, /mob/proc/shout, /mob/proc/shout_long)
	modifier_verbs = list(KEY_MIDDLE = list(/mob/living/proc/puker_snapshot),
	KEY_ALT = list(/mob/living/proc/puker_longshot),
	KEY_CTRLALT = list(/mob/living/carbon/human/proc/puker_vomit))

	//Slightly slow than a slasher
	slowdown = 3.75

	//This actually determines what clothing we can wear
	hud_type = /datum/hud_data/necromorph/slasher
*/

	step_priority = 2
	step_volume = 10


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

	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID

/*
	Slasher variant. Damage Calculation and Effects
*/

	damage_overlay_type = "xeno"
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	attack_verb = "slash"

	attack_effect = ATTACK_EFFECT_CLAW

/*
	Slasher variant. Traits
*/

	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOMETABOLISM,
		TRAIT_TOXIMMUNE,
		TRAIT_RESISTHEAT,
		TRAIT_NOBREATH,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RADIMMUNE,
		TRAIT_GENELESS,
		TRAIT_PIERCEIMMUNE,
		TRAIT_NOHUNGER,
		TRAIT_EASYDISMEMBER,
		TRAIT_LIMBATTACHMENT,
		TRAIT_XENO_IMMUNE,
		TRAIT_NOCLONELOSS,
	)


/*
	Slasher variant. Mutant Parts
*/
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

	bodypart_overides = list(
	BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph,\
	BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph,\
	BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph,\
	BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph,\
	BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph,\
	BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph)

	//The puker has functional arms to grapple with
	grasping_limbs = list(BP_R_ARM, BP_L_ARM)

	//Slightly slow than a slasher
	slowdown = 3.75

	species_audio = list(
	SOUND_ATTACK = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_attack_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_attack_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_attack_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_attack_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_attack_5.ogg'),
	SOUND_DEATH = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_death_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_death_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_death_3.ogg'),
	SOUND_FOOTSTEP = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_footstep_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_footstep_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_footstep_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_footstep_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_footstep_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_footstep_6.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_footstep_7.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_footstep_8.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_footstep_9.ogg'),
	SOUND_PAIN = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_pain_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_pain_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_pain_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_pain_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_pain_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_pain_6.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_pain_7.ogg'),
	SOUND_SHOUT = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_6.ogg'),
	SOUND_SHOUT_LONG = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_long_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_long_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_long_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_long_4.ogg'),
	SOUND_SPEECH = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_speech_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_speech_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/puker/puker_speech_3.ogg')
	)

	variants = list(SPECIES_NECROMORPH_PUKER = list(WEIGHT = 2),
	SPECIES_NECROMORPH_PUKER_FLAYED = list(WEIGHT = 1),
	SPECIES_NECROMORPH_PUKER_CLASSIC = list(WEIGHT = 0.5))

	//outfits = list(/decl/hierarchy/outfit/necromorph/puker_biosuit = list(PATRON = TRUE),
	///decl/hierarchy/outfit/naked = list())

//Ancient version, formerly default, now uncommon
/datum/species/necromorph/puker/flayed
	name = SPECIES_NECROMORPH_PUKER_FLAYED
	//icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/puker/puker_flayed.dmi'
	NECROMORPH_VISUAL_VARIANT


/datum/species/necromorph/puker/classic
	name = SPECIES_NECROMORPH_PUKER_CLASSIC
	//icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/puker/puker_classic.dmi'
	NECROMORPH_VISUAL_VARIANT
	icon_lying = "_lying"

	outfits = list()	//This thing has a different shape and can't wear clothing
	bodytype = SPECIES_NECROMORPH_PUKER_CLASSIC	//Does NOT share the same base bodytype, cannot wear puker outfits
//	hud_type = /datum/hud_data/necromorph

#define PUKER_PASSIVE	"<h2>PASSIVE: Corrosive Vengeance:</h2><br>\
When the puker loses a limb, a wave of acid spurts out in all directions, dousing nearby people. This can hurt other necromorphs, so don't stand too close to allies."

#define PUKER_PASSIVE_2	"<h2>PASSIVE: Eyeless Horror:</h2><br>\
Constant exposure to corrosion has long since burned out its eyes, and the puker has learned to cope without them.<br>\
As a result, puker is not blinded if its head is cut off. However, losing its head will affect the vomit ability."

#define PUKER_PASSIVE_3	"<h2>PASSIVE: Crippling Acid:</h2><br>\
All of your abilities douse the victims in acid, which slows their movement speed by 30% as long as its on them."


#define PUKER_SNAP_DESC	"<h2>Snapshot:</h2><br>\
<h3>Hotkey: Middle Click </h3><br>\
<h3>Cooldown: 3 seconds</h3><br>\
Fires an instant autoaimed shot at a target within a 6 tile range, dealing 17.5 burn damage on hit. <br>\
In addition, it douses the victim in acid, dealing up to 17.5 additional burn damage over time <br>\
<br>\
This ability will harmlessly pass over other necromorphs.<br>\
Snapshot requires no manual aiming at all, and is thusly great to use in the middle of a chaotic brawl, to deal extra damage to humans who are already in melee"


#define PUKER_LONGSHOT_DESC "<h2>Long Shot:</h2><br>\
<h3>Hotkey: Alt+Click</h3><br>\
After a half-second windup, Fires a long ranged unguided bolt of acid, dealing 35 burn damage on hit<br>\
In addition, it douses the victim in acid, dealing up to 35 additional burn damage over time <br>\
Long shot is powerful and has no cooldown, but is easily dodged<br>\

This ability will harmlessly pass over other necromorphs.<br>\
Best used for harassment, skirmishing and initiating fights from afar against unwary targets"

#define PUKER_VOMIT_DESC "<h2>Vomit:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click</h3><br>\
After a 1 second windup, the Puker starts vomiting a vast torrent of acid, dousing all tiles in a 4-tile long cone over 3.5 seconds<br>\
The puker is unable to move while vomiting, but you can move your mouse to rotate on the spot and aim it in different directions. <br>\
In addition to splashing on any creatures within the radius, the floor is covered in acid for a long time afterwards, which will be soaked up by any non-necromorph that walks on it<br>\
The acid splashed on floors will accumulate without limit, repeatedly vomiting will make a larger, longer-lasting patch of acid. It will dry up eventually if left alone though. <br>\
If the puker has been decapitated, the range of vomit is significantly reduced.<br>\

Vomit is an extremely powerful signature ability, useful to decimate vast crowds of victims, and deny access to a broad area.<br>\
Be warned that friendly fire is fully active, it can harm other necromorphs as much as your enemies."

/datum/species/necromorph/puker/get_ability_descriptions()
	.= ""
	. += PUKER_PASSIVE
	. += "<hr>"
	. += PUKER_PASSIVE_2
	. += "<hr>"
	. += PUKER_PASSIVE_3
	. += "<hr>"
	. += PUKER_VOMIT_DESC
	. += "<hr>"
	. += PUKER_SNAP_DESC
	. += "<hr>"
	. += PUKER_LONGSHOT_DESC
