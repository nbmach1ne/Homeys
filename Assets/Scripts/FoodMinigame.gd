extends Node2D

export var food_time = 5

var aceituna = load("res://Assets/Sprites/Food/aceituna_spritesheet.png")
var quesito = load("res://Assets/Sprites/Food/cheese_spritesheet.png")
var setilla = load("res://Assets/Sprites/Food/mushroom_spritesheet.png")

var minigame_enabled = false
var food_selected = Global.Food.NONE
var cursor_on_screen = false
var cursor_down = false
var total_time = 0

signal food_minigame_started
signal food_minigame_finished(success, food)
signal food(interacting, food)

func _ready() -> void:
	get_node("../Bichete/Area2D").connect("input_event", self, "_on_input_event")

func _process(delta: float) -> void:
	if not minigame_enabled or food_selected == Global.Food.NONE: return
	
	if cursor_on_screen:
		$Cursor.position = get_global_mouse_position()
	
	if cursor_down:
		total_time += delta
		#print ("Food time: ", total_time)
		if total_time >= food_time:
			finish_minigame(true)

func start_minigame() -> void:
	minigame_enabled = true
	food_selected = Global.Food.NONE
	$FoodHUD.visible = true
	emit_signal("food_minigame_started")
	
func select_food(food: int) -> void:
	print("select food")
	food_selected = food
	total_time = 0
	set_food_texture(food)
	$Cursor.position = get_global_mouse_position()
	$Cursor.frame = 1
	$Cursor.visible = true
	$FoodHUD.visible = false
	
func set_food_texture(food: int) -> void:
	assert(food in Global.Food.values(), "the function argument is expected to be a Food value")
	if food == Global.Food.OLIVE:
		$Cursor.texture = aceituna
	elif food == Global.Food.CHEESE:
		$Cursor.texture = quesito
	elif food == Global.Food.MUSHROOM:
		$Cursor.texture = setilla
	
func finish_minigame(success: bool) -> void:
	$Cursor.visible = false
	$FoodHUD.visible = false
	minigame_enabled = false
	emit_signal("food_minigame_finished", success, food_selected)
	food_selected = Global.Food.NONE


# SIGNALS

func _on_PetButton_button_down() -> void:
	finish_minigame(false)
	
func _on_FoodButton_button_down() -> void:
	start_minigame()
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not minigame_enabled or food_selected == Global.Food.NONE: return
	
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == 1:
			cursor_down = mouse_event.pressed
			emit_signal("food", cursor_down, food_selected)


func _on_Food1_button_down() -> void:
	select_food(Global.Food.OLIVE)


func _on_Food2_button_down() -> void:
	select_food(Global.Food.CHEESE)


func _on_Food3_button_down() -> void:
	select_food(Global.Food.MUSHROOM)


func _on_ScreenArea_mouse_entered() -> void:
	if minigame_enabled and food_selected != -1:
		cursor_on_screen = true
		$Cursor.visible = true


func _on_ScreenArea_mouse_exited() -> void:
	if minigame_enabled and food_selected != -1:
		cursor_on_screen = false
		$Cursor.visible = false
