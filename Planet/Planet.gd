extends Node2D
var score = 0
var foodArray 
var holeArray
var enemyArray = []
export (PackedScene) var Enemy
export (PackedScene) var Food
func _ready():
	randomize()

func newGame():
	holeArray = [$Hole, $Hole2, $Hole3]
	$StartTime.start()
	$Interface.showMessage("Start Game")
	score = 0
	$Interface.updateScore(score)
	for hole in holeArray:
		hole.show()
		hole.set_position(Vector2(rand_range(0, 900), rand_range(0, 600)))

func gameOver():
	score = 0
	for enemy in enemyArray:
		enemy.lost()
	$Interface.updateScore(score)
	$EnemyTime.stop()
	$Interface.gameOverI()

func _on_StartTime_timeout():
	$EnemyTime.start()
	$FoodTime.start()
	$Player.start($StartPosition.position) #Posicion de inicio del jugador

func _on_Food_eated():
	score = score + 1
	$Interface.updateScore(score)

func _on_EnemyTime_timeout():
	var enemy = Enemy.instance()
	enemy.connect("win", $Player, "enemyTouch")
	add_child(enemy)
	enemy.start($Hole.position,$Player)
	enemyArray.append(enemy)

func _on_FoodTime_timeout():
	var food = Food.instance()
	food.connect("eated", self, "_on_Food_eated")
	add_child(food)
	food.start()
