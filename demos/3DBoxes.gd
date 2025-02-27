tool
extends Spatial

export (bool) var _play_backwards = false

const DEFAULT_START_POSITION := Vector3(23.142, 1.798, 0)
const TOTAL_BOXES := 20
const DISTANCE := 0.3

export var _test_me:= false setget set_test_me

func _ready():
	AnimaAnimationsUtils.register_animation('3dboxes', _boxes_animation())
	AnimaAnimationsUtils.register_animation('ring', _ring())

	_init_boxes($Node)

	if not Engine.editor_hint:
		_do_animation()

func _do_animation(loop:= true) -> void:
	var start_position: Vector3 = DEFAULT_START_POSITION
	_reset_boxes_position($Node, start_position)

	var anima: AnimaNode = Anima.begin($Node)
	anima.then( Anima.Group($Node, 0.02).anima_animation('3dboxes', 3).debug() )

	if _play_backwards:
		_init_reverse_boxes()
		start_position.z -= 2

	if loop:
		anima.loop()
	else:
		anima.play()
#
#	var ring: AnimaNode = Anima.begin($ring)
#	ring.then( Anima.Node($ring).anima_animation('ring', 3) )
#
#	if _play_backwards:
#		ring.loop_backwards()
#	else:
#		ring.loop()

func _ring() -> Dictionary:
	return { 
		from = {
			"rotation:x": 0, 
		},
		to = {
			"rotation:x": 360
		}
	}

func _boxes_animation() -> Dictionary:
	return {
		from = {
			scale = Vector3(0.1, 1, 1),
			"shader_param:albedo": Color('#6b9eb1')
		},
		30: {
			"shader_param:albedo": Color('#e63946')
		},
		35: {
			x = -28.117,
			easing = Anima.EASING.EASE_OUT_QUAD,
		},
		40: {
			x = 0,
			"shader_param:albedo": Color('#e63946')
		},
		65: {
			x = 0,
			scale = Vector3(0.1, 1, 1)
		},
		85: {
			scale = Vector3.ZERO,
		},
		to = {
			x = -25.619,
			easing = Anima.EASING.EASE_IN_CIRC,
			"rotation:x": 360,
			"shader_param:albedo": Color('#6b9eb1')
		},
		relative = ['x', 'rotation:x']
	}

func _init_reverse_boxes() -> void:
	var node = Node.new()
	var box = $Node.get_child(0)
	var clone = box.duplicate()

	node.add_child(clone)
	add_child(node)

	_init_boxes(node)
	_reset_boxes_position(node, DEFAULT_START_POSITION + Vector3(0, 0, 2))

	var anima_reverse: AnimaNode = Anima.begin(node)
	anima_reverse.then({ group = node, animation = '3dboxes', duration = 3, items_delay = 0.02 })

	anima_reverse.loop_backwards()

func _init_boxes(parentNode: Node) -> void:
	var box := parentNode.get_child(0)

	for i in TOTAL_BOXES:
		var clone := box.duplicate()
		clone.global_transform = box.global_transform

		parentNode.add_child(clone)

func _reset_boxes_position(parentNode: Node, start_position: Vector3) -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	for i in parentNode.get_child_count():
		var box = parentNode.get_child(i)
		if not box is MeshInstance:
			continue

		box.global_transform.origin = start_position + Vector3(DISTANCE, 0, 0) * i
		
		var r = rng.randf_range(0, 360)
		box.rotation.x = r

func set_test_me(_ignore) -> void:
	_do_animation()
