extends Node2D

export var pet_time = 5

var minigame_enabled = false
var cursor_on_screen = false
var cursor_down = false
var cursor_default_location
var total_time = 0

signal pet_minigame_started
signal pet_minigame_finished(success)
signal pet(interacting)


func _ready() -> void:
	cursor_default_location = $CursorDefaultLocation.position
	
	get_node("../Bichete/Area2D").connect("input_event", self, "_on_input_event")

func _process(delta: float) -> void:
	if not minigame_enabled: return
	
	if cursor_on_screen:
		$Cursor.position = get_global_mouse_position()
	
	if cursor_down:
		total_time += delta
		#print ("Pet time: ", total_time)
		if total_time >= pet_time:
			finish_minigame(true)

func start_minigame() -> void:
	$Cursor.position = cursor_default_location
	$Cursor.visible = true
	$Cursor/HandParticles.emitting = false
	minigame_enabled = true
	total_time = 0
	emit_signal("pet_minigame_started")
	
func finish_minigame(success: bool) -> void:
	$Cursor.visible = false
	minigame_enabled = false
	emit_signal("pet_minigame_finished", success)


# SIGNALS
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not minigame_enabled: return
	
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == 1:
			cursor_down = mouse_event.pressed
			$Cursor/HandParticles.emitting = cursor_down
			emit_signal("pet", cursor_down)
			
			if not cursor_down:
				total_time = 0

func _on_ScreenArea_mouse_entered() -> void:
	if minigame_enabled:
		cursor_on_screen = true
		$Cursor.visible = true


func _on_ScreenArea_mouse_exited() -> void:
	if minigame_enabled:
		cursor_on_screen = false
		$Cursor.visible = false
