extends Popup

onready var player = get_node("../../Player_spaceship")

func _on_PauseButton_pressed():
	# Pause game
	print(get_tree())
	get_tree().paused = true
	# Show popup
	if is_instance_valid(player):
		player.set_process_input(false)
	popup()


func _on_Resume_pressed():
	if get_tree().paused:
		hide()
		get_tree().paused = false				
		if is_instance_valid(player):
			player.set_process_input(false)


func _on_Restart_pressed():
	if get_tree().paused:
		hide()
		get_tree().paused = false				
		if is_instance_valid(player):
			player.set_process_input(false)
	Global.Score = 0
	get_tree().reload_current_scene()


func _on_Exit_pressed():
	get_tree().quit()
