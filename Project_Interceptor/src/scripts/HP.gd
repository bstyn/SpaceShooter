extends Label

onready var player = get_node("../../Player_spaceship")

func _process(delta):

	var newText = player.max_health
	self.text = str(newText)
