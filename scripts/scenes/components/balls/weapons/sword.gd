extends Area2D

@export var change_direction_cd : Timer
@export var ability_cd : Timer

const speed : float = 250
const damage : float = 10

var rotation_speed : float = 100
var attack_cd : Timer
var ability_active : bool = false

var parent : Node2D

func _ready():
	attack_cd = get_parent().node_attack_cd 
	
	ability_cd.timeout.connect(ability_toggle)
	change_direction_cd.timeout.connect(change_direction)

func change_direction():
	rotation_speed = -rotation_speed
	change_direction_cd.start(randf_range(1, 6))

func ability_toggle():
	ability_active = not ability_active
	
	rotation_speed = rotation_speed * 25 if ability_active else rotation_speed / 25
	ability_cd.start(1 if ability_active else randf_range(2, 10))
	#if ability_active:
		#rotation_speed

func _process(delta: float):
	rotation_degrees += rotation_speed * delta

func _physics_process(_delta: float):
	for body in get_overlapping_bodies():
		if body.is_in_group("wall"):
			return
		
		if not body == get_parent() and body.is_in_group("ball"):
			if attack_cd.time_left > 0:
				return
			
			print("colisionando con bola enemiga")
			attack_cd.start(1)
			body.take_damage(damage)
		
