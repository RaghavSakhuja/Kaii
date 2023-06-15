extends KinematicBody2D

class_name Entity

const FLOOR_NORMAL=Vector2.UP
export var Gravity=1000.0
export var ACC=40
export var speed=500
export var friction=50
export var hp=100

export var _velocity:Vector2=Vector2.ZERO

func apply_grav()->void:
		_velocity.y+=Gravity*get_physics_process_delta_time()
		
onready var sprite=$Sprite
onready var collShape=$CollisionShape2D
onready var animPlayer=$AnimationPlayer

func die()->void:
	queue_free()


func receive_damage(base_damage:int)->int:
	#do some complimented shit here. 
	var base=base_damage-10;
	return base;


func _on_Hurtbox_area_entered(hitbox):
	var base=receive_damage(hitbox.damage);
	self.hp-=base
	print(hitbox.get_parent().name+"'s hitbox touched "+name+"'s hurtbox")
	
