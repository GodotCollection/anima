@tool
extends EditorPlugin

enum EditorPosition { 
	BOTTOM,
	RIGHT
}

func get_name():
	return 'Anima'

func _enter_tree():
	add_autoload_singleton("AnimaUI", 'res://addons/anima/ui/anima_ui.gd')
	add_autoload_singleton("Anima", 'res://addons/anima/core/anima.gd')

func _exit_tree():
	remove_autoload_singleton('AnimaUI')
	remove_autoload_singleton('Anima')
