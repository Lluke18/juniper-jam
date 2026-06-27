extends Resource
class_name CombatStats

@export var current_hp : int = 100

const MAX_NUMBER_OF_SHURIKENS : int = 8
const MAX_CRIT_CHANCE : int = 50
const MAX_SPEED : int = 400
const MAX_FIRE_RATE : int = 0.1
const MAX_RANGE : int = 600

#Capped
@export var current_number_of_shurikens : int = 4
@export var fire_rate : float = 0.5
@export var current_speed : int = 275
@export var crit_chance : int = 5
@export var range : int = 300

#Infinite
@export var max_hp : int = 100
@export var damage : float = 5
@export var shuriken_speed : float = 200
