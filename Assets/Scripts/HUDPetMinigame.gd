extends "res://Assets/Scripts/HUDPanel.gd"


# VARS

onready var bottom_panel = $BottomPanel
onready var hand_button = $Hand

# METHODS

func transition_in(complete_callback: FuncRef) -> void:
	# Bottom Panel
	var source_pos = Vector2(bottom_panel.get_position().x, 440)
	var target_pos = Vector2(bottom_panel.get_position().x, 370)
	bottom_panel.set_position(source_pos)
	tween.interpolate_property(bottom_panel, "rect_position", source_pos, target_pos, 0.7, Tween.TRANS_BACK, Tween.EASE_OUT)
	# Hand Button
	source_pos = Vector2(hand_button.get_position().x, 440)
	target_pos = Vector2(hand_button.get_position().x, 340)
	hand_button.set_position(source_pos)
	tween.interpolate_property(hand_button, "rect_position", source_pos, target_pos, 0.7, Tween.TRANS_BACK, Tween.EASE_OUT, 0.1)
	
	show_option()
	.transition_in(complete_callback)
	
func transition_out(complete_callback: FuncRef) -> void:
	# Bottom Panel
	var source_pos = Vector2(bottom_panel.get_position().x, 370)
	var target_pos = Vector2(bottom_panel.get_position().x, 440)
	bottom_panel.set_position(source_pos)
	tween.interpolate_property(bottom_panel, "rect_position", source_pos, target_pos, 0.7, Tween.TRANS_BACK, Tween.EASE_IN)
	# Hand Button
	source_pos = Vector2(hand_button.get_position().x, 340)
	target_pos = Vector2(hand_button.get_position().x, 440)
	hand_button.set_position(source_pos)
	tween.interpolate_property(hand_button, "rect_position", source_pos, target_pos, 0.7, Tween.TRANS_BACK, Tween.EASE_IN, 0.1)
	
	.transition_out(complete_callback)
	
func hide_option() -> void:
	hand_button.visible = false
	
func show_option() -> void:
	hand_button.visible = true
