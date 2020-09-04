extends Node2D
var array_foods

func _ready():
	randomize()
	array_foods = [$Food, $Food2,$Food3, $Food4, $Food5]

func newGame():
	while array_foods != []:
		$Player.start($StartPosition.position) #Posicion de inicio del jugador
		$StartTime.start()
		$Interface.showMessage("Start Game")
		$Interface.updateScore($Food.getScore())
	
func gameOver():
	$EnemyTime.stop()
	$Interface.gameOverI()

func _on_StartTime_timeout():
	$EnemyTime.start()

func _on_Food_eated():
	$Interface.updateScore($Food.getScore())
	

