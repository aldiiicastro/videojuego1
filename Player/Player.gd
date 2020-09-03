extends KinematicBody2D

export (int) var speed = 200

var target = Vector2()
var velocity = Vector2()

func _input(event):
	if event.is_action_pressed("space"):
		$Timer.start()
		velocity = velocity * 3

func _physics_process(delta):
	target = get_global_mouse_position()
	velocity = position.direction_to(target) * speed
	look_at(target)
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)

func _on_Timer_timeout():
	velocity = move_and_slide(position.direction_to(target) * speed)
