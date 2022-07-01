/datum/hud

	var/list/atom/movable/screen/meter/resource/hud_resource = list()


/*
	Target can be any of..
		/datum/hud
		/mob
		/client

	This proc attempts to return all three of those things related to the target
*/
/proc/get_hud_data_for_target(var/target)
	var/list/data = list()
	if (ismob(target))
		var/mob/M = target
		data["mob"] = target
		data["client"] = M.client
		data["hud"] = M.hud_used
	else if (istype(target, /client))
		var/client/C = target
		data["mob"] = C.mob
		data["client"] = C
		data["hud"] = C.mob?.hud_used
	else if (istype(target, /datum/hud))
		var/datum/hud/M = target

		data["mob"] = M.mymob
		data["client"] = M.mymob?.client
		data["hud"] = M

	return data
