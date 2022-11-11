extends CanvasLayer

# references
onready var blackout = get_node("ColorRect")

# variables
var fade_mode = 0
var is_busy = false

# signals
signal fade

func fade(t):
	fade_mode = t

func _ready():
	connect("fade", self, "_on_fade")

func _physics_process(delta):
	if fade_mode == 0:
		return
	
	var value = delta / fade_mode
	blackout.modulate.a = clamp(blackout.modulate.a + value, 0, 1)
	
	var state = 0 < blackout.modulate.a and blackout.modulate.a < 1
	if state == false and is_busy != state:
		emit_signal("fade", self)
	
	is_busy = state
