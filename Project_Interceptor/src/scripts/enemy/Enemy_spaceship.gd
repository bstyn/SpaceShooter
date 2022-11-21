extends KinematicBody2D

var health = 3
var bullet_spawn_time = 0
export (int) var speed = 80
var velocity = Vector2(0, 5)

func _ready():
	shoot()
	pass 

func _physics_process(_delta: float) -> void:
	velocity.x += 1
	velocity = move_and_slide(velocity.normalized() * speed)

func _on_Area2D_area_entered(area):
	if area.name == "player_laser_bullet_area":
		area.get_parent().queue_free()
		health -= 1
		if health == 0:
			Global.Score += 1
			queue_free()
		
func shoot():
	bullet_spawn_time = randi() % 5 + 1
	yield(get_tree().create_timer(bullet_spawn_time), "timeout")
	var laser = preload("res://src/nodes/Enemy_laser_bullet.tscn")
	var bullet = laser.instance()
	bullet.position = Vector2(position.x, position.y)
	get_parent().call_deferred("add_child", bullet)
	shoot()
