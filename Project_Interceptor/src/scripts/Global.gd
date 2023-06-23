extends Node

var currency : Currency
var upgrades : Upgrades

#TEMP
var Score = 0
var enemyHealth = 3
var lvl = 1
var experience = 0
var max_experience = 12
var spawn_number = 1


var _save: SaveGame

func _ready() -> void:
	_create_or_load_save()


func increaseHealth(number):
	yield(get_tree().create_timer(60,false), "timeout")
	enemyHealth += number
	increaseHealth(2)
	
func increaseSpawn(number):
	yield(get_tree().create_timer(120,false), "timeout")
	spawn_number += number
	increaseSpawn(number)
	

func _create_or_load_save() -> void:
	if SaveGame.save_exists():
		_save = SaveGame.load_savegame() as SaveGame
	else:
		_save = SaveGame.new()
		
		_save.characterstats = CharacterStats.new()
		_save.currency = Currency.new()
		_save.upgrades = Upgrades.new()
		
		_save.write_savegame()
		
	currency = _save.currency
	upgrades = _save.upgrades

func _save_game() -> void:
	_save.write_savegame()
	
