@tool
extends Control

const Test := {}

func _ready():
	var anima: AnimaNode = Anima.begin_single_shot(self)
	
	anima.set_default_duration(0.3)

	anima.then(
		Anima.Node($Button)
			.anima_position_x(100) \
			.anima_from(300) \
			.anima_easing(AnimaEasing.EASING.EASE_OUT_BACK) \
			.debug()
	)

	anima.play()
