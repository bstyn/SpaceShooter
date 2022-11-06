extends Node

var enemy = preload ("res://src/nodes/Enemy_spaceship.tscn")
var position = Vector2(-50.0,48.0)

func _on_EnemyTimer_timeout():
	var e = enemy.instance()
	e.position = position
	add_child(e)
