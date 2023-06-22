extends KinematicBody2D

class_name Entity

#signal hp_reduced(new_hp)
signal died

const FLOOR_NORMAL=Vector2.UP
export(int) var Gravity=1000
export(int) var ACC=40
export(int) var speed=500
export(int) var friction=50
export(int) var hp_max=100
export(int) var hp= hp_max setget set_hp,get_hp
export var _velocity:Vector2=Vector2.ZERO

onready var sprite=$Sprite
onready var collShape=$CollisionShape2D
onready var animPlayer=$AnimationPlayer

func set_hp(val:int):
	if(val!=hp):
		var new=clamp(val,0,hp_max)
		#if(new<hp):
			#emit_signal("hp_reduced",hp)
		if(new==0):
			emit_signal("died")
		hp=new;

func get_hp():
	return hp




func apply_grav()->void:
		_velocity.y+=Gravity*get_physics_process_delta_time()
		



func receive_damage(base_damage:int)->int:
	#do some complimented shit here. 
	var base=base_damage;
	return base;

func _on_Hurtbox_area_entered(hitbox):
	var base=receive_damage(hitbox.damage);
	self.hp-=base
	if(self.hp/self.hp_max<0.5):
		self.scale.x=0.8
		self.scale.y=0.8
	print(hitbox.name+","+hitbox.get_parent().name+"'s hitbox touched "+name+"'s hurtbox and hp: ",self.hp)
	
	if hitbox.is_in_group("projectile"):
		hitbox.destroy()



func die()->void:
	queue_free()

func _on_Entity_died():
	die()
