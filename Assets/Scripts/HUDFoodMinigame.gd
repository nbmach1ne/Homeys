extends "res://Assets/Scripts/HUDPanel.gd"


# VARS

onready var bottom_panel = $BottomPanel
onready var olive_button = $Olive
onready var cheese_button = $Cheese
onready var mushroom_button = $Mushroom

# METHODS

func transition_in(complete_callback: FuncRef) -> void:
	# Bottom Panel
	var source_pos = Vector2(bottom_panel.get_position().x, 440)
	var target_pos = Vector2(bottom_panel.get_position().x, 370)
	bottom_panel.set_position(source_pos)
	tween.interpolate_property(bottom_panel, "rect_position", source_pos, target_pos, 0.7, Tween.TRANS_BACK, Tween.EASE_OUT)
	# Olive Button
	source_pos = Vector2(olive_button.get_position().x, 440)
	target_pos = Vector2(olive_button.get_position().x, 300)
	olive_button.set_position(source_pos)
	olive_button.mouse_filter = MOUSE_FILTER_STOP
	tween.interpolate_property(olive_button, "rect_position", source_pos, target_pos, 0.7, Tween.TRANS_BACK, Tween.EASE_OUT, 0.1)
	# Cheese Button
	source_pos = Vector2(cheese_button.get_position().x, 440)
	target_pos = Vector2(cheese_button.get_position().x, 300)
	cheese_button.set_position(source_pos)
	cheese_button.mouse_filter = MOUSE_FILTER_STOP
	tween.interpolate_property(cheese_button, "rect_position", source_pos, target_pos, 0.7, Tween.TRANS_BACK, Tween.EASE_OUT, 0.2)
	# Mushroom Button
	source_pos = Vector2(mushroom_button.get_position().x, 440)
	target_pos = Vector2(mushroom_button.get_position().x, 300)
	mushroom_button.set_position(source_pos)
	mushroom_button.mouse_filter = MOUSE_FILTER_STOP
	tween.interpolate_property(mushroom_button, "rect_position", source_pos, target_pos, 0.7, Tween.TRANS_BACK, Tween.EASE_OUT, 0.3)
	
	show_options()
	.transition_in(complete_callback)
	
func transition_out(complete_callback: FuncRef) -> void:
	# Bottom Panel
	var source_pos = Vector2(bottom_panel.get_position().x, 370)
	var target_pos = Vector2(bottom_panel.get_position().x, 440)
	bottom_panel.set_position(source_pos)
	tween.interpolate_property(bottom_panel, "rect_position", source_pos, target_pos, 0.7, Tween.TRANS_BACK, Tween.EASE_IN)
	# Olive Button
	source_pos = Vector2(olive_button.get_position().x, 300)
	target_pos = Vector2(olive_button.get_position().x, 440)
	olive_button.set_position(source_pos)
	olive_button.mouse_filter = MOUSE_FILTER_IGNORE
	tween.interpolate_property(olive_button, "rect_position", source_pos, target_pos, 0.7, Tween.TRANS_BACK, Tween.EASE_IN, 0.1)
	# Cheese Button
	source_pos = Vector2(cheese_button.get_position().x, 300)
	target_pos = Vector2(cheese_button.get_position().x, 440)
	cheese_button.set_position(source_pos)
	cheese_button.mouse_filter = MOUSE_FILTER_IGNORE
	tween.interpolate_property(cheese_button, "rect_position", source_pos, target_pos, 0.7, Tween.TRANS_BACK, Tween.EASE_IN, 0.2)
	# Mushroom Button
	source_pos = Vector2(mushroom_button.get_position().x, 300)
	target_pos = Vector2(mushroom_button.get_position().x, 440)
	mushroom_button.set_position(source_pos)
	mushroom_button.mouse_filter = MOUSE_FILTER_IGNORE
	tween.interpolate_property(mushroom_button, "rect_position", source_pos, target_pos, 0.7, Tween.TRANS_BACK, Tween.EASE_IN, 0.3)
	
	.transition_out(complete_callback)

func hide_option(food: int) -> void:
	match food:
		Global.Food.OLIVE:
			olive_button.visible = false
		Global.Food.CHEESE:
			cheese_button.visible = false
		Global.Food.MUSHROOM:
			mushroom_button.visible = false
			
func show_options() -> void:
	olive_button.visible = true
	cheese_button.visible = true
	mushroom_button.visible = true
