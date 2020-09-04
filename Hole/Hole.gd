extends Node2D
export (PackedScene) var Enemy

func _on_EnemyTimer_timeout():
	$TriangleRoad/MoveOnRoad.set_offset(randi())
	var enemy = Enemy.instance()
	add_child(enemy)
	$Player.get_global_mouse_position()
	

