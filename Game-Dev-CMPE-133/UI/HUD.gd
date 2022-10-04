extends CanvasLayer

export var easing_factor = 10

var healthMax = -1
var healthTarget = -1
var expMax = -1
var expTarget = -1

onready var player = get_node("../YSort/Player")
onready var healthBar = get_node("MarginContainer/HBoxContainer/VBoxContainer2/VBoxContainer/ProgressBar")
onready var expBar = get_node("MarginContainer/HBoxContainer/VBoxContainer2/VBoxContainer/ProgressBar2")

func _ready():
	player.connect("health_changed", self, "_on_health_changed")
	player.connect("exp_changed", self, "_on_exp_changed")

func _on_health_changed(value, max_value):
	healthBar.max_value = max_value if healthMax < 0 else healthBar.max_value
	healthBar.value = value if healthTarget < 0 else healthBar.value
	healthMax = max_value
	healthTarget = value

func _on_exp_changed(value, max_value):
	expBar.max_value = max_value if expMax < 0 else expBar.max_value
	expBar.value = value if expTarget < 0 else expBar.value
	expMax = max_value
	expTarget = value
	
func _physics_process(delta):
	var easing = 1 - exp(-easing_factor * delta)
	healthBar.max_value = lerp(healthBar.max_value, healthMax, easing)
	healthBar.value = lerp(healthBar.value, healthTarget, easing)
	expBar.max_value = lerp(expBar.max_value, expMax, easing)
	expBar.value = lerp(expBar.value, expTarget, easing)
