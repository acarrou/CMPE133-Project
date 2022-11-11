extends CanvasLayer

# references
onready var blackout = get_node("ColorRect")

# variables
var fade_mode = 0
var is_busy = false
var scene = ""

func start(t):
	fade_mode = -t

func change(path, dt):
	if not is_busy:
		is_busy = true
		scene = path
		fade_mode = dt

func _physics_process(delta):
	if fade_mode != 0:
		var value = delta / fade_mode
		blackout.modulate.a = clamp(blackout.modulate.a + value, 0, 1)
		if blackout.modulate.a == 1:
			get_tree().change_scene(scene)
