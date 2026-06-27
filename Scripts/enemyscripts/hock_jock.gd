extends Enemy

class_name HockJock
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

#initializing variables
func _ready() -> void:
	super()
	stats.curr_speed = stats.max_speed

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * stats.curr_speed * time_scaler.time_scale
	update_animation()

	#knockback:
	if knockback_timer > 0.0: # the knockback is active
		velocity = knockback
		knockback_timer -= delta
		if knockback_timer <= 0.0: # knockback gone
			knockback = Vector2.ZERO
	move_and_slide()

func update_animation() -> void:
	if not player:
		return

	if player.global_position.x < global_position.x:
		animated_sprite.play("walk_left")
	else:
		animated_sprite.play("walk_right")

#actually a hurtbox
func _on_hitbox_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("shuriken"):
		take_damage(player.stats.damage * area.get_parent().crit_multiplier)
		
		var knockback_direction = (global_position - player.global_position).normalized()
		apply_knockback(knockback_direction, knockback_force - stats.knockback_resistance, 0.12)
