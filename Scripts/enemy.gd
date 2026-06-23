extends CharacterBody2D

const speed = 65

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
var direction

func _ready() -> void:
	nav_agent.target_position = player.global_position
	
func _physics_process(delta: float) -> void:
	if nav_agent.is_navigation_finished():
		return
	
	var next_pos = nav_agent.get_next_path_position()
	var nav_point_direction = to_local(next_pos).normalized()
	velocity = nav_point_direction * speed
	move_and_slide()
func _on_timer_timeout() -> void:
	if nav_agent.target_position != player.global_position:
		nav_agent.target_position = player.global_position
