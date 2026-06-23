extends Enemy

class_name HockJock
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

#initializing variables
func _ready() -> void:
	
	stats.curr_speed = stats.max_speed


func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * stats.curr_speed
	move_and_slide()
