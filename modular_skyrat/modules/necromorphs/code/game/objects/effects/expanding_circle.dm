/obj/effect/temp_visual/expanding_circle
	alpha = 100
	icon = 'modular_skyrat/modules/necromorphs/icons/effects/256x256.dmi'
	icon_state = "circle"
	pixel_x = -112
	pixel_y = -112
	duration = 2 SECONDS

/obj/effect/temp_visual/expanding_circle/Initialize(mapload, _duration, expansion_rate, _color)
	if(_duration)
		duration = _duration
	if(_color)
		color = _color
	.=..()
	transform = transform.Scale(0.01)//Start off tiny
	var/matrix/matrix = new
	animate(src, transform = matrix.Scale(1 + (expansion_rate * (_duration*0.1))), alpha = 0, time = duration)
