extends KinematicBody2D

var speed = 700
var direction = Vector2.UP
var player_bullet_dmg 

func _physics_process(delta):
	move_and_collide(direction * speed * delta)
