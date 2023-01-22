extends KinematicBody2D

var health = Global.enemyHealth
export (int) var speed = 125
var one_drop_chance_percent = 2
var velocity = Vector2(0, 5)
onready var audio_destroyed = $AudioStreamPlayer2D
var Explosion = preload ("res://src/nodes/Explosion2.tscn")


func _ready():
	shoot()
	pass 

func _physics_process(_delta: float) -> void:
	velocity.y -= 1
	velocity = move_and_slide(velocity.normalized() * speed, Vector2.DOWN)

func _on_Area2D_area_entered(area):
	if area.name == "player_laser_bullet_area":
		health -= area.get_parent().player_bullet_dmg
		blink()
		area.get_parent().queue_free()
	elif area.name == "player_laser_ringbullet_area":
		health -= area.get_parent().player_bullet_dmg
	if health <= 0:
		if !audio_destroyed.is_playing():
			AudioPlayer.play("res://src/assets/sfx/destroyed.mp3")
		Global.Score += 5
		generate_drop()
		self.queue_free()
		var explosion = Explosion.instance()
		get_parent().add_child(explosion)
		explosion.global_position = global_position
		
		
func shoot():
	var bullet_spawn_time = randi() % 5 + 1
	yield(get_tree().create_timer(bullet_spawn_time,false), "timeout")
	var laser = preload("res://src/nodes/Enemy_laser_bullet.tscn")
	var bullet = laser.instance()
	bullet.position = Vector2(position.x, position.y)
	get_parent().call_deferred("add_child", bullet)
	shoot()

func generate_drop():
	var drop_spawn_chance_range = randi() % 100 + 1
	var drop_node = preload("res://src/nodes/Drop.tscn")
	var drop = drop_node.instance()
	drop.position = Vector2(position.x, position.y)
	var sprite = drop.get_node("Sprite")
	if (drop_spawn_chance_range <= one_drop_chance_percent * 1):
		sprite.get_node("Blue").show()
	elif (drop_spawn_chance_range <= one_drop_chance_percent * 2):
		sprite.get_node("Green").show()
	elif (drop_spawn_chance_range <= one_drop_chance_percent * 3):
		sprite.get_node("Orange").show()
	elif (drop_spawn_chance_range <= one_drop_chance_percent * 4):
		sprite.get_node("Pink").show()
	elif (drop_spawn_chance_range <= one_drop_chance_percent * 5):
		sprite.get_node("Red").show()
	elif (drop_spawn_chance_range <= one_drop_chance_percent * 6):
		sprite.get_node("White").show()
	elif (drop_spawn_chance_range <= one_drop_chance_percent * 7):
		sprite.get_node("Hearth").show()
	if (drop_spawn_chance_range < one_drop_chance_percent * 7):
		get_parent().call_deferred("add_child", drop)
	
func blink():
	hide()
	yield(get_tree().create_timer(0.05,false), "timeout")
	show()
		
