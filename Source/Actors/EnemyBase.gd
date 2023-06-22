extends Entity

func _ready():
	_velocity.x=speed

func _physics_process(delta):
	apply_grav()
	_velocity.y=move_and_slide(_velocity,FLOOR_NORMAL).y
	if(is_on_wall()):
		_velocity.x*=-1

