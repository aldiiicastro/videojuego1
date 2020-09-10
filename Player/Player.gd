extends Area2D

export (int) var speed = 200
var speedNormal = 200
var speedDashing = speedNormal * 3
signal lost 
var target = Vector2()
var limit 
var del
var isDashing = false
func _ready():
	hide()
	limit = get_viewport_rect().size

func start(pos):
	position = pos
	show()
	$Colision.set_deferred("disabled", false)

func _input(event):
	pass

func _process(delta):
	if speed == 200:
		target = get_local_mouse_position()
	if target.length() > 50:
		var direccion = target.normalized()
		position += direccion * delta * speed
		$Image.look_at(get_global_mouse_position())
		if Input.is_action_just_pressed("space") && !isDashing:
			dashing(delta, direccion)

func dashing(delta, direcccion):
	isDashing = true
	$Time.start()
	speed = speedDashing
	position += direcccion * delta * speed

func enemyTouch():
	hide()
	emit_signal("lost")
	$Colision.set_deferred("disabled", true)

func _on_Time_timeout():
	isDashing = false
	speed = speedNormal
