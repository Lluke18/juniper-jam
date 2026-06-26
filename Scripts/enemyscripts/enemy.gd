extends CharacterBody2D

class_name Enemy

@export var time_scaler: TimeScaler
@export var stats : EnemyStats
@export var player_combat_stats: CombatStats

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var health_bar: HealthBar = $HealthBar
@export var anim_player : AnimationPlayer
var curr_hp: int

func _ready() -> void:
	curr_hp = stats.hp

func take_damage(dmg_val : int):
	curr_hp -= dmg_val
	if anim_player:
		anim_player.play("hit")
	health_bar.value = curr_hp
	if curr_hp <= 0:
		queue_free()
