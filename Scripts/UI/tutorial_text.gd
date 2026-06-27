extends Label

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("right") or event.is_action_pressed("left") or event.is_action_pressed("up") or event.is_action_pressed("down"):
		queue_free()
