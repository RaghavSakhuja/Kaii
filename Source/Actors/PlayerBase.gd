extends Entity

func _physics_process(delta:float)->void:
	var dir:=get_input_xdir()
	if dir!=Vector2.ZERO:
		if(is_on_floor() or is_on_wall() or is_on_ceiling()):
			accelarate(dir)
			if(dir.x<0):
				sprite.scale.x=-1;
			else:
				sprite.scale.x=1;
			animPlayer.play("run")
		else:
			animPlayer.play("idle")
		
		
	else:
		animPlayer.play("idle")
		print("idle")
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
		animPlayer.play("jump")		
		print("jumped1")
		
	_velocity = move_and_slide(_velocity,FLOOR_NORMAL)

func apply_friction():
	_velocity.x = _velocity.move_toward(Vector2.ZERO, friction).x
