extends Label

onready var player = get_node("../../Player_spaceship")

func _process(delta):

	var newText = player.current_health
	self.text = str(newText)
