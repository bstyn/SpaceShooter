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
	if upgrades.exp_multiplie_current_level == upgrades.exp_multiplie_max_level:
		price_text.text = "MAX"
	else:
		price_text.text = str(upgrades.exp_multiplie_price)

func _on_ExpMulti_pressed():
	if Global.currency.coins > upgrades.exp_multiplie_price and upgrades.exp_multiplie_current_level < upgrades.exp_multiplie_max_level:
		stats.exp_multiplier *= 1.25
		Global.currency.coins -= upgrades.exp_multiplie_price
		upgrades.exp_multiplie_current_level += 1
		upgrades.exp_multiplie_price *= 1.5
		_setPrice()
		Global._save_game()
