extends Label

onready var player = get_node("../../Player_spaceship")

func _process(delta):

	var newText = player.bullet_damage
	self.text = str(newText)
