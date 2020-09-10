extends Node2D

var score = 0
var foodArray = []
var holeArray = []
var enemyArray = []
var numsHoles = 3

export (PackedScene) var Hole
export (PackedScene) var Enemy
export (PackedScene) var Food

func _ready():
	randomize()

##Para arrancar un nuevo juego
func newGame():
	$StartTime.start()
	$Interface.showMessage("Start Game")
	$Interface.updateScore(score)

##Cuando se pierde
func gameOver():
	score = 0
	$Interface.updateScore(score)
	timerStops()
	cleanGame(enemyArray)
	cleanGame(holeArray)
	cleanGame(foodArray)
	$Interface.gameOverI()

##Cuando se gana
func gameWin():
	score = 0
	$Interface.updateScore(score)
	timerStops()
	cleanGame(enemyArray)
	cleanGame(holeArray)
	cleanGame(foodArray)
	$Player.hide()
	$Interface.winGameI()

##Limpia las listas para comenzar las nuevas partidas
func cleanGame(array):
	for i in array:
		i.lost()
	array.clear()

##Frena los relojes una vez que la partida finalizo
func timerStops():
	$EnemyTime.stop()
	$EnemyDead.stop()
	$FoodTime.stop()

func _on_StartTime_timeout():
	$EnemyTime.start()
	$FoodTime.start()
	$Player.start($StartPosition.position) #Posicion de inicio del jugador
	setHoles()

##Se inicializan los agujeros de spawn
func setHoles():
	for i in range(numsHoles):
		var hole = Hole.instance()
		add_child(hole)
		holeArray.append(hole)
		hole.start()

##Cuando un rombo es comido, se cambia el score
func _on_Food_eated():
	if score == 20:
		gameWin()
	else:
		score = score + 1
		$Interface.updateScore(score)

##Cuando el tiempo de spawn termina se instancia otro, ademas se fija si ya llego a su maximo espera y sino sigue spawneando,
## se pone la posicion aleatoria de los agujeros.
func _on_EnemyTime_timeout():
	var enemy = Enemy.instance()
	enemy.connect("win", $Player, "enemyTouch")
	if enemyArray.size() == 7:
		$EnemyTime.stop()
	elif enemyArray.size() < 7:
		$EnemyDead.start()
		add_child(enemy)
		enemyPosition(enemy)
		enemyArray.append(enemy)

##Se inicializa la posicion del enemigo segun los agujeros
func enemyPosition(enemy):
		var hole = holeArray.pop_front()
		enemy.start(hole.position, $Player)
		holeArray.append(hole)
		
##Cuando este tiempo termina, se fija de sacar al enemigo que mas tiempo lleva 
##y reiniciar el $EnemyTime por si este se habia frenado
func _on_EnemyDead_timeout():
	if !enemyArray.empty():
		enemyArray.pop_front().lost()
	$EnemyTime.start()
	
##Cuando se termina el tiempo, aparecen mas rombos, se fija la cantidad de rombos segun el score paras dar la win
func _on_FoodTime_timeout():
	var food = Food.instance()
	food.connect("eated", self, "_on_Food_eated")
	add_child(food)
	food.start()
	foodArray.append(food)
	print(score)



