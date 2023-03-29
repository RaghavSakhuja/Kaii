extends "res://Source/Actors/Actor.gd"

func _on_enemyDetector_area_entered(area):
	pass # Replace with function body.


func _on_enemyDetector_body_entered(body):
	print(body.get_name())
	

func _physics_process(delta:float)->void:
	var dir:=get_input_xdir()
	if dir!=Vector2.ZERO:
		accelarate(dir)
		
	else:
		if(is_on_floor() or is_on_ceiling() or is_on_wall()):
			apply_friction()
	move()

func get_input_xdir()->Vector2:
	var new_velocity:=Vector2()
	new_velocity.x=Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	return new_velocity
	
func accelarate(dir:Vector2):
	_velocity.x = _velocity.move_toward(speed * dir, ACC ).x

func move():
#	velocity.y+=clamp(Gravity*get_physics_process_delta_time(),-speed,speed)
	apply_grav()
	if(Input.is_action_just_pressed("move_up")):
		_velocity.y=-speed
	_velocity = move_and_slide(_velocity,FLOOR_NORMAL)

func apply_friction():
	_velocity.x = _velocity.move_toward(Vector2.ZERO, friction).x




