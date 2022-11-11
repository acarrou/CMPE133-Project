extends Node

# references
onready var scene_loader = get_node("SceneLoader")
onready var title_screen = get_node("TitleScreen")

# constants
const FADE_TIME = .5

func _on_play_pressed():
	scene_loader.change("res://Scenes/MainScene.tscn", FADE_TIME)

func _on_options_pressed():
	scene_loader.change("res://Scenes/OptionsScene.tscn", FADE_TIME)
	
func _ready():
	scene_loader.start(FADE_TIME)
	
	var play_button = title_screen.get_node("VBoxContainer/Button")
	play_button.connect("pressed", self, "_on_play_pressed")
	
	var options_button = title_screen.get_node("VBoxContainer/Button2")
	options_button.connect("pressed", self, "_on_options_pressed")
