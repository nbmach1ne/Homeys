extends Node2D


# EXPORTS

export(Global.Food) var dislike_food = Global.Food.OLIVE

# VARS

var emotion



# METHODS

func _ready() -> void:
	make_happy()



func make_neutral() -> void:
	emotion = Global.Emotion.NEUTRAL
	$Sprite.frame = 0
	
	if OS.is_debug_build(): print("[Bichete] Neutral")

func make_happy() -> void:
	emotion = Global.Emotion.HAPPY
	$Sprite.frame = 1
	
	if OS.is_debug_build(): print("[Bichete] Happy :)")
	
func make_hungry() -> void:
	emotion = Global.Emotion.HUNGRY
	$Sprite.frame = 2
	
	if OS.is_debug_build(): print("[Bichete] Hungy :(")
	
func make_bored() -> void:
	emotion = Global.Emotion.BORED
	$Sprite.frame = 2
	
	if OS.is_debug_build(): print("[Bichete] Bored :(")
