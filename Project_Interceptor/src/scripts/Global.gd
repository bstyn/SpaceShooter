extends Node

var Score = 0
var enemyHealth = 3

func increaseHealth(number):
	yield(get_tree().create_timer(300,false), "timeout")
	enemyHealth += number
	increaseHealth(2)

func _ready():
	increaseHealth(2)
