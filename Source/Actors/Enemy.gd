extends "res://Source/Actors/Actor.gd"

func _ready():
	_velocity.x=speed
	
func _on_Stomping_body_entered(body):
	if(body.global_position.y>get_node("Stomping").global_position.y):
		 return
	get_node("Stomping/CollisionShape2D").disabled
	queue_free()

func _physics_process(delta):
	apply_grav()
	_velocity.y=move_and_slide(_velocity,FLOOR_NORMAL).y
	if(is_on_wall()):
		_velocity.x*=-1
