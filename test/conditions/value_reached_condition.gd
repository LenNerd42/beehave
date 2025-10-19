class_name ValueReachedCondition extends BeehaveCondition

@export var limit = 2
@export var key = "custom_value"

func _tick(context: BeehaveContext) -> BeehaveTickStatus:
	if context.get_blackboard().get_value(key, 0) >= limit:
		return SUCCESS
	else:
		return FAILURE
