extends Node

var enemy = preload ("res://src/nodes/Enemy_spaceship.tscn")
var stats: CharacterStats setget set_stats
var position = Vector2(-50.0,0)
var spawn_time = 20.0

func _ready():
	set_stats(Global._save.characterstats)
	Global.increaseHealth(2)
	Global.increaseSpawn(1)
	spawn_enemy()

func set_stats(new_stats: CharacterStats) -> void:
	stats = new_stats
	set_physics_process(stats != null)

func spawn_enemy():
	randomize()
	var time = stats.spawn_timer
	var random_position = randi()%9+1
	var e = enemy.instance()
	e.position = Vector2(random_position*100,-50.0)
	add_child(e)
	delete_self(e)
	yield(get_tree().create_timer(time,false), "timeout")
	for x in range(Global.spawn_number):
		spawn_enemy()
	
	
func delete_self(e):
	#delete after sometime for stability
	yield(get_tree().create_timer(spawn_time,false), "timeout")
	if is_instance_valid(e):
		e.queue_free()
