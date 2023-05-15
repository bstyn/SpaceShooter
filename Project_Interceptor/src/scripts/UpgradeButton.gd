extends TextureButton

func _on_UpgradeButton_pressed():
	get_tree().change_scene("res://src/nodes/Scenes/UpgradeScene.tscn")
