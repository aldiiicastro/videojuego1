extends KinematicBody2D

export (int) var speed = 200
signal lost 
var target = Vector2()
var velocity = Vector2()
var limit 

func _ready():
	hide()
	limit = get_viewport_rect().size

func start(pos):
	position = pos
	show()
	$Colision.disabled = false
	$Area2D/Colision2.disabled = false
	
func _input(event):
	if event.is_action_pressed("space"):
		$Timer.start()
		velocity = move_and_slide(velocity * 3)

func _physics_process(delta):
	target = get_global_mouse_position()
	velocity = position.direction_to(target) * speed 
	look_at(target)
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)

func _on_Timer_timeout():
	velocity = move_and_slide(position.direction_to(target) * speed)

func enemyTouch(body):
	hide()
	emit_signal("lost")
	$Area2D/Colision2.disabled = true
	$Colision.disabled = true
