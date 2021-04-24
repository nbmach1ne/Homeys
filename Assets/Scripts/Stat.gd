extends Node2D


# Constants

const MIN_VALUE = 1
const MAX_VALUE = 10

# EXPORTS

export(int, 1, 10) var neutral_limit = 4
export(int, 1, 10) var sad_limit = 7
export var time_between_increases = 30.0

# VARS

var value
var time

# SIGNALS

signal sad_limit_reached



# METHODS

func _ready() -> void:
	value = MIN_VALUE
	time = 0
	
	if OS.is_debug_build(): print("[STATS] %s: %s" % [name, value])

func _process(delta: float) -> void:
	if time >= time_between_increases:
		increase_value()
	else:
		time += delta



func is_over_neutral_limit() -> bool:
	return value < neutral_limit
	
func is_over_sad_limit() -> bool:
	return value < sad_limit

func increase_value() -> void:
	time = 0
	value = min(value + 1, MAX_VALUE)
	
	if value == sad_limit:
		emit_signal("sad_limit_reached")
		
	if OS.is_debug_build(): print("[STATS] %s: %s" % [name, value])
	
func decrease_value(amount: int) -> void:
	time = 0
	value = max(value - amount, MIN_VALUE)
	
	if OS.is_debug_build(): print("[STATS] %s: %s" % [name, value])
