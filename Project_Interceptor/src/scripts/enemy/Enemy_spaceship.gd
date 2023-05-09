extends KinematicBody2D

var maxhealth = Global.enemyHealth
var health = maxhealth
export (int) var speed = 125
var velocity = Vector2(0, 5)
onready var audio_destroyed = $AudioStreamPlayer2D
var Explosion = preload ("res://src/nodes/Explosion2.tscn")
var stats: CharacterStats setget set_stats

func set_stats(new_stats: CharacterStats) -> void:
	stats = new_stats
	set_physics_process(stats != null)
	
func _ready():
	set_stats(Global._save.characterstats)
	shoot()


func _physics_process(_delta: float) -> void:
	velocity.y -= 1
	velocity = move_and_slide(velocity.normalized() * speed, Vector2.DOWN)

func _on_Area2D_area_entered(area):
	if area.name == "player_laser_bullet_area":
		health -= area.get_parent().player_bullet_dmg
		blink()
		area.get_parent().queue_free()
	if health <= 0:
		if !audio_destroyed.is_playing():
			AudioPlayer.play("res://src/assets/sfx/destroyed.mp3")
		Global.Score += 5
		Global.experience += maxhealth * stats.exp_multiplier
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


func blink():
	hide()
	yield(get_tree().create_timer(0.05,false), "timeout")
	show()
		
