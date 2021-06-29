extends "res://Assets/Scripts/Minigame.gd"


# METHODS

func process_action(delta: float) -> void:
	time += delta
	if time >= total_time:
		time = 0
		complete_minigame()

func stop_action() -> void:
	.stop_action()
	time = 0


# SIGNAL HANDLERS

func _on_Hand_button_down() -> void:
	cursor_sprite.frame = 1
	HUD.hide_option()
	.option_selected()
