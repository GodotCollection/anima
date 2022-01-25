extends Node

const BASE_PATH := 'res://addons/anima/animations/'

enum PIVOT {
	TOP_LEFT,
	TOP_CENTER,
	TOP_RIGHT,
	CENTER_LEFT,
	CENTER,
	CENTER_RIGHT,
	BOTTOM_LEFT,
	BOTTOM_CENTER,
	BOTTOM_RIGHT
}

enum VISIBILITY {
	IGNORE,
	HIDDEN_ONLY,
	TRANSPARENT_ONLY,
	HIDDEN_AND_TRANSPARENT
}

enum GRID {
	TOGETHER,
	SEQUENCE_TOP_LEFT,
	SEQUENCE_BOTTOM_RIGHT,
	COLUMNS_ODD,
	COLUMNS_EVEN,
	ROWS_ODD,
	ROWS_EVEN,
	ODD,
	EVEN,
	FROM_CENTER,
	FROM_POINT,
	RANDOM
}

enum LOOP {
	USE_EXISTING_RELATIVE_DATA,
	RECALCULATE_RELATIVE_DATA,
}

enum TYPE {
	NODE,
	GROUP,
	GRID
}

enum VALUES_IN {
	PIXELS,
	PERCENTAGE
}

const Align = {
	LEFT = HORIZONTAL_ALIGNMENT_LEFT,
	CENTER = HORIZONTAL_ALIGNMENT_CENTER,
	RIGHT = HORIZONTAL_ALIGNMENT_RIGHT,
}

const VAlign = {
	TOP = VERTICAL_ALIGNMENT_TOP,
	CENTER = VERTICAL_ALIGNMENT_CENTER,
	BOTTOM = VERTICAL_ALIGNMENT_BOTTOM,
}

#const EASING = AnimaEasing.EASING

const DEFAULT_DURATION := 0.7
const DEFAULT_ITEMS_DELAY := 0.05
const MINIMUM_DURATION := 0.000001

var _animations_list := []
var _custom_animations := {}

func begin(node: Node, name: String = 'anima', single_shot := false):
	var node_name = 'AnimaNode_' + name
	var anima_node: Node

	for child in node.get_children():
		var child_name: String = child.name

		if child_name.find(node_name) >= 0:
			anima_node = child
			anima_node.clear()
			anima_node.stop()

			return anima_node

	if anima_node == null:
		anima_node = load('res://addons/anima/core/node.gd').new()
		anima_node.name = node_name

		anima_node._init_node(node)

	anima_node.set_single_shot(single_shot)

	return anima_node

func begin_single_shot(node: Node, name: String = "anima"):
	return begin(node, name, true)

func player(node: Node):
	var player = load('./player.gd').new()

	node.add_child(player)

	return player

func get_animation_path() -> String:
	return BASE_PATH

func register_animation(animation_name: String, keyframes: Dictionary) -> void:
	_deregister_animation(animation_name)

	_custom_animations[animation_name] = keyframes

func _deregister_animation(animation_name: String) -> void:
	_custom_animations.erase(animation_name)

func get_available_animations() -> Array:
	if _animations_list.size() == 0:
		var list = _get_animations_list()
		var filtered := []

		for file in list:
			if file.find('.gd.') < 0 and file.find(".gd") > 0:
				filtered.push_back(file.replace('.gdc', '.gd'))

		_animations_list = filtered

	return _animations_list + _custom_animations.keys()

func get_available_animation_by_category() -> Dictionary:
	var animations = get_available_animations()
	var base = get_animation_path()
	var old_category := ''
	var result := {}

	for item in animations:
		var category_and_file = item.replace(base, '').split('/')
		var category = category_and_file[0]
		var file_and_extension = category_and_file[1].split('.')
		var file = file_and_extension[0]

		if not result.has(category):
			result[category] = []

		result[category].push_back(file)

	return result

func get_animation_keyframes(animation_name: String) -> Dictionary:
	if _custom_animations.has(animation_name):
		return _custom_animations[animation_name]

	var resource_file = _get_animation_script_with_path(animation_name)
	if resource_file:
		var script = load(resource_file).new()
		
		return script.KEYFRAMES

	printerr('No animation found with name: ', animation_name)

	return {}

func _get_animation_script_with_path(animation_name: String) -> String:
	if not animation_name.ends_with('.gd'):
		animation_name += '.gd'

	animation_name = AnimaStrings.from_camel_to_snack_case(animation_name)

	for file_name in get_available_animations():
		if file_name is String and file_name.ends_with(animation_name):
			return file_name

	return ''

func is_built_in_animation(animation_name: String) -> bool:
	return _animations_list.find(animation_name) >= 0

func _get_animations_list() -> Array:
	var files = _get_scripts_in_dir(BASE_PATH)
	var filtered := []

	files.sort()
	return files

func _get_scripts_in_dir(path: String, files: Array = []) -> Array:
	var dir = Directory.new()
	if dir.open(path) != OK:
		return files

	dir.list_dir_begin()
	var file_name = dir.get_next()

	while file_name != "":
		if file_name != "." and file_name != "..":
			if dir.current_is_dir():
				_get_scripts_in_dir(path + file_name + '/', files)
			else:
				files.push_back(path + file_name)

		file_name = dir.get_next()

	return files

static func Node(node: Node) -> AnimaDeclarationNode:
	var c := AnimaDeclarationNode.new()

	return c._node(node)

static func Group(group) -> AnimaDeclarationGroup:
	var c := AnimaDeclarationGroup.new()

	return c._group(group)

static func Grid(grid: Node) -> AnimaDeclarationGrid:
	var c := AnimaDeclarationGrid.new()

	return c._grid(grid)

