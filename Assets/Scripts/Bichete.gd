extends Node2D


# EXPORTS

export(Global.Food) var dislike_food = Global.Food.OLIVE

# VARS

var bubble_hand_atlas = load("res://Assets/Sprites/bubble_hand.png")
var bubble_food_atlas = load("res://Assets/Sprites/bubble_food.png")

var emotion

onready var sprite = $Sprite
onready var bubble = $Bubble


# METHODS

func _ready() -> void:
	make_happy()



func make_neutral() -> void:
	emotion = Global.Emotion.NEUTRAL
	sprite.frame = 0
	bubble.visible = false
	
	if OS.is_debug_build(): print("[Bichete] Neutral")

func make_happy() -> void:
	emotion = Global.Emotion.HAPPY
	sprite.frame = 1
	bubble.visible = false
	
	if OS.is_debug_build(): print("[Bichete] Happy :)")
	
func make_hungry() -> void:
	emotion = Global.Emotion.HUNGRY
	sprite.frame = 2
	set_bubble_texture(Global.GameState.FOOD_MINIGAME)
	bubble.visible = true
	
	if OS.is_debug_build(): print("[Bichete] Hungy :(")
	
func make_bored() -> void:
	emotion = Global.Emotion.BORED
	sprite.frame = 2
	set_bubble_texture(Global.GameState.PET_MINIGAME)
	bubble.visible = true
	
	if OS.is_debug_build(): print("[Bichete] Bored :(")

func set_bubble_texture(minigame: int) -> void:
	match minigame:
		Global.GameState.PET_MINIGAME:
			bubble.texture.set_atlas(bubble_hand_atlas)
		Global.GameState.FOOD_MINIGAME:
			bubble.texture.set_atlas(bubble_food_atlas)
