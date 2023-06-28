extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var level:int setget set_level
var array=["res://Source/Levels/tutorial.tscn","res://Source/Levels/LevelTemp.tscn"]

func set_level(val:int):
	level=val;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
