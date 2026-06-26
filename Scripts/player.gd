extends CharacterBody2D
class_name Player

@onready var minigame_timer: Timer = $UI/MinigameTimer
@onready var shuriken_spawner: ShurikenSpawner = $ShurikenSpawner
@onready var puke_timer: Timer = $PukeTimer
@onready var puke_bar: PukeBar = $UI/PukeBar
var is_puking: bool = false

@export var time_scaler: TimeScaler
var in_minigame : bool = false
@export var stats : CombatStats
@export var sprite : AnimatedSprite2D

#@export var max_hp : int
#var curr_hp : int 
#@export var atk_dmg : int

var acceleration : int = 25
var friction : int =  5

@export var path2D : Path2D
@export var pathFollow : PathFollow2D
@export var wave_enemy_position : Marker2D

func _ready() -> void:
	time_scaler.time_scale = 1.0
	stats.current_hp = stats.max_hp
	puke_bar.puke_bar_filled.connect(_on_puke_bar_filled)
	#puke_bar.game_over.connect(_on_game_over)

func _physics_process(delta: float) -> void:
	if is_puking:
		sprite.play("puke")
	else:
		movement(delta)

func movement(delta: float):
	if in_minigame:
		return
	var input = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	
	if input.length() > 0:
		if abs(input.x) > abs(input.y):
			if input.x > 0:
				sprite.play("walk_right")
			else:
				sprite.play("walk_left")
		else:
			if input.y > 0:
				sprite.play("walk_down")
			else:
				sprite.play("walk_up")
	else:
		sprite.play("idle")
	
	var lerp_weight = delta * (acceleration if input else friction)
	velocity = lerp(velocity, input * stats.max_speed, lerp_weight) * time_scaler.time_scale
	move_and_slide()

func _on_hitbox_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		var enemy_body := body as Enemy
		print("Wiz got hit!")
		take_damage(enemy_body.stats.atk_dmg)

func take_damage(dmg_val : int):
	stats.current_hp -= dmg_val
	print("wiz got damaged with: ", dmg_val)
	if stats.current_hp <= 0:
		print("ya died!")
		get_tree().quit()
		
func _on_puke_bar_filled():
	is_puking = true
	shuriken_spawner.is_puking = true
	puke_timer.start()
	minigame_timer.stop()
	
func _on_puke_timer_timeout() -> void:
	is_puking = false
	shuriken_spawner.is_puking = false
	minigame_timer.start()

"""
func _on_game_over():
	sprite.play("puke") 
	await sprite.animation_finished
	
	# nu exista scena asta
	#get_tree().change_scene_to_file("res://scenes/UI/GameOver.tscn")
"""
