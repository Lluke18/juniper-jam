extends Control

func _on_quit_pressed() -> void:
	AudioManager.coming_from_credits = true
	get_tree().paused = false
	get_tree().change_scene_to_file( "res://scenes/UI/main_menu.tscn")
