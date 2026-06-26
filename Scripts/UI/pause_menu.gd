extends CanvasLayer

@onready var options_panel = %OptionsPanel
@onready var sfx_player = $SfxPlayer

func _ready() -> void:
	hide()
	if options_panel:
		options_panel.visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if options_panel and options_panel.visible:
			options_panel.visible = false
			return
		if get_tree().paused:
			resume()
		else:
			pause()

func resume() -> void:
	get_tree().paused = false
	hide()

func pause() -> void:
	show()
	get_tree().paused = true

func _on_resume_pressed() -> void:
	resume()

func _on_options_pressed() -> void:
	options_panel.visible = true

func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file( "res://scenes/UI/main_menu.tscn")
	hide()
