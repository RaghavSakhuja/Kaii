tool
extends Area2D

export var NextScene: PackedScene 

onready var anim_player: AnimationPlayer= $AnimationPlayer

func _on_body_entered(body):
	teleport()

func _get_configuration_warning() -> String:
		return "empty next screen" if not NextScene else "";

func teleport():
	anim_player.play("fade_end")
	yield(anim_player,"animation_finished")
	get_tree().change_scene_to(NextScene)

