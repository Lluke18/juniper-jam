extends ProgressBar
class_name HealthBar

var max_hp: float

func _ready() -> void:
	max_value = max_hp
	value = max_hp
