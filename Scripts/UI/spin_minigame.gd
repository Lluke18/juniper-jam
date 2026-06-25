extends Control

@onready var center: Control = $Center
@onready var orientation_label: Label = $OrientationLabel
@onready var key_label: Label = $KeyLabel

@export var required_rotations := 5.0
@export var duration := 5.0
@export var keys_list: Array[Key] = [KEY_E, KEY_Q]

var required_orientation: int = 1
var required_key: Key = KEY_E

var elapsed := 0.0
var total_rotation := 0.0
var previous_angle := 0.0

#rotation to scored_points conversion method not decided yet
signal minigame_over(scored_points: float)

func _ready():
	generate_random()
	
	previous_angle = (
		get_global_mouse_position() - center.global_position
	).angle()

func generate_random():
	required_key = keys_list.pick_random()
	required_orientation = [-1,1].pick_random()         #-1 = Counter-Clockwise, 1 = Clockwise
	
	orientation_label.text = "clockwise" if required_orientation > 0 else "counterclockwise"
	key_label.text = "Hold " + OS.get_keycode_string(required_key)

func _process(delta):
	elapsed += delta

	var angle = (
		get_global_mouse_position() - center.global_position
	).angle()
	
	center.rotation = angle

	var delta_angle = wrapf(
		angle - previous_angle,
		-PI,
		PI
	)

	#if orientation = -1, delta_angle needs to be negative
	#if orientation = 1, delta_angle needts to be positive
	if Input.is_key_pressed(required_key) and required_orientation * delta_angle > 0.0:
		total_rotation += abs(delta_angle)

	previous_angle = angle

	var rotations = total_rotation / TAU

	if elapsed >= duration:
		if rotations >= required_rotations:
			spinner_complete()
		else:
			spinner_failed()
		queue_free()

func spinner_complete():
	print("Success!")

func spinner_failed():
	print("Failed!")
