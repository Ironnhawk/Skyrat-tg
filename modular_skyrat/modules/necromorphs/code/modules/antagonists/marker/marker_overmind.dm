/*
	TODO: CREATE BIOMASS, REMOVE MARKER_POINTS
		- BIOMASS NEEDS ITS OWN DATUM, NOT IN MARKER OVERMIND and CORE
	TODO: ADD NECROSHOP
	TODO: ADD PROPER STRUCTURES
	TODO: ADD SIGNAL
	TODO: ADD OVERMIND ABILITIES
	TODO: RENAME MARKER OVERMIND to MASTER
	TODO: TRACK ALL NECROMORPHS
		- TRACK ALL SPAWNED & DEAD NECROMORPHS

*/



//Few global vars to track the marker_master
// NEED TO TRACK BIOMASS AND NUMBER OF NECROMORPHS
GLOBAL_LIST_EMPTY(growths) //complete list of all markers made.
GLOBAL_LIST_EMPTY(marker_cores)
GLOBAL_LIST_EMPTY(master_signals)
GLOBAL_LIST_EMPTY(growth_nodes)
GLOBAL_LIST_EMPTY(growth_special)
GLOBAL_LIST_EMPTY(corruption)

/mob/camera/marker //Should we update to /mob/camera/necromorph/master in order to keep all necromorphs under one standard parent name.
	name = "Marker OVERMIND"
	real_name = "Marker OVERMIND"
	desc = "The master. It controls the marker."
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/mastersignal.dmi'
	icon_state = "mastersignal"
	pixel_x = -23
	mouse_opacity = MOUSE_OPACITY_ICON
	move_on_shuttle = 1
	see_in_dark = 8
	invisibility = INVISIBILITY_OBSERVER
	layer = FLY_LAYER
	see_invisible = SEE_INVISIBLE_LIVING
	pass_flags = PASSBLOB
	faction = list(ROLE_NECROMORPH)
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	hud_type = /datum/hud/marker_overmind

	var/datum/corruption/corruption

/*
	DEPRECATED: REMOVE NEED FOR
	```	var/obj/structure/necromorph/growth/special/core/marker_core = null```

*/
	var/obj/structure/necromorph/growth/special/core/marker_core = null // The marker master's core
	var/marker_points = 0 //DEPRECATED - MOVE TO BIOMASS AS RESOURCE.
	var/max_marker_points = OVERMIND_MAX_POINTS_DEFAULT //DEPRECATED - MOVE TO BIOMASS AS RESOURCE.
	var/last_attack = 0
	var/list/marker_mobs = list() //DEPRECATED - USE NECROMORPH SUBSYSTEM FOR MOB TRACKING.

	/// A list of all marker structures - REVISION: Switch from "markers" to "growth"
	var/list/all_growths = list()
	var/list/resource_growths = list()
	var/list/factory_growths = list()
	var/list/node_growths = list()
	var/list/bioluminescence_corruption = list()

	var/last_reroll_time = 0 //time since we last rerolled, used to give free rerolls
	var/nodes_required = TRUE //if the marker needs nodes to place resource and factory markers
	var/placed = FALSE
	var/manualplace_min_time = OVERMIND_STARTING_MIN_PLACE_TIME // Some time to get your bearings
	var/autoplace_max_time = OVERMIND_STARTING_AUTO_PLACE_TIME // Automatically place the core in a random spot
	var/list/growths_legit = list()
	var/max_count = 0 //The biggest it got before death
	var/markerwincount = OVERMIND_WIN_CONDITION_AMOUNT //DEPRECATED - NECROMORPHS DONT WIN BY SIZE.
	var/victory_in_progress = FALSE
	var/rerolling = FALSE
	var/announcement_size = OVERMIND_ANNOUNCEMENT_MIN_SIZE // Announce the biohazard when this size is reached
	var/announcement_time
	var/has_announced = FALSE

