extends "res://Assets/Scripts/Minigame.gd"


# EXPORTS

export var total_steps = 3

# VARS

var olive_texture = load("res://Assets/Sprites/Food/aceituna_spritesheet.png")
var cheese_texture = load("res://Assets/Sprites/Food/cheese_spritesheet.png")
var mushroom_texture = load("res://Assets/Sprites/Food/mushroom_spritesheet.png")

var step
var option

# SIGNAL

signal food_selected(selection)


# METHODS

func _ready() -> void:
	step = 1


func set_cursor_texture(food: int) -> void:
		assert(food in Global.Food.values(), "the function argument is expected to be a Food value")
		
		match food:
			Global.Food.OLIVE:
				cursor.texture = olive_texture
			Global.Food.CHEESE:
				cursor.texture = cheese_texture
			Global.Food.MUSHROOM:
				cursor.texture = mushroom_texture
				
		option = food
				
func start_minigame(complete_callback: FuncRef) -> void:
	.start_minigame(complete_callback)
	step = 1

func process_action(delta: float) -> void:
	time += delta
	if time >= total_time:
		step += 1
		time = 0
		if step > total_steps:
			complete_minigame()
		else:
			cursor.frame = step



# SIGNAL HANDLERS

func _on_Olive_button_down() -> void:
	cursor.frame = 1
	set_cursor_texture(Global.Food.OLIVE)
	HUD.hide_option(Global.Food.OLIVE)
	.option_selected()
	
	emit_signal("food_selected", Global.Food.OLIVE)

func _on_Cheese_button_down() -> void:
	cursor.frame = 1
	set_cursor_texture(Global.Food.CHEESE)
	HUD.hide_option(Global.Food.CHEESE)
	.option_selected()
	
	emit_signal("food_selected", Global.Food.CHEESE)

func _on_Mushroom_button_down() -> void:
	cursor.frame = 1
	set_cursor_texture(Global.Food.MUSHROOM)
	HUD.hide_option(Global.Food.MUSHROOM)
	.option_selected()
	
	emit_signal("food_selected", Global.Food.MUSHROOM)
