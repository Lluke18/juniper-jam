extends Node2D

const SHURIKEN = preload("res://scenes/combat/shuriken.tscn")

@export var combat_stats: CombatStats

@onready var timer: Timer = $Timer

@export var radius: float = 500.0
@export var horizontal_angle: float = 0
@export var horizontal_angle_step: float = 10

@export var horizontal_wiggle_size: float = 0
@export var wiggle_speed: float = 0

@export var acceleration: float = 0
	
func _on_timer_timeout() -> void:
	spawn_shurikens()
	
func spawn_shurikens():
	var start_point = position
	var horizontal_angle_spacing = 360.0 / combat_stats.current_number_of_shurikens;
	var horizontal_wiggle_modifier = horizontal_wiggle_size * sin(wiggle_speed * Time.get_ticks_msec())
	
	for i in range(0, combat_stats.current_number_of_shurikens):
		var shuriken_dir_x_position = start_point.x + cos(((horizontal_angle + i * horizontal_angle_spacing + horizontal_wiggle_modifier) * PI) / 180.0) * radius
		var shuriken_dir_y_position = start_point.y + sin(((horizontal_angle + i * horizontal_angle_spacing + horizontal_wiggle_modifier) * PI) / 180.0) * radius
		
		var new_position_vector = Vector2(shuriken_dir_x_position, shuriken_dir_y_position)
		var shuriken_direction = (new_position_vector - start_point).normalized()
		
		var new_shuriken = SHURIKEN.instantiate()
		new_shuriken.position = start_point
		new_shuriken.start_position = global_position
		new_shuriken.radius = radius
		
		new_shuriken.move_speed = combat_stats.shuriken_speed
		new_shuriken.acceleration = acceleration
		new_shuriken.move_direction = shuriken_direction

		new_shuriken.horizontal_angle = horizontal_angle
		new_shuriken.horizontal_angle_spacing = i * horizontal_angle_spacing
		new_shuriken.wiggle_speed = wiggle_speed
		new_shuriken.horizontal_wiggle_size = horizontal_wiggle_size
		
		add_child(new_shuriken)
	
		if horizontal_angle >= 360.0:
			horizontal_angle -= 360.0
			
	horizontal_angle += horizontal_angle_step
