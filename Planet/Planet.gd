extends Node2D
var score = 0
var foodArray 
var holeArray
export (PackedScene) var Enemy
func _ready():
	randomize()

func newGame():
	foodArray = [$Food, $Food2, $Food3,$Food4,$Food5]
	holeArray = [$Hole, $Hole2, $Hole3]
	$Player.start($StartPosition.position) #Posicion de inicio del jugador
	$StartTime.start()
	$Interface.showMessage("Start Game")
	score = 0
	$Interface.updateScore(score)
	for hole in holeArray:
		hole.show()
	for food in foodArray:
		food.play()
		food.set_position(Vector2(rand_range(0, 900), rand_range(0, 600)))
	
func gameOver():
	score = 0
	$Interface.updateScore(score)
	$EnemyTime.stop()
	$Interface.gameOverI()

func _on_StartTime_timeout():
	$EnemyTime.start()

func _on_Food_eated():
	score = score + 1
	$Interface.updateScore(score)
	if score == foodArray.size():
		$Player.hide()
		$EnemyTime.stop()
		$Interface.winGameI()

func _on_EnemyTime_timeout():
	$TriangleRoad/MoveOnRoad.set_offset(randi())
	var enemy = Enemy.instance()
	add_child(enemy)
	var dir = $TriangleRoad/MoveOnRoad.rotation
	enemy.position = $TriangleRoad/MoveOnRoad.position
	dir += rand_range(-PI /6, PI) 
	enemy.rotation = dir
	enemy.set_linear_velocity(Vector2(rand_range(enemy.Velocidad_min, enemy.Velocidad_max), 0).rotated(dir))

	
