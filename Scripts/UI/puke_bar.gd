extends TextureRect
class_name PukeBar

#signal game_over

const PUKE_BAR_EMPTY = preload("res://Sprites/UI/PukeBar/puke_bar_empty.png")
const PUKE_BAR_1 = preload("res://Sprites/UI/PukeBar/puke_bar_1.png")
const PUKE_BAR_2 = preload("res://Sprites/UI/PukeBar/puke_bar_2.png")
const PUKE_BAR_3 = preload("res://Sprites/UI/PukeBar/puke_bar_3.png")

const sprites_list: Array[Texture2D] = [PUKE_BAR_EMPTY, PUKE_BAR_1, PUKE_BAR_2, PUKE_BAR_3]

const puke_counter_size: int = 3
var puke_counter: int = 0

signal puke_bar_filled

func _ready() -> void:
	texture = PUKE_BAR_EMPTY
	
func add_puke_point():
	puke_counter += 1
	texture = sprites_list[puke_counter]
	if puke_counter == puke_counter_size:
		puke_bar_filled.emit()
		empty_bar()
		#game_over.emit()
		
func empty_bar():
	while puke_counter > 0:
		await get_tree().create_timer(0.5).timeout
		puke_counter -= 1
		texture = sprites_list[puke_counter]
