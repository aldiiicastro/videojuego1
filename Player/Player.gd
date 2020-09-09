extends Area2D

export (int) var speed = 200
signal lost 
var target = Vector2()
var velocity = Vector2()
var limit 
var del
var pointer_treshol = 50

func _ready():
	hide()
	limit = get_viewport_rect().size

func start(pos):
	position = pos
	show()
	$Colision.set_deferred("disabled", false)

func _input(event):
	if event.is_action_pressed("space"):
		$Timer.start()
		velocity = position.direction_to(target) * speed * 3
		position += velocity * del


func _process(delta):
	target = get_local_mouse_position()
	if target.length() > pointer_treshol:
		var direccion = target.normalized()
		position += direccion * delta * 200
		$Image.look_at(get_global_mouse_position())


func enemyTouch():
	hide()
	emit_signal("lost")
	$Colision.set_deferred("disabled", true)

func _on_Timer_timeout():
	velocity = position.direction_to(target) * speed
	position += velocity * del
