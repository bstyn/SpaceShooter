extends Node

var enemy = preload ("res://src/nodes/Enemy_spaceship.tscn")
var position = Vector2(-50.0,0)
var spawn_time = 15.0

func _on_EnemyTimer_timeout():
	var e = enemy.instance()
	e.position = position
	add_child(e)
	delete_self(e)
	
func delete_self(e):
	#delete after sometime for stability
	yield(get_tree().create_timer(spawn_time,false), "timeout")
	if is_instance_valid(e):
		e.queue_free()
