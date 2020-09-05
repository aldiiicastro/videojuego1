extends Area2D
signal eated

func _ready():
	hide()

func eated(body):
	hide()
	$FoodCollision.set_deferred("disabled", true)
	emit_signal("eated")

func play():
	show()
	$FoodCollision.set_deferred("disabled", false)

