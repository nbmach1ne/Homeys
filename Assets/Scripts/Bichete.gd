extends Node2D

export var max_time_no_interaction = 10
export(Global.Food) var dislike_food = Global.Food.OLIVE

enum Emotion { NEUTRAL, HAPPY, SAD }

var emotion = Emotion.NEUTRAL
var time_no_interaction = 0
var interacting = false

func _process(delta: float) -> void:
	if emotion == Emotion.SAD or interacting: return
	
	time_no_interaction += delta
	if time_no_interaction >= max_time_no_interaction:
		time_no_interaction = 0
		if emotion == Emotion.HAPPY: set_neutral()
		elif emotion == Emotion.NEUTRAL: set_sad(false)
		
func set_neutral() -> void:
	emotion = Emotion.NEUTRAL
	$Sprite.frame = 0
	print("NEUTRAL")

func set_happy(animation: bool) -> void:
	print("HAPPY")
	emotion = Emotion.HAPPY
	$Sprite.frame = 1
	time_no_interaction = 0
	
func set_sad(animation: bool) -> void:
	print("SAD")
	emotion = Emotion.SAD
	$Sprite.frame = 2


# SIGNALS

func _on_PetMinigame_pet(cursor_down: bool) -> void:
	interacting = cursor_down
	print("pet ", interacting)

func _on_PetMinigame_pet_minigame_started() -> void:
	print("pet minigame started")

func _on_PetMinigame_pet_minigame_finished(success: bool) -> void:
	if success:
		interacting = false
		set_happy(true)
		print("pet minigame complete")

func _on_FoodMinigame_food(cursor_down: bool, food: int) -> void:
	interacting = cursor_down
	print("food ", interacting)
	
	if interacting and food != dislike_food:
		print("hmmm yummy!")
	elif interacting and food == dislike_food:
		print("ugh")

func _on_FoodMinigame_food_minigame_started() -> void:
	print("food minigame started")

func _on_FoodMinigame_food_minigame_finished(success: bool, food: int) -> void:
	if success:
		interacting = false
		
		if food != dislike_food:
			set_happy(true)
		else:
			set_sad(true)
		print("food minigame complete")
