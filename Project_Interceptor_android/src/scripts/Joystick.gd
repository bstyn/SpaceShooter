extends Area2D

onready var big_analog = $BigAnalog
onready var small_analog = $BigAnalog/SmallAnalog

onready var max_distance = $CollisionShape2D.shape.radius

var touched = false

func _input(event):
	if event is InputEventScreenTouch:
		var distance = event.position.distance_to(big_analog.global_position)
		if not touched and distance < max_distance:
				touched = true
				big_analog.get_node("Hidden").hide()
				big_analog.get_node("Shown").show()
				small_analog.get_node("Hidden").hide()
				small_analog.get_node("Shown").show()
		else:
			small_analog.position = Vector2(0,0)
			touched = false
			big_analog.get_node("Hidden").show()
			big_analog.get_node("Shown").hide()
			small_analog.get_node("Hidden").show()
			small_analog.get_node("Shown").hide()
			
func _process(delta):
	if touched:
		small_analog.global_position = get_global_mouse_position()
		small_analog.position = big_analog.position + (small_analog.position - big_analog.position).clamped(max_distance)
		
func get_velo():
	var analog_vel = Vector2(0,0)
	analog_vel.x = small_analog.position.x / max_distance
	analog_vel.y = small_analog.position.y / max_distance
	return analog_vel
