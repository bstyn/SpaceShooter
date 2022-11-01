extends KinematicBody2D

var score : int = 0

var speed : int = 300

var vec : Vector2 = Vector2()

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
	if Input.is_action_pressed("shoot"):
		shoot()
	
	move_and_slide(vec, Vector2.UP)

func shoot():
	
	var laser = load("res://src/nodes/Laser_bullet.tscn")
	var bullet = laser.instance()
	add_child_below_node(get_tree().get_root().get_node("MainScene"),bullet)
