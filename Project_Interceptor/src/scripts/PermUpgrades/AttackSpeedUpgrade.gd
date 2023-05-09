extends Button

onready var price_text =  get_node("Price")

var current_level = 1
var max_level = 10
var price = 50

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
	if upgrades.attack_speed_current_level == upgrades.attack_speed_max_level:
		price_text.text = "MAX"
	else:
		price_text.text = str(upgrades.attack_speed_price)

func _on_AttackSpeed_pressed():
	if Global.currency.coins > upgrades.attack_speed_price and upgrades.attack_speed_current_level < upgrades.attack_speed_max_level:
		stats.attack_speed *= 0.95
		Global.currency.coins -= upgrades.attack_speed_price
		upgrades.attack_speed_current_level += 1
		upgrades.attack_speed_price *= 1.5
		_setPrice()
		Global._save_game()
