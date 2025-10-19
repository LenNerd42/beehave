class_name HasNegativePosition extends BeehaveCondition


func _tick(context: BeehaveContext) -> BeehaveTickStatus:
	if context.actor.position.x < 0.0 and context.actor.position.y < 0.0:
		return SUCCESS
	else:
		return FAILURE
