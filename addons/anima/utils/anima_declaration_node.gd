extends AnimaDeclarationBase
class_name AnimaDeclarationNode

func _node(node) -> AnimaDeclarationNode:
	self._data.node = node

	return self

func anima_from(from) -> AnimaDeclarationNode:
	super.anima_from(from)

	return self

func anima_to(to) -> AnimaDeclarationNode:
	super.anima_to(to)

	return self

func anima_duration(duration: float) -> AnimaDeclarationNode:
	super.anima_duration(duration)

	return self

func anima_delay(delay: float) -> AnimaDeclarationNode:
	super.anima_delay(delay)

	return self

func anima_animation(animation) -> AnimaDeclarationNode:
	super.anima_animation(animation)

	return self

func anima_property(property_name) -> AnimaDeclarationNode:
	super.anima_property(property_name)

	return self

func anima_relative(relative: bool) -> AnimaDeclarationNode:
	super.anima_relative(relative)

	return self

func anima_easing(easing) -> AnimaDeclarationNode:
	super.anima_easing(easing)

	return self

func anima_pivot(pivot: int) -> AnimaDeclarationNode:
	super.anima_pivot(pivot)

	return self

func anima_visibility_strategy(strategy: int) -> AnimaDeclarationNode:
	super.anima_visibility_strategy(strategy)

	return self

func anima_initial_value(initial_value) -> AnimaDeclarationNode:
	super.anima_initial_value(initial_value)

	return self

func anima_initial_values(initial_values: Dictionary) -> AnimaDeclarationNode:
	super.anima_initial_values(initial_values)

	return self

func anima_on_started(on_started: Callable, on_started_value, on_backwards_completed_value) -> AnimaDeclarationNode:
	super.anima_on_started(on_started, on_started_value, on_backwards_completed_value)

	return self

func anima_on_completed(on_completed: Callable) -> AnimaDeclarationNode:
	super.anima_on_completed(on_completed)

	return self
