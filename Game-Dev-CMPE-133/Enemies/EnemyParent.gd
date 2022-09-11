extends KinematicBody2D

var spawn_distance = 1800

func _ready():
	position = get_parent().get_node("Player").position + Vector2(spawn_distance, 0).rotated(rand_range(0, 2*PI))

func _physics_process(delta):
	move_and_slide((get_parent().get_node("Player").position - position).normalized() * $AnimatedSprite.speed_scale*2 / delta)
	
	if (position > get_parent().get_node("Player").position):
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
