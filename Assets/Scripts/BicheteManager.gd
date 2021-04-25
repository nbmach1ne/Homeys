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
		bichete.make_neutral()
		time_since_last_event = 0
	
func check_sad() -> void:
	if hungry_stat.is_over_sad_limit():
		bichete.make_hungry()
		time_since_last_event = 0
	elif bored_stat.is_over_sad_limit():
		bichete.make_bored()
		time_since_last_event = 0
		
func check_bichete_after_minigame() -> void:
	if hungry_stat.is_ok() and bored_stat.is_ok():
		bichete.make_happy()
	elif hungry_stat.is_over_neutral_limit() or bored_stat.is_over_neutral_limit():
		bichete.make_neutral()
	elif hungry_stat.is_over_sad_limit():
		bichete.make_hungry()
	elif bored_stat.is_over_sad_limit():
		bichete.make_bored()

		
func show_minigame_cursor(show: bool) -> void:
	match state:
		Global.GameState.FOOD_MINIGAME:
			food_minigame.show_cursor(show)
		Global.GameState.PET_MINIGAME:
			pet_minigame.show_cursor(show)



# SIGNAL HANDLERS

func _on_HungryStat_sad_limit_reached() -> void:
	if time_since_last_event >= min_time_between_events:
		check_events()

func _on_BoredStat_sad_limit_reached() -> void:
	if time_since_last_event >= min_time_between_events:
		check_events()

func _on_PetButton_button_down() -> void:
	if state == Global.GameState.FOOD_MINIGAME:
		food_minigame.cancel_minigame()
		
	state = Global.GameState.PET_MINIGAME
	pet_minigame.start_minigame()

func _on_FoodButton_button_down() -> void:
	if state == Global.GameState.PET_MINIGAME:
		pet_minigame.cancel_minigame()
		
	state = Global.GameState.FOOD_MINIGAME
	food_minigame.start_minigame()

func _on_ScreenArea_mouse_entered() -> void:
	show_minigame_cursor(true)

func _on_ScreenArea_mouse_exited() -> void:
	show_minigame_cursor(false)


func _on_FoodMinigame_complete_minigame() -> void:
	state = Global.GameState.IDLE
	hungry_stat.decrease_value(food_minigame_points)
	time_since_last_event = 0
	check_bichete_after_minigame()
	# make the bichete react

func _on_PetMinigame_complete_minigame() -> void:
	state = Global.GameState.IDLE
	bored_stat.decrease_value(pet_minigame_points)
	time_since_last_event = 0
	check_bichete_after_minigame()
	# make the bichete react
