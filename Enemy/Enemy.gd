extends Area2D
var target = Vector2()
var limit
signal win
var velocity = Vector2.ZERO
export(float) var friction = 0.9
export(float) var speed = 15

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
	velocity += position.direction_to(target.global_position).normalized() * speed
	velocity *=friction
	if velocity.length() < 1:
		velocity = Vector2.ZERO
	position += velocity * delta
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func enemyDisapear(body):
	hide()
	emit_signal("win")
	queue_free()
	$CollisionPolygon2D.set_deferred("disabled", true)
