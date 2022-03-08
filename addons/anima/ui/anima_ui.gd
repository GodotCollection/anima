@tool
extends Node

enum PORT {
	INPUT,
	OUTPUT
}

enum PORT_TYPE {
	LABEL_ONLY,
	ANIMATION,
	EVENT,
	ACTION,
}

enum NODE_TYPE {
	START,
	ANIMATION,
	ACTION,
	MUSIC
}

var _custom_animations := {}
var _animations_list := []

const _is_debug_enabled := false

func get_dpi_scale() -> float:
	return 1.0

func debug(caller, v1: String, v2 = "", v3 = "", v4 = "", v5 = "", v6 = "") -> void:
	if not _is_debug_enabled:
		return

	printt(caller, v1, v2, v3, v4, v5, v6)

	
