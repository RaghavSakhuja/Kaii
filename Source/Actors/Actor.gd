extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL=Vector2.UP
export var Gravity=1000.0
export var ACC=40
export var speed=500
export var friction=50

export var _velocity:Vector2=Vector2.ZERO

func apply_grav()->void:
		_velocity.y+=Gravity*get_physics_process_delta_time()
