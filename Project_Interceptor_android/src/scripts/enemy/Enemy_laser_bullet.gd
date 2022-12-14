extends KinematicBody2D

var speed = 500
var direction = Vector2.DOWN

func _physics_process(delta):
	move_and_collide(direction * speed * delta)

