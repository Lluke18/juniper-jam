extends Node2D
class_name Shuriken

@export var time_scaler: TimeScaler

var move_direction: Vector2
var start_position: Vector2
var move_speed: float = 5.0
var acceleration: float = 0.0
var radius: float = 2.0

var horizontal_angle: float = 0
var horizontal_angle_spacing: float = 0

var wiggle_speed: float = 0
var horizontal_wiggle_size: float = 0

@export var rotation_speed: float = 4.0

func _process(delta: float) -> void:
	rotate(rotation_speed * delta * time_scaler.time_scale)
	
	var horizontal_wiggle_modifier = horizontal_wiggle_size * sin(wiggle_speed * Time.get_ticks_msec())

	var shuriken_dir_x_position = start_position.x + cos(((horizontal_angle + horizontal_angle_spacing + horizontal_wiggle_modifier) * PI) / 180.0) * radius
	var shuriken_dir_y_position = start_position.y + sin(((horizontal_angle + horizontal_angle_spacing + horizontal_wiggle_modifier) * PI) / 180.0) * radius

	var new_position = Vector2(shuriken_dir_x_position, shuriken_dir_y_position)
	move_direction = (new_position - start_position).normalized()

	global_position += move_direction * move_speed * delta * time_scaler.time_scale
	if start_position.distance_to(global_position) >= radius:
		queue_free()

	move_speed += acceleration;

func _on_hitbox_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		queue_free()
