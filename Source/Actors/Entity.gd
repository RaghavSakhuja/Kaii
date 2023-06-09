extends KinematicBody2D

class_name Entity

#signal hp_reduced(new_hp)
signal died


const FLOOR_NORMAL=Vector2.UP
export(int) var Gravity=2000
export(int) var ACC=40
export(int) var speed=420
export(int) var friction=110
export(int) var hp_max=100
export(int) var hp= hp_max setget set_hp,get_hp
export var _velocity:Vector2=Vector2.ZERO

export (bool) var receives_knockback:bool=true
export (bool) var knockback_modifier:float=1

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
		#print(Gravity)
		#print(get_physics_process_delta_time()*Gravity)
		_velocity.y+=Gravity*get_physics_process_delta_time()
		_velocity.y=clamp(_velocity.y,-750,750)
		



func receive_damage(base_damage:int)->int:
	#do some complimented shit here. 
	var base=base_damage;
	return base;

func receive_knockback(dmg_source:Vector2, received_dmg:int):
	if receives_knockback:
		var knk_bck_dir=dmg_source.direction_to(self.position)
		print(self.position," and ",dmg_source," else ",self.global_position)
		var knk_strength=received_dmg*knockback_modifier
		print(_velocity," pre")
		self._velocity+=knk_bck_dir*knk_strength*5
		
		#self._velocity.y+=-400
#		global_position+=knk_bck_dir*knk_strength
		print(_velocity," post")



func damaged(area):
	print("Entity")
	if(area.is_in_group("hitbox")):
		var hitbox=area
		var base=receive_damage(hitbox.damage);
		self.hp-=base
		receive_knockback(hitbox.global_position,base)
		if(self.hp<0.5*self.hp_max):
			self.scale.x=0.65
			self.scale.y=0.65
		print(hitbox.name+","+hitbox.get_parent().name+"'s hitbox touched "+name+"'s hurtbox and hp: ",self.hp)
		
		if hitbox.is_in_group("projectile"):
			hitbox.destroy()
	

func enter_exit_water(flag:bool):
	pass

func die()->void:
	queue_free()

func _on_Entity_died():
	die()


