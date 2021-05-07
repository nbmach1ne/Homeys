extends Sprite


# DEFINITIONS

enum State { SHOW, IDLE, HIDE, HIDDEN }


# VARS

var bubble_hand_atlas = load("res://Assets/Sprites/bubble_hand.png")
var bubble_food_atlas = load("res://Assets/Sprites/bubble_food.png")

var state
var high_pos = Vector2(55, -75)
var low_pos = Vector2(55, -65)
var idle_source_pos
var idle_target_pos

onready var tween = $Tween


# METHODS

func _ready() -> void:
	state = State.HIDDEN
	visible = false
	
	
	
func show_bubble(emotion: int) -> void:
	match emotion:
		Global.Emotion.BORED:
			texture = bubble_hand_atlas
		Global.Emotion.HUNGRY:
			texture = bubble_food_atlas
			
	tween.stop_all()
	var source_color = Color(1, 1, 1, 0)
	var target_color = Color(1, 1, 1, 1)
	visible = true
	modulate = source_color
	frame = 0
	position = high_pos
	idle_source_pos = high_pos
	idle_target_pos = low_pos
	tween.interpolate_property(self, "modulate", source_color, target_color, 1, Tween.TRANS_EXPO, Tween.EASE_OUT);
	tween.interpolate_property(self, "frame", 0, 11, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_callback(self, tween.get_runtime(), "idle")
	tween.start()
	
func idle() -> void:
	tween.stop_all()
	visible = true
	tween.interpolate_property(self, "position", idle_source_pos, idle_target_pos, 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_callback(self, tween.get_runtime(), "idle")
	tween.start()
	swap_idle_values()
	
func swap_idle_values() -> void:
	var temp = idle_source_pos
	idle_source_pos = idle_target_pos
	idle_target_pos = temp

func hide_bubble() -> void:
	tween.stop_all()
	var source_color = Color(1, 1, 1, 1)
	var target_color = Color(1, 1, 1, 0)
	modulate = source_color
	tween.interpolate_property(self, "modulate", source_color, target_color, 0.5, Tween.TRANS_EXPO, Tween.EASE_OUT);
	tween.interpolate_callback(self, tween.get_runtime(), "hidden")
	tween.start()

func hidden() -> void:
	tween.stop_all()
	visible = false
