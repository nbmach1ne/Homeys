extends Control



# VARS

var callback

onready var tween = $Tween

# METHODS

func transition_in(complete_callback: FuncRef) -> void:
	callback = complete_callback
	tween.interpolate_callback(self, tween.get_runtime(), "transition_in_complete")
	tween.start()
	visible = true
	
func transition_out(complete_callback: FuncRef) -> void:
	callback = complete_callback
	tween.interpolate_callback(self, tween.get_runtime(), "transition_out_complete")
	tween.start()

func transition_in_complete() -> void:
	transition_complete()
	
func transition_out_complete() -> void:
	transition_complete()
	visible = false

func transition_complete() -> void:
	if callback != null and callback.is_valid():
		callback.call_func()
		callback = null
		
