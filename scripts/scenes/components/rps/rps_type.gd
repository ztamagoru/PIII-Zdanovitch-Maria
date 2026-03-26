extends RigidBody2D
class_name rps_type

@export_enum("Piedra", "Papel", "Tijeras") var selected_type : int = 1

@export_group("Sprites", "sprite_")
@export var sprite_node : Sprite2D
@export var sprite_rock : Texture2D
@export var sprite_paper : Texture2D
@export var sprite_scissors : Texture2D

@export var convert_vfx : AudioStreamPlayer2D

const speed : float = 100.0
var direction : Vector2

var current_type 
var beats = {
	0: 2,
	1: 0,
	2: 1
}

func _ready():
	change_type(selected_type)
	
	direction = Vector2(randf_range(-50, 50), randf_range(-50, 50)).normalized()
	linear_velocity = direction * speed

func _process(_delta : float):
	pass
	if get_contact_count() > 0:
		for i in get_colliding_bodies():
			if i.is_in_group("ball"):
				if current_type != i.current_type:
					if check_fight(current_type, i.current_type) and not convert_vfx.playing:
						change_type(i.current_type)
						convert_vfx.play()
						convert_vfx.pitch_scale = randf_range(1, 1.125)
					else:
						pass

func change_type(new_type : int):
	current_type = new_type
	sprite_node.texture = sprite_rock if new_type == 0 else sprite_paper if new_type == 1 else sprite_scissors

func check_fight(current_ball_type : int, enemy_type : int) -> bool:
	return not beats[current_ball_type] == enemy_type
