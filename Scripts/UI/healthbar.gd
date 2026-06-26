extends ProgressBar
class_name HealthBar


@export var enemy : Enemy


func _ready() -> void:
	max_value = enemy.stats.hp
	value = max_value



func update(curr_hp : int) -> void:
	value = curr_hp
