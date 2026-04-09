extends RigidBody2D
class_name Ball

@export_group("Customization", "custom_")
@export var custom_color : Color = Color(0.5,0.5,0.5)
@export_range(0.1, 2) var custom_attackcd : float = 0.25

@export_group("Nodes", "node_")
@export var node_sprite : Sprite2D
@export var node_border : Sprite2D
@export var node_collission : CollisionShape2D
@export var node_label : Label
@export var node_attack_cd : Timer
@export var node_movement_cd : Timer 
@export var node_bounce_sfx : AudioStreamPlayer2D
@export var node_weapon : Node2D

const max_hp : float = 100
var hp : float

var die_particles_scene = preload("res://scenes/components/vfx/ball_die_particle.tscn")

const min_scale : float = 0.6
var base_sprite_scale : float 
var base_border_scale : float 

func _ready():
	hp = max_hp
	node_sprite.modulate = custom_color
	lock_rotation = true
	
	
	base_sprite_scale = node_sprite.scale.x
	base_border_scale = node_border.scale.x
	
	node_movement_cd.timeout.connect(movement_cd)

func _process(_delta : float):
	node_label.text = str(int(hp))

func _physics_process(delta : float):
	ball_physics_process(delta)
	if get_contact_count() > 0 and not node_bounce_sfx.playing:
		node_bounce_sfx.pitch_scale = randf_range(0.95, 1.05)
		node_bounce_sfx.play()

func ball_physics_process(_delta : float):
	pass

func take_damage(damage : float):
	hp -= damage
	
	if hp <= 0:
		var die_particle = die_particles_scene.instantiate()
		
		get_tree().current_scene.add_child(die_particle)
		
		die_particle.modulate = custom_color
		die_particle.global_position = global_position
		die_particle.emitting = true
		
		print(die_particle)
		queue_free()
	else: 
		var new_scale : float = 0.5 + (0.5 * (hp / max_hp)) 
		change_scale(new_scale)

func change_scale(new_scale : float):
	var new_sprite_scale : float = base_sprite_scale * new_scale
	var new_border_scale : float = base_border_scale * new_scale
	
	node_sprite.scale = Vector2(new_sprite_scale, new_sprite_scale)
	node_border.scale = Vector2(new_border_scale, new_border_scale)
	node_collission.scale = Vector2(new_scale, new_scale)
	#node_label.scale = Vector2(new_scale, new_scale)
	node_weapon.scale = Vector2(new_scale, new_scale)
	

func movement_cd():
	apply_central_impulse(Vector2(randi_range(-50, 300),randi_range(-50, 300)))
	node_movement_cd.start(randf_range(1, 6))
