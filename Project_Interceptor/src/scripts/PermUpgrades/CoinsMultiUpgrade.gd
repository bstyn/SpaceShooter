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
	if upgrades.coins_multiplier_current_level == upgrades.coins_multiplier_max_level:
		price_text.text = "MAX"
	else:
		price_text.text = str(upgrades.coins_multiplier_price)

func _on_CoinsMulti_pressed():
	if Global.currency.coins > upgrades.coins_multiplier_price and upgrades.coins_multiplier_current_level < upgrades.coins_multiplier_max_level:
		stats.coins_multiplier *= 1.25
		Global.currency.coins -= upgrades.coins_multiplier_price
		upgrades.coins_multiplier_current_level += 1
		upgrades.coins_multiplier_price *= 1.5
		_setPrice()
		Global._save_game()
