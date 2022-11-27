extends KinematicBody2D

var speed = 15000
var direction = Vector2.DOWN

func _ready():
	pass
	
func _physics_process(delta):
	move_and_slide(direction * speed * delta)
