extends Node2D

func _ready():
	randomize()

func newGame():
	$Player.start($StartPosition.position) #Posicion de inicio del jugador
	$StartTime.start()
	$Interface.showMessage("Start Game")
	$Interface.updateScore(0)
	
func gameOver():
	$EnemyTime.stop()
	$Interface.gameOverI()

func _on_StartTime_timeout():
	$EnemyTime.start()

func _on_Food_eated():
	$Interface.updateScore($Food.getScore())
	

