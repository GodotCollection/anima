extends AnimaDeclarationBase
class_name AnimaDeclarationGrid

func _grid(grid: Node) -> AnimaDeclarationGrid:
	self._data.grid = grid

	return self

func anima_grid_size(size: Vector2) -> AnimaDeclarationGrid:
	self._data.grid_size = size

	return self

func anima_sequence_type(type: int) -> AnimaDeclarationGrid:
	self._data.animation_type = type

	return self

func anima_point(point: Vector2) -> AnimaDeclarationGrid:
	self._data.point = point

	return self

func anima_items_delay(delay: float) -> AnimaDeclarationGrid:
	self._data.items_delay = delay

	return self


func anima_from(from) -> AnimaDeclarationGrid:
	super.anima_from(from)

	return self

func anima_to(to) -> AnimaDeclarationGrid:
	super.anima_to(to)

	return self

func anima_duration(duration: float) -> AnimaDeclarationGrid:
	super.anima_duration(duration)

	return self

func anima_delay(delay: float) -> AnimaDeclarationGrid:
	super.anima_delay(delay)

	return self

func anima_animation(animation) -> AnimaDeclarationGrid:
	super.anima_animation(animation)

	return self

func anima_property(property_name) -> AnimaDeclarationGrid:
	super.anima_property(property_name)

	return self

func anima_relative(relative: bool) -> AnimaDeclarationGrid:
	super.anima_relative(relative)

	return self

func anima_easing(easing) -> AnimaDeclarationGrid:
	super.anima_easing(easing)

	return self

func anima_pivot(pivot: int) -> AnimaDeclarationGrid:
	super.anima_pivot(pivot)

	return self

func anima_visibility_strategy(strategy: int) -> AnimaDeclarationGrid:
	super.anima_visibility_strategy(strategy)

	return self

func anima_initial_value(initial_value) -> AnimaDeclarationGrid:
	super.anima_initial_value(initial_value)

	return self

func anima_initial_values(initial_values: Dictionary) -> AnimaDeclarationGrid:
	super.anima_initial_values(initial_values)

	return self

func anima_on_started(on_started: Callable, on_started_value, on_backwards_completed_value) -> AnimaDeclarationGrid:
	super.anima_on_started(on_started, on_started_value, on_backwards_completed_value)

	return self

func anima_on_completed(on_completed: Callable) -> AnimaDeclarationGrid:
	super.anima_on_completed(on_completed)

	return self
