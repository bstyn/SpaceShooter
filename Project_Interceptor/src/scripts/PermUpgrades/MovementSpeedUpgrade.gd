extends Button

onready var price_text =  get_node("Price")

var stats: CharacterStats setget set_stats
var upgrades: Upgrades setget set_upgrades

func set_stats(new_stats: CharacterStats) -> void:
	stats = new_stats
	set_physics_process(stats != null)
	
func set_upgrades(new_upgrades: Upgrades) -> void:
	upgrades = new_upgrades
	set_physics_process(upgrades != null)

func _ready():
	set_stats(Global._save.characterstats)
	set_upgrades(Global._save.upgrades)
	_setPrice()
	
func _setPrice():
	if upgrades.movement_speed_current_level == upgrades.movement_speed_max_level:
		price_text.text = "MAX"
	else:
		price_text.text = str(upgrades.movement_speed_price)

func _on_MovementSpeed_pressed():
	if Global.currency.coins > upgrades.movement_speed_price and upgrades.movement_speed_current_level < upgrades.movement_speed_max_level:
		stats.move_speed += 30
		Global.currency.coins -= upgrades.movement_speed_price
		upgrades.movement_speed_current_level += 1
		upgrades.movement_speed_price *= 1.5
		_setPrice()
		Global._save_game()
