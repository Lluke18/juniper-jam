extends CanvasLayer
@export var time_scaler: TimeScaler
@onready var SPIN_MINIGAME = preload("res://scenes/UI/SpinMinigame.tscn")
@onready var minigame_timer: Timer = $MinigameTimer
@onready var puke_bar: PukeBar = $PukeBar
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var player_camera: PlayerCamera = $"../PlayerCamera"
@onready var shuriken_spawner: ShurikenSpawner = $"../ShurikenSpawner"

var XP : int = 0:
	set(value):
		XP = value
		%XP.value = value
		
var total_XP : int = 0
var level : int = 1:
	set(value):
		level = value
		%Level.text = "Lv " + str(value)
		if level > 1:
			%OptionsContainer.show_option()
			
func gain_XP(amount):
	XP += amount
	total_XP += amount
	check_XP()
func check_XP():
	if XP > %XP.max_value:
		XP -= %XP.max_value
		level += 1
		if level <= 20:
			%XP.max_value += 100
#start minigame
func _on_timer_timeout() -> void:
	var player = get_parent()
	player.in_minigame = true
	
	var animations = ["high_foot", "lutz", "spin"]
	var chosen = animations[randi() % animations.size()]
	animated_sprite_2d.play(chosen)
	
	player_camera.zoom_in()
	time_scaler.time_scale = 0.1
	animated_sprite_2d.speed_scale = 1.0
	
	var new_minigame = SPIN_MINIGAME.instantiate()
	add_child(new_minigame)
	new_minigame.minigame_over.connect(_on_minigame_over)
	new_minigame.minigame_won.connect(_on_minigame_won)
	new_minigame.minigame_lost.connect(_on_minigame_lost)
	
	shuriken_spawner.is_in_minigame = true
	
	minigame_timer.stop()
	
func _on_minigame_over():
	shuriken_spawner.is_in_minigame = false
	var player = get_parent()
	player.in_minigame = false
	animated_sprite_2d.play("idle")
	player_camera.zoom_out()
	time_scaler.time_scale = 1
	animated_sprite_2d.speed_scale = 2.5
	minigame_timer.start()
	
func _on_minigame_won(scored_points: float):
	gain_XP(scored_points)
	print("minigame over with score " + str(scored_points))
	
func _on_minigame_lost():
	puke_bar.add_puke_point()
