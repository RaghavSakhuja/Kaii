extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (String,FILE )var NextScene: String 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_button_up():
	get_tree().paused=false
	var level=Data.array.find(NextScene)
	if(level!=-1):
		Data.set_level(level)
	print(level)
	get_tree().change_scene(NextScene)
