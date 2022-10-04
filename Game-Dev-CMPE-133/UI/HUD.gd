extends CanvasLayer

export var easing_factor = 10

var healthTarget = [-1, -1]
var expTarget = [-1, -1]

onready var player = get_node("../YSort/Player")
onready var healthBar = get_node("MarginContainer/HBoxContainer/VBoxContainer2/VBoxContainer/ProgressBar")
onready var expBar = get_node("MarginContainer/HBoxContainer/VBoxContainer2/VBoxContainer/ProgressBar2")

func _ready():
	player.connect("health_changed", self, "_on_health_changed")
	player.connect("exp_changed", self, "_on_exp_changed")

func _on_health_changed(value, max_value):
	# initialization
	if (healthTarget[1] < 0):
		healthBar.max_value = max_value
		healthBar.value = value
	
	# set target
	healthTarget[1] = max_value
	healthTarget[0] = value

func _on_exp_changed(value, max_value):
	# initialization
	if (expTarget[1] < 0):
		expBar.max_value = max_value
		expBar.value = value
	
	# set target
	expTarget[1] = max_value
	expTarget[0] = value
	
func _physics_process(delta):
	var easing = 1 - exp(-easing_factor * delta)
	healthBar.max_value = lerp(healthBar.max_value, healthTarget[1], easing)
	healthBar.value = lerp(healthBar.value, healthTarget[0], easing)
	expBar.max_value = lerp(expBar.max_value, expTarget[1], easing)
	expBar.value = lerp(expBar.value, expTarget[0], easing)
