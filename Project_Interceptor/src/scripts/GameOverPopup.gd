extends Popup

func _on_GameOverButton_pressed():
	get_tree().change_scene("res://src/nodes/MainMenu.tscn")
