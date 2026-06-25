extends CanvasLayer

@onready var SPIN_MINIGAME = preload("res://scenes/UI/SpinMinigame.tscn")
@onready var timer: Timer = $Timer


func _on_timer_timeout() -> void:
	var new_minigame = SPIN_MINIGAME.instantiate()
	add_child(new_minigame)
	new_minigame.minigame_over.connect(_on_minigame_over)
	
	timer.paused = true

func _on_minigame_over(scored_points: float):
	timer.paused = false
