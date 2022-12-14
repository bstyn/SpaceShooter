extends Popup

onready var player = get_node("../../Player_spaceship")
var selected_menu

func change_menu_color():
	$Resume.color = Color.gray
	$Quit.color = Color.gray
	
	match selected_menu:
		0:
			$Resume.color = Color(94.0/255.0,94.0/255.0,94.0/255.0)
		1:
			$Quit.color = Color(94.0/255.0,94.0/255.0,94.0/255.0)

func _input(event):
	if not visible:
		if Input.is_action_just_pressed("menu"):
			# Pause game
			get_tree().paused = true
			# Reset the popup
			selected_menu = 0
			change_menu_color()
			# Show popup
			if is_instance_valid(player):
				player.set_process_input(false)
			popup()
	else:
		if Input.is_action_just_pressed("ui_down"):
			selected_menu = (selected_menu + 1) % 2;
			change_menu_color()
		elif Input.is_action_just_pressed("ui_up"):
			if selected_menu > 0:
				selected_menu = selected_menu - 1
			else:
				selected_menu = 1
			change_menu_color()
		elif Input.is_action_just_pressed("menu"):
			if get_tree().paused:
					get_tree().paused = false
					hide()
					if is_instance_valid(player):
						player.set_process_input(false)
					
		elif Input.is_action_just_pressed("ui_accept"):
			match selected_menu:
				0:
					# Resume game
					if get_tree().paused:
						hide()
						get_tree().paused = false				
						if is_instance_valid(player):
							player.set_process_input(false)
					
				1:
					# Quit game
					get_tree().quit()
