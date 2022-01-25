extends AnimaDeclarationBase
class_name AnimaDeclarationGroup

func _group(group) -> AnimaDeclarationGroup:
	self._data.group = group

	return self

func anima_sequence_type(type: int) -> AnimaDeclarationGroup:
	self._data.animation_type = type

	return self

func anima_point(point: Vector2) -> AnimaDeclarationGroup:
	self._data.point = point

	return self

func anima_items_delay(delay: float) -> AnimaDeclarationGroup:
	self._data.items_delay = delay

	return self


func anima_from(from) -> AnimaDeclarationGroup:
	super.anima_from(from)

	return self

func anima_to(to) -> AnimaDeclarationGroup:
	super.anima_to(to)

	return self

func anima_duration(duration: float) -> AnimaDeclarationGroup:
	super.anima_duration(duration)

	return self

func anima_delay(delay: float) -> AnimaDeclarationGroup:
	super.anima_delay(delay)

	return self

func anima_animation(animation) -> AnimaDeclarationGroup:
	super.anima_animation(animation)

	return self

func anima_property(property_name) -> AnimaDeclarationGroup:
	super.anima_property(property_name)

	return self

func anima_relative(relative: bool) -> AnimaDeclarationGroup:
	super.anima_relative(relative)

	return self

func anima_easing(easing) -> AnimaDeclarationGroup:
	super.anima_easing(easing)

	return self

func anima_pivot(pivot: int) -> AnimaDeclarationGroup:
	super.anima_pivot(pivot)

	return self

func anima_visibility_strategy(strategy: int) -> AnimaDeclarationGroup:
	super.anima_visibility_strategy(strategy)

	return self

func anima_initial_value(initial_value) -> AnimaDeclarationGroup:
	super.anima_initial_value(initial_value)

	return self

func anima_initial_values(initial_values: Dictionary) -> AnimaDeclarationGroup:
	super.anima_initial_values(initial_values)

	return self

func anima_on_started(on_started: Callable, on_started_value, on_backwards_completed_value) -> AnimaDeclarationGroup:
	super.anima_on_started(on_started, on_started_value, on_backwards_completed_value)

	return self

func anima_on_completed(on_completed: Callable) -> AnimaDeclarationGroup:
	super.anima_on_completed(on_completed)

	return self
