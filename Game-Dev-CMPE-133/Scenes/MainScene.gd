extends Node

# references
onready var scene_loader = get_node("SceneLoader")
onready var main_screen = get_node("MainScreen")
onready var player = get_node("YSort/Player")

# constants
const FADE_TIME = 1

func _on_died():
	scene_loader.change("res://Scenes/TitleScene.tscn", FADE_TIME)

func _ready():
	scene_loader.start(FADE_TIME)
	player.connect("died", self, "_on_died")
