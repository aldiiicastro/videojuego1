extends CanvasLayer

signal startGame

func showMessage(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func gameOverI():
	showMessage("Game Over")
	yield($MessageTimer, "timeout")
	$StartBtn.show()
	$MessageLabel.text = "Nombre del juego"
	$MessageLabel.show()


func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func updateScore(score):
	$ScoreLabel.text = str(score)


func _on_StartBtn_pressed():
	$StartBtn.hide()
	emit_signal("startGame")
