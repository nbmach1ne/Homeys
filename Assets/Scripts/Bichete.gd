extends Node2D


# EXPORTS

export(Global.Food) var dislike_food = Global.Food.OLIVE

# VARS

var emotion

onready var sprite = $Sprite
onready var bubble = $BubbleHolder/Bubble
onready var anim = $AnimationPlayer


# METHODS

func _ready() -> void:
	emotion = Global.Emotion.HAPPY
	set_sprite()



func make_neutral(set_sprite: bool) -> void:
	emotion = Global.Emotion.NEUTRAL
	if set_sprite: set_sprite()
	bubble.hide_bubble()
	
	if OS.is_debug_build(): print("[Bichete] Neutral")

func make_happy(set_sprite: bool) -> void:
	emotion = Global.Emotion.HAPPY
	if set_sprite: set_sprite()
	bubble.hide_bubble()
	
	if OS.is_debug_build(): print("[Bichete] Happy :)")
	
func make_hungry(set_sprite: bool) -> void:
	emotion = Global.Emotion.HUNGRY
	if set_sprite: set_sprite()
	bubble.show_bubble(emotion)
	
	if OS.is_debug_build(): print("[Bichete] Hungy :(")
	
func make_bored(set_sprite: bool) -> void:
	emotion = Global.Emotion.BORED
	if set_sprite: set_sprite()
	bubble.show_bubble(emotion)
	
	if OS.is_debug_build(): print("[Bichete] Bored :(")

func react(isHappyReaction: bool) -> void:
	if isHappyReaction:
		anim.play("Happy")
	else:
		anim.play("Sad")
		
func on_reaction_finished() -> void:
	stop_reaction()
	
func react_on_loop(isHappyReaction: bool) -> void:
	print("asdafsafass")
	if isHappyReaction:
		anim.play("Happy_loop")
	else:
		anim.play("Sad_loop")
		
func stop_reaction() -> void:
	if anim.is_playing():
		anim.stop(true)
	set_sprite()
	
	
func set_sprite() -> void:
	match emotion:
		Global.Emotion.NEUTRAL:
			sprite.frame = 0
		Global.Emotion.HAPPY:
			sprite.frame = 1
		Global.Emotion.BORED, Global.Emotion.HUNGRY:
			sprite.frame = 2
