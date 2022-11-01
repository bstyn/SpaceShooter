extends KinematicBody2D

var vec = Vector2()

func _ready():
	print("Shooting projectile")
	vec.y = -600

func _physics_process(delta):
	move_and_slide(vec)


#needs to repair infinite spawn bug and position relative to spaceship (it should go JUST up-way)
