extends ProgressBar

func _process(delta):

	var Player = get_node('../../Player_spaceship')
	if is_instance_valid(Player):
		var max_health = Player.max_health
		var current_health = Player.current_health
		self.value = current_health * 100/max_health
	else:
		self.value = 0
