extends "res://Assets/Scripts/Minigame.gd"


# VARS

var olive_texture = load("res://Assets/Sprites/Food/aceituna_spritesheet.png")
var cheese_texture = load("res://Assets/Sprites/Food/cheese_spritesheet.png")
var mushroom_texture = load("res://Assets/Sprites/Food/mushroom_spritesheet.png")



# METHODS

func set_cursor_texture(food: int) -> void:
		assert(food in Global.Food.values(), "the function argument is expected to be a Food value")
		
		match food:
			Global.Food.OLIVE:
				cursor.texture = olive_texture
			Global.Food.CHEESE:
				cursor.texture = cheese_texture
			Global.Food.MUSHROOM:
				cursor.texture = mushroom_texture



# SIGNAL HANDLERS

func _on_Olive_button_down() -> void:
	set_cursor_texture(Global.Food.OLIVE)
	.option_selected()

func _on_Cheese_button_down() -> void:
	set_cursor_texture(Global.Food.CHEESE)
	.option_selected()

func _on_Mushroom_button_down() -> void:
	set_cursor_texture(Global.Food.MUSHROOM)
	.option_selected()
