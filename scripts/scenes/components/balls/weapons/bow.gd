extends Node2D

@export var change_direction_cd : Timer
@export var bow_sprite : Sprite2D

var rotation_speed : float = 100
var attack_cd : Timer

var arrow_scene = preload("res://scenes/components/balls/weapons/arrow.tscn")

func _ready():
	attack_cd = get_parent().node_attack_cd 
	attack_cd.timeout.connect(attack)
	
	change_direction_cd.timeout.connect(change_direction)

func _process(delta : float):
	rotation_degrees += rotation_speed * delta

func change_direction():
	rotation_speed = -rotation_speed
	change_direction_cd.start(randf_range(1, 6))

func attack():
	var arrow = arrow_scene.instantiate()
	arrow.parent = get_parent()
	
	get_tree().root.add_child(arrow)
	
	arrow.global_position = self.global_position
	arrow.rotation = self.rotation
	attack_cd.start(randf_range(0.5, 2))
