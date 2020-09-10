extends Area2D
signal eated

func _ready():
	hide()

##Se esconde y envia una señal cuando es colisionado.
func eated(body):
	hide()
	$FoodCollision.set_deferred("disabled", true)
	emit_signal("eated")

##Se setea una posicion alateria y se muestra.
func start():

	set_position(Vector2(rand_range(0, 1000), rand_range(0, 600)))
	show()
	$FoodCollision.set_deferred("disabled", false)

func lost():
	hide()
	$FoodCollision.set_deferred("disabled", true)
	queue_free()
