extends Node2D

var score : int

@export var HockJock_model : Enemy
@export var PolarBear_model : Enemy
@export var Sharknado_model : Enemy
@export var enemy_spawner : Node2D
@export var game_over_path : String
@export var game_over_screen : Control

func _ready() -> void:
	pass
	#DISABLE GAME OVER HERE IF NECESSARY

"""
func _on_enemy_spawner_wave_spawned() -> void:
	for child in enemy_spawner.get_children():
		if child is Enemy:
			child.send_points.connect(on_points_received)

func on_points_received(points : int):
	print("received: ", points)
	score += points
	print("curr score is: ", score)
"""

func compute_final_score() -> int:
	return score

func _on_player_game_lost() -> void:
	var final_score = compute_final_score()
	get_tree().paused = true
	game_over_screen.visible = true
	game_over_screen.score_label.text = str(final_score)

func _on_enemy_spawner_send_points(points: int) -> void:
	print("received: ", points)
	score += points
	print("curr score is: ", score)
