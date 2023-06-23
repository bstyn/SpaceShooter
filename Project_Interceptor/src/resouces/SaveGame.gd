class_name SaveGame
extends Resource

const SAVE_GAME_BASE_PATH := "user://save"

export var version := 1

export var characterstats: Resource
export var currency: Resource
export var upgrades: Resource

func write_savegame() -> void:
	ResourceSaver.save(get_save_path(), self)


static func save_exists() -> bool:
	return ResourceLoader.exists(get_save_path())


static func load_savegame() -> Resource:
	var save_path := get_save_path()
	return ResourceLoader.load(save_path, "", true)

static func make_random_path() -> String:
	return "user://temp_file_" + str(randi()) + ".tres"

static func get_save_path() -> String:
	var extension := ".tres" if OS.is_debug_build() else ".res"
	return SAVE_GAME_BASE_PATH + extension
