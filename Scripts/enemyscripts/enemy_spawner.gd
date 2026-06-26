extends Node2D

@export var player : Player
@export var scenes : Array[PackedScene]
#@export var enemies : Array[Enemy]
@export var cost_arr : Dictionary[PackedScene, Enemy]
@export var wave_timer : Timer
@export var waves : Array[WaveInfo]

var enemy_counter : int  
var curr_wave : int = 0
var curr_wave_val : int
@export var spawn_interval : float = 5.0

signal send_points(points : int)

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	curr_wave += 1
	generate_wave()

func generate_wave():
	print("SPAWNED A WAVE")
	curr_wave_val = waves[0].wave_value * curr_wave
	spawn_wave(curr_wave_val)
	curr_wave += 1
	waves[0].wave_duration *= 1.2
	
	wave_timer.wait_time = waves[0].wave_duration
	wave_timer.start()
	print("DURATION UNTIL NEXT WAVE: ", wave_timer.wait_time)

func spawn_wave(val : int):
	var generated_enemies : Array[PackedScene] = []
	
	while(val > 0):
		var available_enemies : Array[PackedScene] = []
		for enemy_scene in cost_arr:
			if cost_arr[enemy_scene].stats.cost <= val:
				available_enemies.append(enemy_scene)
		if available_enemies.is_empty():
			break
		var rand_id : int = randi_range(0, available_enemies.size() -1)
		var rand_enemy_scene = available_enemies[rand_id]
		var rand_cost : int = cost_arr[rand_enemy_scene].stats.cost
		
		generated_enemies.append(rand_enemy_scene)
		val -= rand_cost
	print("nr of enemies in the wave are: ", generated_enemies.size())

	for enemy in generated_enemies:
		wave_spawn(enemy)
	#wave_spawned.emit()
	#await get_tree().create_timer(waves[0].wave_duration).timeout

func wave_spawn(enemy_scene : PackedScene):
	print("spawned an enemy")
	player.pathFollow.progress_ratio = rng.randf_range(0.0,1.0)
	var new_enemy = enemy_scene.instantiate()
	new_enemy.name = "Enemy_%d" % enemy_counter
	enemy_counter += 1
	
	call_deferred("add_child", new_enemy)
	#add_child(new_enemy)
	new_enemy.send_points.connect(_on_enemy_send_points)
	
	new_enemy.global_position = player.wave_enemy_position.global_position

func _on_wave_timer_timeout() -> void:
	print("SPAWNIN'!")
	generate_wave()

#When enemy dies
func _on_enemy_send_points(points: int):
	send_points.emit(points)
	check_if_wave_cleared()

func check_if_wave_cleared():
	# NU stiu de ce trebuie sa fie 6, in ierarhie imi arata pe remote 5
	# Lasam asa totusi ca merge
	if get_child_count() < 6:
		print("Wave Complete!")
		wave_timer.stop()
		wave_timer.timeout.emit()
