extends KinematicBody2D

var max_health = 60
onready var current_health = max_health
var spawn_distance = 1800
onready var gem = preload("res://DroppedItems/EXP.tscn")
onready var damage = get_parent().get_node("Player").damage_out

func _ready():
	position = get_parent().get_node("Player").position + Vector2(spawn_distance, 0).rotated(rand_range(0, 2*PI))

func _physics_process(delta):
	move_and_slide((get_parent().get_node("Player").position - position).normalized() * $AnimatedSprite.speed_scale*2 / delta)
	
	if (position > get_parent().get_node("Player").position):
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false

#Add a timer here so at each time different enemies will spawn
func spawn():
	get_parent().add_child(load("res://Enemies/Skeleton/Skeleton.tscn").instance())
	get_parent().add_child(load("res://Enemies/Bat/Bat.tscn").instance())
