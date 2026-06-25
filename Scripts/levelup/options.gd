extends HBoxContainer

var OptionSlot = preload("res://scenes/UI/options_slot.tscn")
@export var all_upgrades : Array[Upgrade] = []

func _ready():
	hide()

func close_option():
	for child in get_children():
		child.queue_free()
	hide()
	get_tree().paused = false

func show_option():
	var pool = all_upgrades.duplicate()
	pool.shuffle()
	var chosen = pool.slice(0, min(3, pool.size()))
	
	for upgrade in chosen:
		var slot = OptionSlot.instantiate()
		add_child(slot)
		slot.upgrade = upgrade
		slot.process_mode = Node.PROCESS_MODE_ALWAYS
		
	process_mode = Node.PROCESS_MODE_ALWAYS
	show()
	get_tree().paused = true
