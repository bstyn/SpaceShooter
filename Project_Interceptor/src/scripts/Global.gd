extends Node

var currency : Currency

var Score = 0
var enemyHealth = 3

var _save: SaveGame

func _ready() -> void:
	_create_or_load_save()
	increaseHealth(2)

func increaseHealth(number):
	yield(get_tree().create_timer(300,false), "timeout")
	enemyHealth += number
	increaseHealth(2)

func _create_or_load_save() -> void:
	if SaveGame.save_exists():
		print("Save loaded")
		_save = SaveGame.load_savegame() as SaveGame
	else:
		print("No game save found")
		_save = SaveGame.new()
		
		_save.characterstats = CharacterStats.new()
		_save.currency = Currency.new()
		
		_save.write_savegame()
		
	currency = _save.currency

func _save_game() -> void:
	print("saved")
	_save.write_savegame()
	
