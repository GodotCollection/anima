@tool
extends Control

const Test := {}

func _ready():
	var anima: AnimaNode = Anima.begin_single_shot(self)

	anima.then(
		Anima.Node($Button)
			.anima_animation("fadeIn")
	)
