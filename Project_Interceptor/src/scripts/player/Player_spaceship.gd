extends KinematicBody2D

var stats: CharacterStats setget set_stats

var vec : Vector2 = Vector2()
var max_health = null	
var current_health = null

var can_fire = true

var bullets_type = "normal"
var timer = null

var Explosion = preload ("res://src/nodes/Explosion2.tscn")

func _ready():
	stats = Global._save.characterstats
	max_health = stats.max_health
	current_health = stats.max_health
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
func set_stats(new_stats: CharacterStats) -> void:
	stats = new_stats
	set_physics_process(stats != null)

func _physics_process(_delta):
	

	var joystick = get_tree().get_root().get_node("MainScene/GUI/Joystick")
	vec = joystick.get_velo()
	
	if can_fire:
		can_fire = false
		shoot()
	
	var _ms_velocity = move_and_slide(vec * stats.move_speed, Vector2.UP)

func shoot():
	var laser = preload("res://src/nodes/Player_laser_bullet.tscn")
	var bullet = laser.instance()
	bullet.player_bullet_dmg = stats.bullet_damage
	if bullets_type == "normal":
		bullet.position = Vector2(position.x, position.y)
		get_parent().call_deferred("add_child", bullet)
		yield(get_tree().create_timer(stats.attack_speed), "timeout")
		can_fire = true
	elif bullets_type == "double":
		bullet.position = Vector2(position.x-15, position.y)
		var bullet2 = laser.instance()
		bullet2.position = Vector2(position.x+15, position.y)
		get_parent().call_deferred("add_child", bullet)
		get_parent().call_deferred("add_child", bullet2)
		yield(get_tree().create_timer(0.3), "timeout")
		can_fire = true
	elif bullets_type == "triple":
		bullet.position = Vector2(position.x-25, position.y-15)
		var bullet2 = laser.instance()
		bullet2.position = Vector2(position.x, position.y)
		var bullet3 = laser.instance()
		bullet3.position = Vector2(position.x+25, position.y-15)
		get_parent().call_deferred("add_child", bullet)
		get_parent().call_deferred("add_child", bullet2)
		get_parent().call_deferred("add_child", bullet3)
		yield(get_tree().create_timer(0.4), "timeout")
		can_fire = true
	elif bullets_type == "nonstop":
		bullet.position = Vector2(position.x, position.y)
		get_parent().call_deferred("add_child", bullet)
		yield(get_tree().create_timer(0.05), "timeout")
		can_fire = true
	elif bullets_type == "big":
		bullet.position = Vector2(position.x, position.y)
		bullet.scale = Vector2(2.5,2.5)
		bullet.player_bullet_dmg = 3
		get_parent().call_deferred("add_child", bullet)
		yield(get_tree().create_timer(1), "timeout")
		can_fire = true
	elif bullets_type == "ring":
		laser = preload("res://src/nodes/Player_laser_ringbullet.tscn")
		bullet = laser.instance()
		bullet.position = Vector2(position.x, position.y)
		get_parent().call_deferred("add_child", bullet)
		yield(get_tree().create_timer(0.4), "timeout")
		can_fire = true
	elif bullets_type == "more_dmg":
		bullet.position = Vector2(position.x, position.y)
		bullet.player_bullet_dmg = 5
		get_parent().call_deferred("add_child", bullet)
		yield(get_tree().create_timer(0.25), "timeout")
		can_fire = true
	
func _on_Area2D_area_entered(area):
	if area.name == "enemy_laser_bullet_area":
		area.get_parent().queue_free()
		current_health -= 1
		blink()
		if current_health <= 0:
			game_over()
	if area.name == "drop_area":
		var sprite = area.get_parent().get_node("Sprite")
		area.get_parent().queue_free()
		Global.Score += 10
		change_weapons(sprite)
	pass
	
func game_over():
	var popup = get_tree().get_root().get_node("MainScene/GameOver/Popup")
	self.queue_free()
	var explosion = Explosion.instance()
	get_parent().add_child(explosion)
	explosion.global_position = global_position
	get_tree().paused = true
	stats.max_health += 1
	Global.currency.coins += round(Global.Score/5)
	Global._save_game()
	popup.popup()
	
func change_weapons(sprite):
	if sprite.get_node("Blue").is_visible():
		bullets_type = "double"
		timer.set_wait_time(15)
		timer.start()
	elif sprite.get_node("Green").is_visible():
		bullets_type = "triple"
		timer.set_wait_time(15)
		timer.start()
	elif sprite.get_node("Orange").is_visible():
		bullets_type = "nonstop"
		timer.set_wait_time(3)
		timer.start()
	elif sprite.get_node("Pink").is_visible():
		bullets_type = "big"
		timer.set_wait_time(10)
		timer.start()
	elif sprite.get_node("Red").is_visible():
		bullets_type = "ring"
		timer.set_wait_time(10)
		timer.start()
	elif sprite.get_node("White").is_visible():
		bullets_type = "more_dmg"
		timer.set_wait_time(10)
		timer.start()
	elif sprite.get_node("Hearth").is_visible():
		if current_health < stats.max_health:
			current_health += 1
		else:
			Global.Score += 15

func blink():
	hide()
	yield(get_tree().create_timer(0.05,false), "timeout")
	show()

func on_timeout_complete():
	bullets_type = "normal"
	timer.set_wait_time(0)
