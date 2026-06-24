extends CharacterBody2D

class_name Player

@export var sprite : AnimatedSprite2D
@export var max_hp : int
var curr_hp : int 
@export var atk_dmg : int
@export var max_speed : int = 275
var acceleration : int = 25
var friction : int =  5


@export var path2D : Path2D
@export var pathFollow : PathFollow2D
@export var wave_enemy_position : Marker2D


func _ready() -> void:
	curr_hp = max_hp

func _physics_process(delta: float) -> void:
	movement(delta)
	

func movement(delta: float):
	var input = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	 
	if input:
		pass
		#print("play the walk anim")
	else: 
		sprite.play("idle")
		#print("play the idle anim")
	
	var lerp_weight = delta * (acceleration if input else friction)
	velocity = lerp(velocity, input * max_speed, lerp_weight)
	move_and_slide()


func _on_hitbox_area_body_entered(body: Enemy) -> void:
	if body.is_in_group("enemies"):
		print("Wiz got hit!")
		take_damage(body.stats.atk_dmg)


func take_damage(dmg_val : int):
	curr_hp -= dmg_val
	print("wiz got damaged with: ", dmg_val)
	if curr_hp <= 0:
		print("ya died!")
		get_tree().quit()
	
	
	
	
