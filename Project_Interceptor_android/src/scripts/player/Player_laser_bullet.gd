extends KinematicBody2D

var speed = 500
var direction = Vector2.UP
var player_bullet_dmg = 1

func _physics_process(delta):
	move_and_collide(direction * speed * delta)
