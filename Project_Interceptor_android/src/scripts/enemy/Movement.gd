extends KinematicBody2D

export (int) var speed = 50
var velocity = Vector2()

func _ready():
	pass 

func _physics_process(_delta: float) -> void:
	velocity.x += 1
	velocity = move_and_slide(velocity.normalized() * speed)
	
