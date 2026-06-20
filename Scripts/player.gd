extends CharacterBody2D

@export var max_speed : int = 275
var acceleration : int = 25
var friction : int =  5


func _physics_process(delta: float) -> void:
	movement(delta)

func movement(delta: float):
	var input = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	
	if input:
		print("play the walk anim")
	else: 
		print("play the idle anim")
	
	var lerp_weight = delta * (acceleration if input else friction)
	velocity = lerp(velocity, input * max_speed, lerp_weight)
	move_and_slide()
