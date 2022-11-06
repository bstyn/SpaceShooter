extends KinematicBody2D

var vec = Vector2()

func _ready():
	print("Shooting projectile")
	vec.y = -1500

func _physics_process(delta):
	move_and_slide(vec, Vector2.UP)

#needs to repair position relative to spaceship (it should go JUST up-way)
