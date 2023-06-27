extends Entity

export (int) var limit:int=2
export (int) var currcount:int=2
export(PackedScene) var B_Bullet: PackedScene=preload("res://Source/Objects/Projectiles/body_bullet.tscn")

var facing=1;
var start_new_anim=true
var in_water:bool=false

func get_input_dir()->Vector2:
	var new_velocity:=Vector2()
	new_velocity.x=Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	new_velocity.y=Input.get_action_strength("move_down")-Input.get_action_strength("move_up")
	return new_velocity
	
func _physics_process(delta:float)->void:
	if(_velocity!=Vector2.ZERO):
		print(_velocity)
	if(in_water):
		rejuvinate()
	
	var dir:=Vector2.ZERO
	dir.x=get_input_dir().x
	if dir!=Vector2.ZERO:
		if(is_on_floor() or is_on_wall() or is_on_ceiling()):
			accelarate(dir)
	else:
		if(is_on_floor() or is_on_ceiling() or is_on_wall()):
			apply_friction()
	
	if(Input.is_action_just_pressed("fire")):
		throw()
	
	if (_velocity.x!=0 && is_on_floor()):	
		if(_velocity.x<0):
			sprite.scale.x=-1;
			facing=-1;
		else:
			sprite.scale.x=1;
			facing=1			
		if start_new_anim:	
			animPlayer.play("run")
	else:
		if start_new_anim:
			animPlayer.play("idle")
		
	
	move()

func accelarate(dir:Vector2):
	_velocity.x = _velocity.move_toward(speed * dir, ACC ).x

func move():
	apply_grav()
	if(Input.is_action_just_pressed("move_up") && (is_on_floor())):
		_velocity.y=-speed
		print("jumped1")
	_velocity = move_and_slide(_velocity,FLOOR_NORMAL)

func apply_friction():
	_velocity.x = _velocity.move_toward(Vector2.ZERO, friction).x



func throw():
	if (currcount>0):
		var bullet=B_Bullet.instance()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position=self.global_position
		bullet.global_position.y-=30
		var direction=get_input_dir();
		if(direction==Vector2.ZERO):
			direction.x=facing;
		_velocity+=direction*speed*0.9
		_velocity.x=clamp(_velocity.x,-650,650)
		bullet.rotation=(-1*direction).angle()
		if(!in_water):
			dry()
		
func dry():
	if(currcount<=2):
			animPlayer.play("drying_"+str(3-currcount))
			print(currcount," drying_"+str(3-currcount))
			start_new_anim=0;
			speed+=50
			friction-=10
			currcount-=1
			print(speed," ",friction," ",currcount)
		

func rejuvinate():
	if(currcount<2):
		animPlayer.play("rejuvination_"+str(2-currcount))
		start_new_anim=0
		print(currcount," rejuvination_"+str(2-currcount))
		speed-=(50)*(2-currcount)
		friction+=10*(2-currcount)
		currcount=limit
		print(speed," ",friction," ",currcount)

func enter_exit_water(flag:bool):
	in_water=flag
			
func die():
	get_tree().change_scene("res://Source/Levels/screens/DeathScreen.tscn")	
	

func _on_AnimationPlayer_animation_finished(anim_name):
	start_new_anim=1;
