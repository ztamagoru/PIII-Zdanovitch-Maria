extends RigidBody2D
class_name Ball

@export_group("Customization", "custom_")
@export var custom_color : Color = Color(0.5,0.5,0.5)
@export_range(0.1, 2) var custom_attackcd : float = 0.25

@export_group("Nodes", "node_")
@export var node_sprite : Sprite2D
@export var node_label : Label
@export var node_attack_cd : Timer
@export var node_movement_cd : Timer 
@export var node_bounce_sfx : AudioStreamPlayer2D

var hp : float = 100

func _ready():
	node_sprite.modulate = custom_color
	lock_rotation = true
	
	node_movement_cd.timeout.connect(movement_cd)

func _process(_delta : float):
	node_label.text = str(int(hp))
	
	if hp <= 0: queue_free()

func _physics_process(delta : float):
	ball_physics_process(delta)
	if get_contact_count() > 0 and not node_bounce_sfx.playing:
		node_bounce_sfx.pitch_scale = randf_range(0.95, 1.05)
		node_bounce_sfx.play()

func ball_physics_process(_delta : float):
	pass

func take_damage(damage : float):
	hp -= damage

func movement_cd():
	apply_central_impulse(Vector2(randi_range(-50, 300),randi_range(-50, 300)))
	node_movement_cd.start(randf_range(1, 6))
