extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var scene_tree=get_tree()
onready var pause_overlay:ColorRect=get_node("pauseoverlay")

var paused:bool=false setget set_paused

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.paused=!paused
		scene_tree.set_input_as_handled()

func set_paused(value:bool)->void:
	paused=value
	scene_tree.paused=value
	pause_overlay.visible=value

 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
