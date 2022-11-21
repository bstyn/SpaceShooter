extends KinematicBody2D

var score : int = 0

var speed : int = 300

var vec : Vector2 = Vector2()

var max_health = 3
var current_health = 3

var can_fire = true


onready var sprite : Sprite = get_node("Sprite")

func _physics_process(delta):

	vec.x = 0
	vec.y = 0
	
	if Input.is_action_pressed("move_left"):
		vec.x -= speed
	if Input.is_action_pressed("move_right"):
		vec.x += speed
	if Input.is_action_pressed("move_down"):
		vec.y += speed
	if Input.is_action_pressed("move_up"):
		vec.y -= speed
	if can_fire and Input.is_action_just_pressed("shoot"):
		can_fire = false
		shoot()
	
	move_and_slide(vec, Vector2.UP)

func shoot():
	var laser = preload("res://src/nodes/Player_laser_bullet.tscn")
	var bullet = laser.instance()
	bullet.position = Vector2(position.x, position.y)
	get_parent().call_deferred("add_child", bullet)
	yield(get_tree().create_timer(0.25), "timeout")
	can_fire = true
	
func _on_Area2D_area_entered(area):
	if area.name == "enemy_laser_bullet_area":
		area.get_parent().queue_free()
		current_health -= 1
		if current_health == 0:
			queue_free()
	pass
