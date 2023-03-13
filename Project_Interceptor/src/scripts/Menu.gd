extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus()

func _on_StartButton_pressed():
	get_tree().change_scene("res://src/nodes/MainScene.tscn")


func _on_Exit_Button_pressed():
	get_tree().quit()
