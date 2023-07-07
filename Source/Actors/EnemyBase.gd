extends Entity

export var start_dir=1;

func _ready():
	set_physics_process(false)
	_velocity.x=speed*start_dir
	

func _physics_process(delta):
	apply_grav()
	_velocity.y=move_and_slide(_velocity,FLOOR_NORMAL).y
	if(is_on_wall()):
		print("wall")
		change_dir()
		
		
func _on_Hurtbox_area_entered(area):
	print("Enemy dir")
	change_dir()
	damaged(area)

func _on_Hitbox_body_entered(body):
	if(body.name=="TileMap"):
		return
	print(body.name,body.name=="TileMap")	
	change_dir()

func change_dir():
	_velocity.x*=-1
