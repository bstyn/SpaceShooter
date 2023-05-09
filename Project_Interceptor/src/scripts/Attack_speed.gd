extends Label

onready var player = get_node("../../Player_spaceship")

func _process(delta):

	var newText = player.attack_speed
	self.text = str(newText)
