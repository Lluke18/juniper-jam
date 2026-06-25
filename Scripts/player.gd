extends CharacterBody2D

class_name Player

@export var stats : CombatStats
@export var sprite : AnimatedSprite2D
@export var max_hp : int
var curr_hp : int 
@export var atk_dmg : int
@export var max_speed : int = 275
var acceleration : int = 25
var friction : int =  5

var XP : int = 0:
	set(value):
		XP = value
		%XP.value = value
		
var total_XP : int = 0
var level : int = 1:
	set(value):
		level = value
		%Level.text = "Lv " + str(value)
		if level > 1:
			%OptionsContainer.show_option()
	
@export var path2D : Path2D
@export var pathFollow : PathFollow2D
@export var wave_enemy_position : Marker2D


func _ready() -> void:
	curr_hp = max_hp

func _physics_process(delta: float) -> void:
	movement(delta)
	check_XP()

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
	
	
func gain_XP(amount):
	XP += amount
	total_XP += amount

func check_XP():
	if XP > %XP.max_value:
		XP -= %XP.max_value
		level += 1
		if level <= 20:
			%XP.max_value = 10 + (level - 1) * 5
			

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		gain_XP(1)
	
	
