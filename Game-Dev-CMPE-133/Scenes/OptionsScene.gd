extends Node

# references
onready var scene_loader = get_node("SceneLoader")
onready var options_screen = get_node("OptionsScreen")

# constants
const FADE_TIME = .5

func _on_exit_pressed():
	scene_loader.change("res://Scenes/TitleScene.tscn", FADE_TIME)

func _ready():
	scene_loader.start(FADE_TIME)
	
	var exit_button = options_screen.get_node("Button")
	exit_button.connect("pressed", self, "_on_exit_pressed")
