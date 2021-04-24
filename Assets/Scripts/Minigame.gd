extends Node2D


# VARS

var state
onready var HUD = $HUD
onready var cursor = $Cursor

# SIGNALS

signal complete_minigame



# METHODS

func _ready() -> void:
	state = Global.MinigameState.NOT_SELECTED
	HUD.visible = false
	
func _process(delta: float) -> void:
	if state == Global.MinigameState.SELECTED:
		$Cursor.position = get_global_mouse_position()



func start_minigame() -> void:
	state = Global.MinigameState.WAITING_SELECTION
	HUD.visible = true
	
func cancel_minigame() -> void:
	state = Global.MinigameState.WAITING_SELECTION
	HUD.visible = false
	
func show_cursor(show: bool) -> void:
	if state == Global.MinigameState.SELECTED:
		cursor.visible = show
	
func option_selected() -> void:
	state = Global.MinigameState.SELECTED
	HUD.visible = false
