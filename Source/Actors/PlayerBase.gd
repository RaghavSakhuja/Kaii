extends Entity

export (int) var limit:int=2
export (int) var currcount:int=2
export(PackedScene) var B_Bullet: PackedScene=preload("res://Source/Objects/Projectiles/body_bullet.tscn")

var facing=1;
var start_new_anim=true

func get_input_dir()->Vector2:
	var new_velocity:=Vector2()
	new_velocity.x=Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	new_velocity.y=Input.get_action_strength("move_down")-Input.get_action_strength("move_up")
	return new_velocity
	
func _physics_process(delta:float)->void:
	var dir:=Vector2.ZERO
	dir.x=get_input_dir().x
	if dir!=Vector2.ZERO:
		if(is_on_floor() or is_on_wall() or is_on_ceiling()):
			accelarate(dir)
			if(dir.x<0):
				sprite.scale.x=-1;
				facing=-1;
			else:
				sprite.scale.x=1;
				facing=1
			if start_new_anim:	
				start_new_anim=0
				animPlayer.play("run")
			
		#else:
			#animPlayer.play("idle")
	else:
		if start_new_anim:	
			start_new_anim=0
			animPlayer.play("idle")
		#print("idle")
		if(is_on_floor() or is_on_ceiling() or is_on_wall()):
			apply_friction()
	
	if(Input.is_action_just_pressed("fire")):
		throw()
	move()

func accelarate(dir:Vector2):
	_velocity.x = _velocity.move_toward(speed * dir, ACC ).x

func move():
	apply_grav()
	if(Input.is_action_just_pressed("move_up") && (is_on_floor())):
		_velocity.y=-speed
#		if start_new_anim:	
#			start_new_anim=0
#			animPlayer.play("jump")		
		print("jumped1")
	
		
	
	_velocity = move_and_slide(_velocity,FLOOR_NORMAL)

func apply_friction():
	_velocity.x = _velocity.move_toward(Vector2.ZERO, friction).x



func throw():
	if (currcount>0):
		var bullet=B_Bullet.instance()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position=self.global_position
		var direction=get_input_dir();
		if(direction==Vector2.ZERO):
			direction.x=facing;
		_velocity+=direction*speed
		_velocity.x=clamp(_velocity.x,-600,600)
		print(direction)		
		bullet.rotation=(-1*direction).angle()
		print(currcount)
		animPlayer.play("drying_"+str(3-currcount))
		speed+=50
		friction-=10
		currcount-=1
		


func _on_AnimationPlayer_animation_finished(anim_name):
	start_new_anim=1;
