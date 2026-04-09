extends CPUParticles2D
class_name BallDieParticles

@export var particle_color : Color

func _ready():
	finished.connect(particle_finished)

func particle_finished():
	queue_free()
