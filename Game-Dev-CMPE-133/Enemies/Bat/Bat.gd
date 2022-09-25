extends KinematicBody2D

var max_health = 60
onready var current_health = max_health
var spawn_distance = 1800
onready var gem = preload("res://DroppedItems/EXP.tscn")
onready var damage = get_parent().get_node("Player").damage_out
onready var Player = get_parent().get_node("Player")

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
	pass
	get_parent().add_child(load("res://Enemies/Skeleton/Skeleton.tscn").instance())
	get_parent().add_child(load("res://Enemies/Bat/Bat.tscn").instance())

func _on_Hurtbox_area_entered(area):
	if (area.name == "Player"):
		print("Player Entered")
	else:
		current_health -= damage
		$AnimatedSprite.play("Hurt")
		yield($AnimatedSprite, "animation_finished")
		$AnimatedSprite.play("Flight")
		print("Ouch!")
		if (current_health <= 0):
			$AnimatedSprite.stop()
			set_physics_process(false)
			$AnimatedSprite.play("Death")
			yield($AnimatedSprite, "animation_finished")
			hide()
			queue_free()

