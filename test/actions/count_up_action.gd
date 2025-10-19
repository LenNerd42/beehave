class_name CountUpAction extends BeehaveAction

@export var key = "custom_value"

var count = 0
var status = SUCCESS

func _tick(context) -> BeehaveTickStatus:
	count += 1
	context.get_blackboard().set_value(key, count)
	return status


func _interrupt(context: BeehaveContext) -> void:
	count = 0
	context.get_blackboard().set_value(key, count)
	status = FAILURE
