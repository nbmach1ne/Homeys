extends Node2D


# EXPORTS

export(Global.Food) var dislike_food = Global.Food.OLIVE

# VARS

var emotion

onready var sprite = $Sprite
onready var bubble = $Bubble


# METHODS

func _ready() -> void:
	emotion = Global.Emotion.HAPPY
	sprite.frame = 1



func make_neutral() -> void:
	emotion = Global.Emotion.NEUTRAL
	sprite.frame = 0
	bubble.hide_bubble()
	
	if OS.is_debug_build(): print("[Bichete] Neutral")

func make_happy() -> void:
	emotion = Global.Emotion.HAPPY
	sprite.frame = 1
	bubble.hide_bubble()
	
	if OS.is_debug_build(): print("[Bichete] Happy :)")
	
func make_hungry() -> void:
	emotion = Global.Emotion.HUNGRY
	sprite.frame = 2
	bubble.show_bubble(emotion)
	
	if OS.is_debug_build(): print("[Bichete] Hungy :(")
	
func make_bored() -> void:
	emotion = Global.Emotion.BORED
	sprite.frame = 2
	bubble.show_bubble(emotion)
	
	if OS.is_debug_build(): print("[Bichete] Bored :(")
