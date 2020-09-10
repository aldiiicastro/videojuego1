extends Area2D
signal eated

func _ready():
	hide()

func eated(body):
	hide()
	$FoodCollision.set_deferred("disabled", true)
	emit_signal("eated")

func start():
	set_collision_mask(4)  
	set_position(Vector2(rand_range(0, 1000), rand_range(0, 600)))
	show()
	$FoodCollision.set_deferred("disabled", false)

func lost():
	hide()
	$FoodCollision.set_deferred("disabled", true)
	queue_free()
