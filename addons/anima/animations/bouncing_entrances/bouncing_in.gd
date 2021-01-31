func generate_animation(anima_tween: AnimaTween, data: Dictionary) -> void:
	var scale_frames = [
		{ percentage = 0, from = Vector2(0.3, 0.3), easing_points = [0.215, 0.61, 0.355, 1] },
		{ percentage = 20, to = Vector2(1, 1), easing_points = [0.215, 0.61, 0.355, 1] },
		{ percentage = 40, to = Vector2(0.9, 0.9), easing_points = [0.215, 0.61, 0.355, 1] },
		{ percentage = 60, to = Vector2(1.03, 1.03), easing_points = [0.215, 0.61, 0.355, 1] },
		{ percentage = 80, to = Vector2(0.97, 0.97), easing_points = [0.215, 0.61, 0.355, 1] },
		{ percentage = 100, to = Vector2(1, 1) },
	]

	var opacity_frames = [
		{ percentage = 0, from = 0 },
		{ percentage = 60, to = 1 },
		{ percentage = 100, to = 1 },
	]

	AnimaNodesProperties.set_pivot(data.node, Anima.PIVOT.CENTER)

	anima_tween.add_frames(data, "scale", scale_frames)
	anima_tween.add_frames(data, "opacity", opacity_frames)
