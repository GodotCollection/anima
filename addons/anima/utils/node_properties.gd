#
# Different node types have different property names
#
# Example:
#   Control: position is "rect_position"
#   Node2D : position is "offset"
#
# So, this utility class helps the animations to figure out which
# property to animate :)
#
class_name AnimaNodesProperties

static func get_position(node: Node) -> Vector2:
	if node is Control:
		return node.rect_position
	if node is Node2D:
		return node.global_position

	return node.global_transform.origin

static func get_size(node: Node) -> Vector2:
	if node is Control:
		node.get_size()
		return node.get_size()
	elif node is Node2D:
		return node.texture.get_size() * node.scale

	return Vector2.ZERO

static func get_scale(node: Node) -> Vector2:
	if node is Control:
		return node.rect_scale
	
	return node.scale

static func get_rotation(node: Node):
	if node is Control:
		return node.rect_rotation
	elif node is Node2D:
		return node.rotation_degrees

	return node.rotation

static func set_2D_pivot(node: Node, pivot: int) -> void:
	var size: Vector2 = get_size(node)

	match pivot:
		Anima.PIVOT.TOP_CENTER:
			if node is Control:
				node.set_pivot_offset(Vector2(size.x / 2, 0))
			else:
				var position = node.global_position

				node.offset = Vector2(0, size.y / 2)
				node.global_position = position - node.offset
		Anima.PIVOT.TOP_LEFT:
			if node is Control:
				node.set_pivot_offset(Vector2(0, 0))
			else:
				var position = node.global_position

				node.offset = Vector2(size.x / 2, 0)
				node.global_position = position - node.offset
		Anima.PIVOT.CENTER:
			if node is Control:
				node.set_pivot_offset(size / 2)
		Anima.PIVOT.BOTTOM_CENTER:
			if node is Control:
				node.set_pivot_offset(Vector2(size.x / 2, size.y / 2))
			else:
				var position = node.global_position

				node.offset = Vector2(0, -size.y / 2)
				node.global_position = position - node.offset
		Anima.PIVOT.BOTTOM_LEFT:
			if node is Control:
				node.set_pivot_offset(Vector2(0, size.y))
			else:
				var position = node.global_position

				node.offset = Vector2(size.x / 2, size.y)
				node.global_position = position - node.offset
		Anima.PIVOT.BOTTOM_RIGHT:
			if node is Control:
				node.set_pivot_offset(Vector2(size.x, size.y / 2))
			else:
				var position = node.global_position

				node.offset = Vector2(-size.x / 2, size.y / 2)
				node.global_position = position - node.offset
		_:
			printerr('Pivot point not handled yet')

static func get_property_value(node: Node, animation_data: Dictionary, property = null):
	if property == null:
		property = animation_data.property

	if property is Object:
		return property[animation_data.key]

	match property:
		"x", "position:x":
			var position = get_position(node)

			return position.x
		"y", "position:y":
			var position = get_position(node)

			return position.y
		"z", "position:z":
			var position = get_position(node)

			return position.z
		"position":
			return get_position(node)
		"rotation","rotate":
			return get_rotation(node)
		"rotation:x", "rotate:x":
			return get_rotation(node).x
		"rotation:y", "rotate:y":
			if node is Control or node is Node2D:
				return get_rotation(node)

			return get_rotation(node).y
		"rotation:z", "rotate:z":
			return get_rotation(node).z
		"opacity":
			if node is MeshInstance:
				var material = node.get_surface_material(0)

				if material == null:
					return 0.0
				elif material is SpatialMaterial:
					return material.albedo_color.a
				else:
					return material.get_shader_param("opacity")

			return node.modulate.a
		"skew:x":
			return node.get_global_transform().y.x
		"skew:y":
			return node.get_global_transform().x.y
		"size":
			return get_size(node)
		"size:x", "width":
			return get_size(node).x
		"size:y", "height":
			return get_size(node).y

	var p = property.split(':')

	var property_name: String = p[0]
	var rect_property_name: String = 'rect_' + property_name
	var node_property_name: String

	var key = p[1] if p.size() > 1 else null
	var subkey = p[2] if p.size() > 2 else null

	if node.get(property_name):
		node_property_name = property_name
	elif node.get(rect_property_name) != null:
		node_property_name = rect_property_name
	elif property_name in node:
		node_property_name = property_name
	elif rect_property_name in node:
		node_property_name = rect_property_name

	if p[0] == 'shader_param':
		var material: ShaderMaterial
		if node is MeshInstance:
			material = node.get_surface_material(0)
		else:
			material = node.material

		return material.get_shader_param(p[1])

	if node_property_name:
		if subkey:
			return node[property_name][key][subkey]

		if key:
			var prop = node[node_property_name]

			if typeof(prop) == TYPE_RECT2:
				if ['x', 'y'].find(key) >= 0:
					return prop.position[key]

				if key == "w":
					return prop.size.x
				
				return prop.size.y

			if prop is String and key == "length":
				return prop.length()
			elif prop is Object and prop.has_method(key):
				prop.call(key)

			return prop[key]

		return node.get(node_property_name)

	if property.find('__') == 0:
		return 0

	return property_name

