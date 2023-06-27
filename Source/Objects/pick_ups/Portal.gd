tool
extends Area2D

export var NextScene: PackedScene 

onready var anim_player: AnimationPlayer= $AnimationPlayer

var inside:bool =false
var object

func _on_body_entered(body):
	print(body," ",body.name, body.is_in_group("player"))
	if(body.is_in_group("player")):
		inside=true
		object=body

func _get_configuration_warning() -> String:
		return "empty next screen" if not NextScene else "";

func teleport():
	anim_player.play("fade_end")
	yield(anim_player,"animation_finished")
	get_tree().change_scene_to(NextScene)

func _process(delta):
	if(inside):
		if(object._velocity==Vector2.ZERO):
			teleport()		

func _on_Portal_body_exited(body):
	if(body.is_in_group("player")):
		inside=false
