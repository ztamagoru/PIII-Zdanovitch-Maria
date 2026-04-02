extends Button

const normal_speed : float = 1
@export var sped_up : float = 2

func _ready() -> void:
	text = "x" + str(int(sped_up))

func _on_button_down():
	Engine.time_scale = sped_up

func _on_button_up() -> void:
	Engine.time_scale = normal_speed
