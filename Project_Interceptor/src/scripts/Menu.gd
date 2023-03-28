extends Control

func _on_StartButton_pressed():
	get_tree().change_scene("res://src/nodes/MainMenu.tscn")

func _on_Exit_Button_pressed():
	get_tree().quit()