/mob/camera/marker/Initialize(mapload, starting_points = OVERMIND_STARTING_POINTS)
	validate_location()
	marker_points = starting_points //STARTING BIOMASS
	manualplace_min_time += world.time
	autoplace_max_time += world.time
	GLOB.master_signals += src
	var/new_name = "[initial(name)] ([rand(1, 999)])"
	name = new_name
	real_name = new_name
	last_attack = world.time
	if(marker_core) //DEPRECATED - CHECK FOR MARKER | CORE IS A SEPERATE ENTITY THAT BEGINS INFECTION AND GROWTH.
		marker_core.update_appearance()
	SSshuttle.registerHostileEnvironment(src)
	. = ..()
	START_PROCESSING(SSobj, src)

/mob/camera/marker/proc/validate_location() // NEED TO REMOVE BLOBSTARTS
	var/turf/T = get_turf(src)
	if(is_valid_turf(T))
		return

	if(LAZYLEN(GLOB.blobstart))
		var/list/blobstarts = shuffle(GLOB.blobstart)
		for(var/_T in blobstarts)
			if(is_valid_turf(_T))
				T = _T
				break
	else // no blob starts so look for an alternate
		for(var/i in 1 to 16)
			var/turf/picked_safe = find_safe_turf()
			if(is_valid_turf(picked_safe))
				T = picked_safe
				break
	if(!T)
		CRASH("No markerspawnpoints and marker spawned in nullspace.")
	forceMove(T)

/mob/camera/marker/can_z_move(direction, turf/start, turf/destination, z_move_flags = NONE, mob/living/rider)
	return FALSE

/mob/camera/marker/proc/is_valid_turf(turf/T) // REMOVE BLOBS ALLOW
	var/area/A = get_area(T)
	if((A && !(A.area_flags & BLOBS_ALLOWED)) || !T || !is_station_level(T.z) || isspaceturf(T))
		return FALSE
	return TRUE

/mob/camera/marker/process()
	if(!marker_core)
		if(!placed)
			if(manualplace_min_time && world.time >= manualplace_min_time)
				to_chat(src, "<b>[span_big("<font color=\"#EE4000\">You may now place your marker core.</font>")]</b>")
				to_chat(src, span_big("<font color=\"#EE4000\">You will automatically place your marker core in [DisplayTimeText(autoplace_max_time - world.time)].</font>"))
				manualplace_min_time = 0
			if(autoplace_max_time && world.time >= autoplace_max_time)
				place_marker_core(1)
		else
			qdel(src)
	else if(!victory_in_progress && (growths_legit.len >= markerwincount))
		victory_in_progress = TRUE
		priority_announce("Biohazard has reached critical mass. Station loss is imminent.", "Biohazard Alert")
		set_security_level("delta")
		max_marker_points = INFINITY
		marker_points = INFINITY
		addtimer(CALLBACK(src), 450)

	if(!victory_in_progress && max_count < growths_legit.len)
		max_count = growths_legit.len

	if(announcement_time && (world.time >= announcement_time || growths_legit.len >= announcement_size) && !has_announced)
		alert_sound_to_playing(sound('modular_skyrat/modules/alerts/sound/alert1.ogg'), override_volume = TRUE)
		priority_announce("Automated air filtration screeing systems have flagged an unknown pathogen in the ventilation systems, quarantine is in effect.", "Level-1 Viral Biohazard Alert", ANNOUNCER_MUTANTS)

		has_announced = TRUE


/mob/camera/marker/Destroy()
	for(var/obj/structure/necromorph/growth/growth_structure as anything in all_growths)
		growth_structure.master = null
	all_growths = null
	resource_growths = null
	factory_growths = null
	node_growths = null
	marker_mobs = null // REPLACE WITH isNecromorph Check

	bioluminescence_corruption = null
	GLOB.master_signals -= src

	SSshuttle.clearHostileEnvironment(src)
	STOP_PROCESSING(SSobj, src)

	return ..()

/mob/camera/marker/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	to_chat(src, span_notice("You are the master!"))
	update_health_hud()
	add_points(0)

/mob/camera/marker/examine(mob/user)
	. = ..()

/mob/camera/marker/update_health_hud()
	if(marker_core)
		var/current_health = round((marker_core.get_integrity() / marker_core.max_integrity) * 100)
		hud_used.healths.maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#82ed00'>[current_health]%</font></div>")
		// for(var/mob/living/simple_animal/hostile/marker/markerbernaut/B in marker_mobs)
		// 	if(B.hud_used && B.hud_used.markerpwrdisplay)
		// 		B.hud_used.markerpwrdisplay.maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#82ed00'>[current_health]%</font></div>")

