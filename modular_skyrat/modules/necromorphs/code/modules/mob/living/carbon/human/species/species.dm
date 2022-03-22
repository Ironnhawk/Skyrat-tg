/datum/species
	// Descriptors and strings.
//	var/name                                             // Species name.
	var/name_plural                                      // Pluralized name (since "[name]s" is not always valid)
	var/long_desc	=	""								 // An entire pageful of information. Generated at runtime from various variables and procs, check the description section below and override those
	var/blurb = "A completely nondescript species."      // A brief lore summary for use in the chargen screen.

	// Icon/appearance vars.
	var/icobase =      null          // Normal icon set.
	var/deform =       null // Mutated icon set.
	var/preview_icon = null
	var/husk_icon =    null

	var/mob_type = /mob/living/carbon/human	//The mob we spawn in order to create a member of this species instantly
	var/health_doll_offset	= WORLD_ICON_SIZE+8	//For this species, the hud health doll is offset this many pixels to the right.
	//This default value is fine for humans and anything roughly the same width as a human, larger creatures will require different numbers
	//The value required depends not only on overall icon size, but also on the empty space on -both- sides of the sprite. Trial and error is the best way to find the right number

	var/icon/default_icon	//Constructed at runtime, this stores an icon which represents a typical member of this species with all values at default. This is mainly for use in UIs and reference

	//This icon_lying var pulls several duties
	//First, if its non-null, it indicates this species has some kind of special behaviour when lying down. This will trigger extra updates and things
	//Secondly, it is the string suffix added to organ iconstates
	//Thirdly, in single icon mode, it is the icon state for lying down
//	var/icon_lying = null
	var/lying_rotation = 90 //How much to rotate the icon when lying down
//	var/layer = BASE_HUMAN_LAYER
//	var/layer_lying	=	LYING_HUMAN_LAYER

	// Damage overlay and masks.
	var/damage_overlays = null
	var/damage_mask =     null
	var/blood_mask =      null

	var/organs_icon		//species specific internal organs icons

	var/default_h_style = "Bald"
	var/default_f_style = "Shaved"
	var/default_g_style = "None"

	var/race_key = 0                          // Used for mob icon cache string.
	var/icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/48x48necros.dmi'
//	var/pixel_offset_x = 0                    // Used for offsetting large icons.
//	var/pixel_offset_y = 0                    // Used for offsetting large icons.
	var/antaghud_offset_x = 0                 // As above, but specifically for the antagHUD indicator.
	var/antaghud_offset_y = 0                 // As above, but specifically for the antagHUD indicator.

	var/mob_size	= MOB_MEDIUM
	var/strength    = STR_MEDIUM
	var/can_pull_mobs = MOB_PULL_SAME
