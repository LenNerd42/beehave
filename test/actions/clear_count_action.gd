class_name ClearCountAction extends BeehaveAction

@export var key = "custom_value"

func _tick(context: BeehaveContext) -> BeehaveTickStatus:
	if context.get_blackboard().has_value(key):
		context.get_blackboard().erase_value(key)
		return SUCCESS
	else:
		return FAILURE
