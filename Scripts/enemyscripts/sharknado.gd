extends Enemy

class_name SharkNado
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
#initializing variables
func _ready() -> void:
	super()
	health_bar.max_hp = stats.hp
	stats.curr_speed = stats.max_speed

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * stats.curr_speed * time_scaler.time_scale
	update_animation()
	move_and_slide()

func update_animation() -> void:
	if not player:
		return

	if player.global_position.x < global_position.x:
		if animated_sprite.animation != "walk_left":
			animated_sprite.play("walk_left")
	else:
		if animated_sprite.animation != "walk_right":
			animated_sprite.play("walk_right")

func _on_hitbox_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("shuriken"):
		take_damage(player_combat_stats.damage)
