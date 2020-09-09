extends KinematicBody2D
var velocity
var target

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func setTarget(tar):
	target = tar

func _physics_process(delta):
	velocity = position.direction_to(target)  * 150
	look_at(target)
	if position.distance_to(target) > 5:
		velocity = move_and_collide(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func enemyDisapear():
	hide()
	$CollisionPolygon2D.set_deferred("disabled", true)
