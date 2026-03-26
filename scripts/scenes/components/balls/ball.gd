extends RigidBody2D
class_name Ball

@export_group("Customization", "custom_")
@export var custom_color : Color = Color(0.5,0.5,0.5)
@export_range(0.1, 2) var custom_size : float = 1
@export_range(0.1, 2) var custom_attackcd : float = 0.25

@export_group("Nodes", "node_")
@export var node_sprite : Sprite2D
@export var node_collision : CollisionShape2D
@export var node_elements : Node2D
@export var node_label : Label
@export var node_attack_cd : Timer
@export var node_movement_cd : Timer 
@export var node_bounce_sfx : AudioStreamPlayer2D

var hp : int = 100

func _ready():
	node_sprite.scale = Vector2(1,1) * custom_size
	node_collision.scale = Vector2(1,1) * custom_size
	node_elements.scale = Vector2(1,1) * custom_size
	
	node_sprite.modulate = custom_color

func _physics_process(delta : float):
	ball_physics_process(delta)
	if get_contact_count() > 0 and not node_bounce_sfx.playing:
		node_bounce_sfx.play()

func ball_physics_process(_delta : float):
	pass
