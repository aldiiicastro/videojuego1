extends Node2D

func _ready():
	hide()

func lost():
	hide()
	queue_free()

func start():
	set_position(Vector2(rand_range(0, 800), rand_range(0, 500)))
	show()
