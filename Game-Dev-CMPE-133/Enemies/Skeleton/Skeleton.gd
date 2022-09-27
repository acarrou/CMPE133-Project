extends KinematicBody2D

var max_health = 60
onready var current_health = max_health
var spawn_distance = 1800
onready var damage = get_parent().get_node("Player").damage_out
onready var enemies_killed = get_parent().get_node("Player").enemies_killed
var gem_scene = preload("res://DroppedItems/EXP.tscn")
#var gem = load("res://DroppedItems/EXP.tscn").instance()

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
	get_parent().add_child(gem)
	gem.position = position

func check_death():
	if (current_health <= 0):
			enemies_killed += 1
			$AnimatedSprite.stop()
			set_physics_process(false)
			$AnimationPlayer.play("Death")
			EXP_drop()
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

