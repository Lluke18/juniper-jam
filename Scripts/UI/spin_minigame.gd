extends Control

@onready var center: TextureRect = $Center
@onready var orientation_label: Label = $OrientationLabel
@onready var key_label: Label = $KeyLabel
@onready var required_score_bar: ProgressBar = $RequiredScoreBar
@onready var bonus_score_bar: ProgressBar = $BonusScoreBar

@export var total_required_rotation : float = 50.0
@export var duration := 5.0
@export var keys_list: Array[Key] = [KEY_E, KEY_Q]

var required_orientation: int = 1
var required_key: Key = KEY_E

var elapsed := 0.0
var total_rotation := 0.0
var previous_angle := 0.0

#rotation to scored_points conversion method not decided yet
signal minigame_over
signal minigame_won(scored_points: float)
signal minigame_lost

func _ready():
	generate_random()
	
	required_score_bar.max_value = total_required_rotation
	
	orientation_label.text = "clockwise" if required_orientation > 0 else "counterclockwise"
	center.flip_h = required_orientation < 0
	
	key_label.text = "Hold " + OS.get_keycode_string(required_key)
	
	previous_angle = (
		get_global_mouse_position() - center.global_position
	).angle()

func generate_random():
	required_key = keys_list.pick_random()
	required_orientation = [-1,1].pick_random()         #-1 = Counter-Clockwise, 1 = Clockwise

func _process(delta):
	elapsed += delta

	var angle = (
		get_global_mouse_position() - center.global_position
	).angle()

	var delta_angle = wrapf(
		angle - previous_angle,
		-PI,
		PI
	)

	#if orientation = -1, delta_angle needs to be negative
	#if orientation = 1, delta_angle needts to be positive
	if Input.is_key_pressed(required_key) and required_orientation * delta_angle > 0.0 and abs(delta_angle) > 0.05:
		total_rotation += abs(delta_angle)
		required_score_bar.value = total_rotation
		bonus_score_bar.value = total_rotation - total_required_rotation
		center.rotation += delta_angle

	previous_angle = angle

	if elapsed >= duration:
		if total_rotation >= total_required_rotation:
			spinner_won()
		else:
			spinner_failed()
		minigame_over.emit()
		queue_free()

func spinner_won():
	minigame_won.emit(total_rotation)

func spinner_failed():
	minigame_lost.emit()
