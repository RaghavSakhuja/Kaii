extends "res://Overlap/Hitbox.gd"

export (int) var speed:int=800

func _physics_process(delta):
	var direction: Vector2=Vector2.RIGHT.rotated(rotation)
	global_position+=speed*direction*delta

func destroy():
	queue_free()
	
func _on_body_bullet_area_entered(area):
	print(area," area")
	destroy()

func _on_body_bullet_body_entered(body):
	print(body," body")
	destroy()

