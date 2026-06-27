extends CanvasLayer

@export var combat_stats: CombatStats
@export var time_scaler: TimeScaler

@export var start_scene_path : String
@onready var options_panel = $OptionsPanel
@onready var start: Button = $MenuScreen/ButtonManager/Start
@onready var quit: Button = $MenuScreen/ButtonManager/Quit
@export var credits_scene_path : String

func _ready() -> void:
	options_panel.visible = false
	options_panel.visibility_changed.connect(_on_options_visibility_changed)
	if not AudioManager.coming_from_credits:
		AudioManager.stop_music()
		var stream = preload("res://Audio/HaroldParanormalInstigatorTheme.wav")
		AudioManager.play_music(stream)
	AudioManager.coming_from_credits = false

func _on_options_visibility_changed() -> void:
	var is_visible = options_panel.visible
	start.disabled = is_visible
	quit.disabled = is_visible

func _on_start_pressed() -> void:
	reset_progress()
	AudioManager.stop_music()
	var game_stream = preload("res://Audio/CriticalTheme.wav")
	AudioManager.play_music(game_stream)
	get_tree().change_scene_to_file(start_scene_path)

func _on_options_pressed() -> void:
	options_panel.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file(credits_scene_path)
	
func reset_progress():
	time_scaler.time_scale = 1.0
	
	combat_stats.current_hp = 100

	combat_stats.current_number_of_shurikens = 4
	combat_stats.fire_rate = 0.5
	combat_stats.current_speed = 275
	combat_stats.crit_chance = 5
	combat_stats.range = 300

	combat_stats.max_hp = 100
	combat_stats.damage = 5
	combat_stats.shuriken_speed = 200
