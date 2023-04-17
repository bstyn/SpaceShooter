extends TextureProgress


onready var player = get_node("../../Player_spaceship")
onready var popup = get_tree().get_root().get_node("MainScene/LevelUpMenu/Popup")

func _process(delta):

	var Player = get_node('../../Player_spaceship')
	if is_instance_valid(Player):
		self.value = Global.experience * 100/Global.max_experience
	else:
		self.value = 0


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
		
