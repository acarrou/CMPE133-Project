extends KinematicBody2D

var max_health = 60
onready var current_health = max_health
var spawn_distance = 1800
onready var damage = get_parent().get_node("Player").damage_out
var gem_scene = preload("res://DroppedItems/EXP.tscn")
var gem = load("res://DroppedItems/EXP.tscn").instance()

func _ready():
	position = get_parent().get_node("Player").position + Vector2(spawn_distance, 0).rotated(rand_range(0, 2*PI))

func _physics_process(delta):
	check_death()
	move_and_slide((get_parent().get_node("Player").position - position).normalized() * $AnimatedSprite.speed_scale*2 / delta)
	
	if (position > get_parent().get_node("Player").position):
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
		
func EXP_drop():
	print("Creating Gem")
	var gem = gem_scene.instance()
	#TODO Get Tree Node so you don't need to add a gem in the Main Map
	get_parent().get_node("EXP").call_deferred("add_child", gem)
	gem.position = position

func check_death():
	if (current_health <= 0):
			EXP_drop()
			$AnimatedSprite.stop()
			set_physics_process(false)
			$AnimationPlayer.play("Death")
			yield($AnimatedSprite, "animation_finished")
			hide()
			queue_free()

#Add a timer here so at each time different enemies will spawn

func _on_Hurtbox_area_entered(area):
	if (area.get_name() == "Fireball"):
		current_health -= damage
		$AnimatedSprite.play("Hurt")
		yield($AnimatedSprite, "animation_finished")
		$AnimatedSprite.play("Walking")