static func map_property_to_godot_property(node: Node, property: String) -> Dictionary:
	match property:
		"x", "position:x":
			if node is Control:
				return {
					property = "rect_position",
					key = "x",
				}

			return {
				property = "global_transform",
				key = "origin",
				subkey = "x"
			}
		"y", "position:y":
			if node is Control:
				return {
					property = "rect_position",
					key = "y",
				}

			return {
				property = "global_transform",
				key = "origin",
				subkey = "y"
			}
		"width":
			if node is Control:
				return {
					property = "rect_size",
					key = "x",
				}

			return {
				property = "size",
				key = "x",
			}
		"height":
			if node is Control:
				return {
					property = "rect_size",
					key = "y",
				}

			return {
				property = "size",
				key = "y",
			}
		"z", "position:z":
			if node is Control:
				printerr('position:z is not supported by Control nodes')

			return {
				property = "global_transform",
				key = "origin",
				subkey = "z"
			}
		"position":
			if node is Control:
				return {
					property = "rect_position"
				}
			
			return {
				property = "global_transform",
				key = "origin"
			}
		"opacity":
			if node is MeshInstance:
				var material = node.get_surface_material(0)

				if material == null:
					return {}
				elif material is SpatialMaterial:
					return {
						property = material,
						key = "albedo_color",
						subkey = "a"
					}

				return {
					callback = funcref(material, 'set_shader_param'),
					param = "opacity"
				}
			return {
				property = "modulate",
				key = "a"
			}
		"rotation", "rotate":
			var property_name = "rotation"

			if node is Control:
				property_name = "rect_rotation"
			elif node is Node2D:
				property_name = "rotation_degrees"

			return {
				property = property_name
			}
		"rotation:x", "rotate:x":
			return {
				property = "rotation",
				key = "x"
			}
		"rotation:y", "rotate:y":
			var property_name = "rotation"

			if node is Control:
				return {
					property = "rect_rotation"
				}
			elif node is Node2D:
				return {
					property = "rotation_degrees"
				}

			return {
				property = "rotation",
				key = "y"
			}
		"rotation:z", "rotate:z":
			return {
				property = "rotation",
				key = "z"
			}
		"skew:x":
			if not node is Node2D:
				return {}

			return {
				property = "transform",
				key = "y",
				subkey = "x"
			}
		"skew:y":
			if not node is Node2D:
				return {}

			return {
				property = "transform",
				key = "x",
				subkey = "y"
			}
		"skew":
			return {
			}

	var p = property.split(':')

	var property_name: String = p[0]
	var rect_property_name: String = 'rect_' + property_name
	var node_property_name: String

	var key = p[1] if p.size() > 1 else null
	var subkey = p[2] if p.size() > 2 else null

	if node.get(property_name) or property_name in node:
		node_property_name = property_name
	elif node.get(rect_property_name) or rect_property_name in node:
		node_property_name = rect_property_name

	if p[0] == 'shader_param':
		var material: ShaderMaterial
		if node is MeshInstance:
			material = node.get_surface_material(0)
		else:
			material = node.material

		return {
			callback = funcref(material, 'set_shader_param'),
			param = p[1]
		}

	if node_property_name:
		var is_rect2 = (node_property_name in node and node[node_property_name] is Rect2)
		if is_rect2 and p.size() > 1:
			var k: String = p[1]

			if k == "x" or k == "y":
				key = "position"
				subkey = k
			else:
				key = "size"
				subkey = "x" if k == "w" else "y"

		if subkey:
			return {
				property = node_property_name,
				key = key,
				subkey = subkey,
				is_rect2 = false
			}

		if key:
			return {
				property = node_property_name,
				key = key,
				is_rect2 = is_rect2
			}

		return {
			property = node_property_name,
			is_rect2 = is_rect2
		}

	if property.find('__') == 0:
		return {
			property = property
		}

	return {
		property = property
	}
