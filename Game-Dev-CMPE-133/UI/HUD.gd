extends CanvasLayer

onready var player = get_node("../YSort/Player")
onready var healthBar = get_node("MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer/ProgressBar")
onready var expBar = get_node("MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer/ProgressBar2")

func _ready():
	player.connect("health_changed", self, "_on_health_changed")
	player.connect("exp_changed", self, "_on_exp_changed")

func _on_health_changed(value, max_value):
	healthBar.max_value = max_value
	healthBar.value = value

func _on_exp_changed(value, max_value):
	expBar.max_value = max_value
	expBar.value = value