/mob/camera/marker/proc/add_points(points)
	marker_points = clamp(marker_points + points, 0, max_marker_points)
	hud_used.markerpwrdisplay.maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#e36600'>[round(marker_points)]</font></div>")

/mob/camera/marker/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if (!message)
		return

	if (src.client)
		if(client.prefs.muted & MUTE_IC)
			to_chat(src, span_boldwarning("You cannot send IC messages (muted)."))
			return
		if (!(ignore_spam || forced) && src.client.handle_spam_prevention(message,MUTE_IC))
			return

	if (stat)
		return

	marker_talk(message)

/mob/camera/marker/proc/marker_talk(message)

	message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))

	if (!message)
		return

	src.log_talk(message, LOG_SAY)

	var/message_a = say_quote(message)
	var/rendered = span_big("<font color=\"#EE4000\"><b>\[Marker Telepathy\] [name]()</b> [message_a]</font>")

	for(var/mob/M in GLOB.mob_list)
		if(ismarkerovermind(M) || istype(M, /mob/living/simple_animal/hostile/necromorph))
			to_chat(M, rendered)
		if(isobserver(M))
			var/link = FOLLOW_LINK(M, src)
			to_chat(M, "[link] [rendered]")

/mob/camera/marker/growth_act(obj/structure/necromorph/growth/B)
	return

/mob/camera/marker/get_status_tab_items() // Replace with Biomass, # of Necromorphs, % Corrupted, Marker Integrity, Living Crew
	. = ..()
	if(marker_core)
		. += "Core Health: [marker_core.get_integrity()]"
		. += "Power Stored: [marker_points]/[max_marker_points]"
		. += "Markers to Win: [growths_legit.len]/[markerwincount]"
	if(!placed)
		if(manualplace_min_time)
			. +=  "Time Before Manual Placement: [max(round((manualplace_min_time - world.time)*0.1, 0.1), 0)]"
		. += "Time Before Automatic Placement: [max(round((autoplace_max_time - world.time)*0.1, 0.1), 0)]"

/mob/camera/marker/Move(NewLoc, Dir = 0)
	if(placed)
		var/obj/structure/necromorph/growth/B = locate() in range(OVERMIND_MAX_CAMERA_STRAY, NewLoc)
		if(B)
			forceMove(NewLoc)
		else
			return FALSE
	else
		var/area/A = get_area(NewLoc)
		if(isspaceturf(NewLoc) || istype(A, /area/shuttle)) //if unplaced, can't go on shuttles or space tiles
			return FALSE
		forceMove(NewLoc)
		return TRUE

/mob/camera/marker/mind_initialize()
	. = ..()
	var/datum/antagonist/marker/B = mind.has_antag_datum(/datum/antagonist/marker)
	if(!B)
		mind.add_antag_datum(/datum/antagonist/marker)

/*
	Verbs
*/


/mob/camera/marker/verb/shop_verb()
	set name = "Spawning Menu"
	set category = SPECIES_NECROMORPH

	SSnecromorph.marker.open_shop(src)

/*
//Finds out if the passed thing is the marker player.
//The thing can be a mob, client, or ckey. They will all work
/proc/is_marker_master(var/check)
	if (!istype(SSnecromorph.marker) || !SSnecromorph.marker.player)
		return FALSE	//If theres no marker there cant be a master

	if (istype(check, /mob/dead/observer/eye/signal/master))
		return TRUE	//If it is the master mob then it is the master mob. We only need to do farther checks in the case of master inhabiting a necromorph

	//This all works on key checking anyways, so lets start by finding the key
	var/check_key
	if (ismob(check))
		var/mob/M = check
		if (!M.key)
			//If theres no key its not the master
			return FALSE
		check_key = ckey(M.key)
	else if (ismob(check))
		var/client/C = check
		check_key = C.ckey
	else
		check_key = ckey(check)

	if (!check_key)
		return FALSE

	//Okay we have a key, lets see if it matches
	//Possible future todo: Support for multiple markers here. For now, just one
	if (SSnecromorph.marker.player == check_key)
		//It matches! At last,
		return TRUE

	else
		return FALSE
*/
