extends TextureButton

@export var upgrade : Upgrade:
	set(value):
		upgrade = value
		$NameLabel.text = upgrade.title
		$DescLabel.text = upgrade.description

func _pressed():
	if upgrade:
		var player = get_tree().get_first_node_in_group("player")
		match upgrade.stat:
			"max_hp":
				player.stats.max_hp += upgrade.value
				player.stats.current_hp += upgrade.value
			"damage":
				player.stats.damage += upgrade.value
			"shuriken_speed":
				player.stats.shuriken_speed += upgrade.value
			"current_number_of_shurikens":
				var new_val = player.stats.current_number_of_shurikens + int(upgrade.value)
				player.stats.current_number_of_shurikens = min(new_val, 8)
			"max_speed":
				player.max_speed += int(upgrade.value)
		print("Dupa upgrade - max_speed: ", player.max_speed, " damage: ", player.stats.damage)
		get_parent().close_option()
