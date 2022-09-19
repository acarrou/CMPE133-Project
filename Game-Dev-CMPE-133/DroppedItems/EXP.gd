extends Area2D


export (int) var exp_amount = 50
var item_name
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	item_name = "EXP"

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body.name.find("Player") != -1 and self.visible:
			emit_signal("body_entered", self)
			self.hide()
