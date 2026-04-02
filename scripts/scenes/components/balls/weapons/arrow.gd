extends Area2D

const speed : float = 250
const damage : float = 10

var parent : Node2D

func _physics_process(delta: float):
	position += transform.x * speed * delta
	
	for body in get_overlapping_bodies():
		if body.is_in_group("ball") and not body == parent:
			body.take_damage(damage)
			queue_free()
		elif body.is_in_group("wall"):
			queue_free()
		