//	var/can_pull_size = ITEM_SIZE_NO_CONTAINER

		//Audio vars
	var/step_volume = 30	//Base volume of ALL footstep sounds for this mob
	var/step_range = -1		//Base volume of ALL footstep sounds for this mob. Each point of range adds or subtracts two tiles from the actual audio distance
	var/step_priority = 0	//Base priority of species-specific footstep sounds. Zero disables them
	var/pain_audio_threshold = 0	//If a mob takes damage equal to this portion of its total health, (and audio files exist), it will scream in pain
	var/list/species_audio = list()	//An associative list of lists, in the format SOUND_TYPE = list(sound_1, sound_2)
		//In addition, the list of sounds supports weighted picking (default weight 1 if unspecified).
		//For example: (sound_1, sound_2 = 0.5) will result in sound_2 being played half as often as sound_1
	var/list/speech_chance                    // The likelihood of a speech sound playing.
	var/list/species_audio_volume = list()		//An associative list, in the format SOUND_TYPE = VOLUME_XXX. Values set here will override the volume of species audio files

	// Health and Defense
	var/total_health = 120                   // Point at which the mob will enter crit.
	var/healing_factor	=	0.07				//Base damage healed per organ, per tick
	var/burn_heal_factor = 1				//When healing burns passively, the heal amount is multiplied by this
	var/max_heal_threshold	=	0.6			//Wounds can only autoheal if the damage is less than this * max_damage
	var/wound_remnant_time = 10 MINUTES	//How long fully-healed wounds stay visible before vanishing
	var/limb_health_factor	=	1	//Multiplier on max health of limbs
	var/pain_shock_threshold	=	50	//The mob starts going into shock when total pain reaches this value
	var/stability = 1	//Multiplier on resistance to physical forces. Higher value makes someone harder to knock down with forcegun/etc
	var/lasting_damage_factor = 0	//If nonzero, the mob suffers lasting damage equal to this percentage of all incoming damage

	// Combat vars.
	var/list/unarmed_types = list()          // Possible unarmed attacks that the mob will use in combat,
	var/list/unarmed_attacks = null           // populated at runtime, don't touch
	var/evasion = 10						//Base chance for projectile attacks to miss this mob
	var/modifier_verbs						//A list of key modifiers and procs, in the format Key = list(proc path, priority, arg1, arg2, arg3... etc)
	var/reach = 1	//How many tiles away can this mob grab and hit things. Only partly implemented
	//Any number of extra arguments allowed. Only key and proc path are mandatory. Default priority is 1 and will be used if none is supplied.
	//Key must be one of the KEY_XXX defines in defines/client.dm
	var/list/organ_substitutions = list()


	var/list/natural_armour_values            // Armour values used if naked.
	var/brute_mod =      1                    // Physical damage multiplier.
	var/burn_mod =       1                    // Burn damage multiplier.
	var/oxy_mod =        1                    // Oxyloss modifier
	var/toxins_mod =     1                    // Toxloss modifier
	var/radiation_mod =  1                    // Radiation modifier
	var/flash_mod =      1                    // Stun from blindness modifier.
	var/metabolism_mod = 1                    // Reagent metabolism modifier
	var/stun_mod =       1                    // Stun period modifier.
	var/paralysis_mod =  1                    // Paralysis period modifier.
	var/weaken_mod =     1                    // Weaken period modifier.
	var/can_obliterate	=	TRUE			  // If false, this mob won't be deleted when gibbed. Though all their limbs will still be blasted off

	//Movement
	var/slowdown = 0              // Passive movement speed malus (or boost, if negative)

	var/slow_turning = FALSE		//If true, mob goes on move+click cooldown when rotating in place, and can't turn+move in the same step
	var/list/locomotion_limbs = list(BP_L_LEG, BP_R_LEG, BP_L_FOOT, BP_R_FOOT)	//What limbs does this species use to move? It goes slower when these are missing/broken/splinted
	var/lying_speed_factor = 0.25	//Our speed is multiplied by this when crawling

	//Interaction
	var/limited_click_arc = 0	  //If nonzero, the mob is limited to clicking on things in X degrees arc infront of it. Best combined with slow turning. Recommended values, 45 or 90
	var/list/grasping_limbs = list(BP_R_HAND, BP_L_HAND)	//What limbs does this mob use for interacting with objects?
	var/bodytype	=	null	//Used in get_bodytype which determines what clothes the mob can wear. If null, the species name is used instead

	var/biomass	=	80	//How much biomass does it cost to spawn this (for necros) and how much does it yield when absorbed by a marker
	//This is in kilograms, and is thus approximately the mass of an average human male adult
	var/mass = 80	//Actual mass of the resulting mob

	// Body/form vars.
	var/list/inherent_verbs 	  // Species-specific verbs.
	var/has_fine_manipulation = 1 // Can use small items.
	var/can_pickup	=	TRUE	  // Can pickup items at all
	var/siemens_coefficient = 1   // The lower, the thicker the skin and better the insulation.
	var/species_flags = 0         // Various specific features.
	var/appearance_flags = 0      // Appearance/display related features.
	var/spawn_flags = 0           // Flags that specify who can spawn as this species
	var/primitive_form            // Lesser form, if any (ie. monkey for humans)
	var/greater_form              // Greater form, if any, ie. human for monkeys.
	var/holder_type
	var/gluttonous                // Can eat some mobs. Values can be GLUT_TINY, GLUT_SMALLER, GLUT_ANYTHING, GLUT_ITEM_TINY, GLUT_ITEM_NORMAL, GLUT_ITEM_ANYTHING, GLUT_PROJECTILE_VOMIT
	var/stomach_capacity = 5      // How much stuff they can stick in their stomach
	var/rarity_value = 1          // Relative rarity/collector value for this species.

	//Vision
	var/view_offset = 0			  //How far forward the mob's view is offset, in pixels.
	var/view_range = 7		  //Mob's vision radius, in tiles. It gets buggy with values below 7, but anything 7+ is flawless
	var/darksight_range = 2       // Native darksight distance.
	var/darksight_tint = null // How shadows are tinted.
	var/vision_flags = SEE_SELF               // Same flags as glasses.
	var/short_sighted                         // Permanent weldervision.



