extends KinematicBody2D

var stats: CharacterStats setget set_stats

var vec : Vector2 = Vector2()
var max_health = null	
var current_health = null

var can_fire = true
var attack_speed = null

var bullets_type = "normal"
var bullet_damage = null
var timer = null

var Explosion = preload ("res://src/nodes/Explosion2.tscn")

func _ready():
	set_stats(Global._save.characterstats)
	max_health = stats.max_health
	current_health = stats.max_health
	bullet_damage = stats.bullet_damage
	attack_speed = stats.attack_speed
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
	bullet.player_bullet_dmg = bullet_damage
	if bullets_type == "normal":
		bullet.position = Vector2(position.x, position.y)
		get_parent().call_deferred("add_child", bullet)
		yield(get_tree().create_timer(attack_speed), "timeout")
		can_fire = true
	
	
func _on_Area2D_area_entered(area):
	if area.name == "enemy_laser_bullet_area":
		area.get_parent().queue_free()
		current_health -= 1 * (1 - stats.dmg_reduction)
		blink()
		if current_health <= 0:
			game_over()
	pass
	
func game_over():
	var popup = get_tree().get_root().get_node("MainScene/GameOver/Popup")
	self.queue_free()
	var explosion = Explosion.instance()
	get_parent().add_child(explosion)
	explosion.global_position = global_position
	get_tree().paused = true
	Global.currency.coins += round(Global.Score/5) * stats.coins_multiplier
	Global.lvl = 1
	Global.experience = 0
	Global.max_experience = 12
	Global._save_game()
	popup.popup()
	
func blink():
	hide()
	yield(get_tree().create_timer(0.05,false), "timeout")
	show()

func on_timeout_complete():
	bullets_type = "normal"
	timer.set_wait_time(0)
