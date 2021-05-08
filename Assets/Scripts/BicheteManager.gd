extends Node2D


# EXPORTS

export var min_time_between_events = 30
export var food_minigame_points = 4
export(Global.Food) var food_minigame_dislike = Global.Food.NONE
export var pet_minigame_points = 4

# VARS

var state = Global.GameState.IDLE
var time_since_last_event

onready var bichete = $Bichete
onready var food_minigame = $FoodMinigame
onready var pet_minigame = $PetMinigame
onready var hungry_stat = $FoodMinigame/HungryStat
onready var bored_stat = $PetMinigame/BoredStat



# METHODS

func _ready() -> void:
	time_since_last_event = 0
	
func _process(delta: float) -> void:
	match state:
		Global.GameState.IDLE:
			idle(delta)
		_:
			minigame()



func idle(delta: float) -> void:
	if time_since_last_event >= min_time_between_events:
		check_events()
	else:
		time_since_last_event += delta
	
func minigame() -> void:
	pass
		
func check_events() -> void:
	match bichete.emotion:
		Global.Emotion.HAPPY:
			check_neutral()
		Global.Emotion.NEUTRAL:
			check_sad()
			
func check_neutral() -> void:
	if hungry_stat.is_over_neutral_limit() or bored_stat.is_over_neutral_limit():
		bichete.make_neutral(true)
		time_since_last_event = 0
	
func check_sad() -> void:
	if hungry_stat.is_over_sad_limit():
		bichete.make_hungry(true)
		time_since_last_event = 0
	elif bored_stat.is_over_sad_limit():
		bichete.make_bored(true)
		time_since_last_event = 0
		
func check_bichete_after_minigame(is_happy_after_minigame: bool) -> void:
	if hungry_stat.is_over_sad_limit():
		bichete.make_hungry(false)
	elif bored_stat.is_over_sad_limit():
		bichete.make_bored(false)	
	elif hungry_stat.is_over_neutral_limit() or bored_stat.is_over_neutral_limit():
		bichete.make_neutral(false)
	elif hungry_stat.is_ok() and bored_stat.is_ok():
		bichete.make_happy(false)
	
		
	bichete.react(is_happy_after_minigame)

		
func show_minigame_cursor(show: bool) -> void:
	match state:
		Global.GameState.FOOD_MINIGAME:
			food_minigame.show_cursor(show)
		Global.GameState.PET_MINIGAME:
			pet_minigame.show_cursor(show)

func start_minigame(minigame: int) -> void:
	match minigame:
		Global.GameState.FOOD_MINIGAME:
			state = Global.GameState.FOOD_MINIGAME
			food_minigame.start_minigame(null)
		Global.GameState.PET_MINIGAME:
			state = Global.GameState.PET_MINIGAME
			pet_minigame.start_minigame(null)
			
func start_food_minigame() -> void:
	start_minigame(Global.GameState.FOOD_MINIGAME)
	
func start_pet_minigame() -> void:
	start_minigame(Global.GameState.PET_MINIGAME)


# SIGNAL HANDLERS

func _on_HungryStat_sad_limit_reached() -> void:
	if time_since_last_event >= min_time_between_events:
		check_events()

func _on_BoredStat_sad_limit_reached() -> void:
	if time_since_last_event >= min_time_between_events:
		check_events()

func _on_PetButton_button_down() -> void:
	if state == Global.GameState.FOOD_MINIGAME:
		var callback = funcref(self, "start_pet_minigame")
		food_minigame.cancel_minigame(callback)
	else:
		start_pet_minigame()

func _on_FoodButton_button_down() -> void:
	if state == Global.GameState.PET_MINIGAME:
		var callback = funcref(self, "start_food_minigame")
		pet_minigame.cancel_minigame(callback)
	else:
		start_food_minigame()

func _on_FoodMinigame_complete_minigame(param: int) -> void:
	state = Global.GameState.IDLE
	if param == food_minigame_dislike:
		hungry_stat.increase_value(food_minigame_points)
	else:
		hungry_stat.decrease_value(food_minigame_points)
	time_since_last_event = 0
	check_bichete_after_minigame(param != food_minigame_dislike)

func _on_PetMinigame_complete_minigame(param: int) -> void:
	state = Global.GameState.IDLE
	bored_stat.decrease_value(pet_minigame_points)
	time_since_last_event = 0
	check_bichete_after_minigame(true)
