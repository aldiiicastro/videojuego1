extends Area2D
signal eated 
var score =0

func eated(body):
	hide()
	emit_signal("eated")
	$FoodCollision.disabled = true

func getScore():
	score = score + 1
	return score

