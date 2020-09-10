extends Area2D
var target = Vector2()
var limit
signal win
var velocity 

func _ready():
	hide()

func start(pos, tar):
	position = pos
	show()
	target = tar
	$CollisionPolygon2D.set_deferred("disabled", false)

func lost():
	hide()
	queue_free()
	$CollisionPolygon2D.set_deferred("disabled", true)

func _physics_process(delta):
	velocity = position.direction_to(target.global_position) * 100
	if position.distance_to(target.global_position)> 5:
		position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func enemyDisapear(body):
	hide()
	emit_signal("win")
	queue_free()
	$CollisionPolygon2D.set_deferred("disabled", true)
