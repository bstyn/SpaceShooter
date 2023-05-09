extends TextureProgress


onready var player = get_node("../../Player_spaceship")
onready var popup = get_tree().get_root().get_node("MainScene/LevelUpMenu/Popup")

func _process(delta):

	var Player = get_node('../../Player_spaceship')
	if is_instance_valid(Player):
		self.value = Global.experience * 100/Global.max_experience
	else:
		self.value = 0

func _close_popup():
	popup.hide()
	get_tree().paused = false
	if is_instance_valid(player):
		player.set_process_input(false)


func _on_XP_Bar_value_changed(value):
	if Global.experience >= Global.max_experience:
		Global.lvl += 1
		Global.experience = 0
		Global.max_experience += 15
		get_tree().paused = true
		#Show popup
		if is_instance_valid(player):
			player.set_process_input(false)
		popup.popup()
		


func _on_Upgrade_pressed():
	player.bullet_damage += 1
	_close_popup()


func _on_Upgrade2_pressed():
	player.attack_speed -= 0.05
	_close_popup()


func _on_Upgrade3_pressed():
	player.max_health += 1
	player.current_health +=1
	_close_popup()