/datum/species/proc/setup_defense(mob/living/carbon/human/H)

//Species level audio wrappers
//--------------------------------
/datum/species/proc/get_species_audio(audio_type)
	var/list/L = species_audio[audio_type]
	if (L)
		return pickweight(L)
	return null

/datum/species/proc/play_species_audio(atom/source, audio_type, vol as num, vary, extrarange as num, falloff, is_global, frequency, is_ambiance = 0)
	var/soundin = get_species_audio(audio_type)
	if (soundin)
		playsound(source, soundin, vol, vary, extrarange, falloff, is_global, frequency, is_ambiance)
		return TRUE
	return FALSE


/mob/proc/play_species_audio()
	return

/mob/living/carbon/human/play_species_audio(atom/source, audio_type, volume = VOLUME_MID, vary = TRUE, extrarange as num, falloff, is_global, frequency, is_ambiance = 0)
	if(dna.species.species_audio_volume[audio_type])
		volume = dna.species.species_audio_volume[audio_type]
	return dna.species.play_species_audio(arglist(args.Copy()))

/mob/proc/get_species_audio()
	return

/mob/living/carbon/human/get_species_audio(audio_type)
	return dna.species.get_species_audio(arglist(args.Copy()))

//Descriptions and documentation
//----------------------------------------
//These are formatted for display in UI windows
/*
/datum/species/proc/get_long_description()
	if (long_desc)
		return long_desc
	.="<b>Health</b>: [get_healthstring()]<br>"
	.+="<b>Biomass</b>: [biomass]kg<br>"
	.+="<b>Evasion</b>: [evasion]%<br>"
	.+="<b>Movespeed</b>: [get_speed_descriptor()]<br><br>"
	.+= get_blurb()
	.+="<br><hr>"
	.+=	get_unarmed_description()
	.+="<br><br><hr>"
	.+= get_ability_descriptions()
	long_desc = .
*/
//This proc exists to be overridden by ubermorph
/datum/species/proc/get_healthstring()
	return "[total_health]"


//This is an awful means to cope with an awful system. Speed/movement code needs redesigned
/datum/species/proc/get_speed_descriptor()
	switch (slowdown)
		if (-10 to -2)
			return "Very fast"
		if (-2 to 0)
			return "Fast"
		if (0 to 2)
			return "Average"
		if (2 to 4)
			return "Slow"
		if (4 to INFINITY)
			return "Very Slow"

//This is a proc so that enhanced necros can get their parent blurb
/datum/species/proc/get_blurb()
	return blurb

//Shows information for the basic attacks of this species
/*
/datum/species/proc/get_unarmed_description()
	for (var/U in unarmed_types)
		var/datum/unarmed_attack/A = new U
		.+= "<b>Basic Attack</b>: [A.name]<br>"
		.+= "[A.delay ? "<b>Interval</b>: [A.delay * 0.1] seconds" : ""]<br>"
		.+= "<b>Damage</b>: [A.damage]"
		if (A.tags.len)
			.+= ",  [english_list(A.tags)]"
		.+= "<br>"
		.+= A.desc
		return 	//We'll only show description for the primary attack, not any weak fallbacks
*/

/datum/species/proc/get_ability_descriptions()
	return ""

//Should this species be affected by traumatic sights? Necromorphs aren't, for example.

/datum/species/proc/psychosis_vulnerable()
	return TRUE


