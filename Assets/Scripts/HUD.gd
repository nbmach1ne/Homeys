extends Control

# VARS

onready var option_buttons_sound = $OptionButtonsSound
onready var quit_button_sound = $QuitButtonSound


# SIGNAL HANDLERS

func _on_PowerButton_button_down() -> void:
	quit_button_sound.play()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().quit()

func _on_VolumeDown_button_down() -> void:
	pass # Replace with function body.

func _on_VolumeUp_button_down() -> void:
	pass # Replace with function body.


func _on_PetButton_button_down() -> void:
	#option_buttons_sound.play()
	pass


func _on_FoodButton_button_down() -> void:
	#option_buttons_sound.play()
	pass
