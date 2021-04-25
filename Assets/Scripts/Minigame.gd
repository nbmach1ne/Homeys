extends Node2D


# VARS

var state
var over_bichete
onready var HUD = $HUD
onready var cursor = $Cursor
onready var particles = $Cursor/Particles

# SIGNALS

signal complete_minigame



# METHODS

func _ready() -> void:
	get_node("../Bichete/Area2D").connect("mouse_entered", self, "_on_bichete_area_entered")
	get_node("../Bichete/Area2D").connect("mouse_exited", self, "_on_bichete_area_exited")
	
	state = Global.MinigameState.NOT_SELECTED
	over_bichete = false
	HUD.visible = false
	
func _process(delta: float) -> void:
	if state == Global.MinigameState.SELECTED or state == Global.MinigameState.ACTION:
		$Cursor.position = get_global_mouse_position()
		
		if over_bichete:
			process_input()
			if state == Global.MinigameState.ACTION:
				process_action(delta)

func start_minigame() -> void:
	state = Global.MinigameState.WAITING_SELECTION
	HUD.visible = true
	
func cancel_minigame() -> void:
	state = Global.MinigameState.WAITING_SELECTION
	HUD.visible = false
	
func start_action() -> void:
	state = Global.MinigameState.ACTION
	particles.visible = true
	print("START")
	
func stop_action() -> void:
	state = Global.MinigameState.SELECTED
	particles.visible = false
	print("STOP")
	
func process_action(delta: float) -> void:
	pass
	
func process_input() -> void:
	var mouse_pressed = Input.is_mouse_button_pressed(1)
	if state == Global.MinigameState.SELECTED and mouse_pressed:
		start_action()
	if state == Global.MinigameState.ACTION and not mouse_pressed:
		stop_action()
	
func show_cursor(show: bool) -> void:
	if state == Global.MinigameState.SELECTED:
		cursor.visible = show
	
func option_selected() -> void:
	state = Global.MinigameState.SELECTED
	HUD.visible = false
	cursor.visible = true



# SIGNAL HANDLERS

func _on_bichete_area_entered() -> void:
	over_bichete = true
	
func _on_bichete_area_exited() -> void:
	over_bichete = false
	
	if state == Global.MinigameState.ACTION:
		stop_action()
