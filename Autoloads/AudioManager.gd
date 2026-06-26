extends Node

var _master_bus : int
var _music_bus : int
var _sfx_bus : int

var master_volume : float = 1.0
var music_volume : float = 1.0
var sfx_volume : float = 1.0
var music_player: AudioStreamPlayer
var music_player_menu: AudioStreamPlayer

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music"
	music_player.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(music_player)
	
	music_player_menu = AudioStreamPlayer.new()
	music_player_menu.bus = "Music"
	music_player_menu.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(music_player_menu)
	process_mode = Node.PROCESS_MODE_ALWAYS
	music_player.process_mode = Node.PROCESS_MODE_ALWAYS
	_master_bus = AudioServer.get_bus_index("Master")
	_music_bus  = AudioServer.get_bus_index("Music")
	_sfx_bus    = AudioServer.get_bus_index("Sfx")

func set_master_volume(value: float) -> void:
	master_volume = value
	AudioServer.set_bus_volume_db(_master_bus, linear_to_db(value))

func set_music_volume(value: float) -> void:
	music_volume = value
	AudioServer.set_bus_volume_db(_music_bus, linear_to_db(value))

func set_sfx_volume(value: float) -> void:
	sfx_volume = value
	AudioServer.set_bus_volume_db(_sfx_bus, linear_to_db(value))

func get_master_volume() -> float:
	return master_volume

func get_music_volume() -> float:
	return music_volume

func get_sfx_volume() -> float:
	return sfx_volume
	
func play_music(stream: AudioStream) -> void:
	music_player.stream = stream
	music_player.play()
	
	
func stop_music() -> void:
	music_player.stop()
	
