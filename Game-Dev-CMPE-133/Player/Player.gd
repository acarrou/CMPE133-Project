extends KinematicBody2D

var speed = 300
var maxhealth = 100
var currenthealth = maxhealth
var damage_out = 30
var current_exp = 0
var next_level_exp = 4
var level = 1
var enemies_killed = 0

var velocity = Vector2()
var t = Timer.new()

signal health_changed
signal exp_changed

func _ready():
	add_to_group("Player")
	emit_signal("health_changed", currenthealth, maxhealth)
	emit_signal("exp_changed", current_exp, next_level_exp)

func get_input():
	var v = Vector2.ZERO
	if Input.is_action_pressed("right"):
		v.x += 1
		
	if Input.is_action_pressed("left"):
		v.x -= 1
		
	if Input.is_action_pressed("down"):
		v.y += 1
		
	if Input.is_action_pressed("up"):
		v.y -= 1
		
	return v.normalized()
		
func _physics_process(delta):
	velocity = speed * get_input()
	if (velocity.x or velocity.y != 0):
		$AnimationSprite.animation = "Wizard Running"
		velocity = move_and_slide(velocity)
	else:
		$AnimationSprite.animation = "Wizard Idle"
		
	if (0 < velocity.x):
		$AnimationSprite.flip_h = false
	elif (velocity.x < 0):
		$AnimationSprite.flip_h = true

func shoot():
	add_child(load("res://Weapons&Spells/Bullet.tscn").instance())

func change_exp(value):
	current_exp += value
	while (next_level_exp <= current_exp):
		current_exp -= next_level_exp
		next_level_exp *= 1.50
		level += 1
		
	emit_signal("exp_changed", current_exp, next_level_exp)

func change_health(value):
	currenthealth += value
	emit_signal("health_changed", currenthealth, maxhealth)

func _on_Gem_area_entered(area):
	if (area.get_name() == "Gem"):
		print("Gem Collected")
		#make sound and animation here
		change_exp(18)

func _on_HealthPotion_area_entered(area):
	if (area.get_name() == "Health"):
		change_health(30)

#Needs its own hitbox function
func enemyContact(enemyHitbox):
	if (enemyHitbox.get_name() == "EnemyHurtbox"):
		change_health(-10)
	
	if (currenthealth <= 0):
		$AnimationSprite.stop()
		set_physics_process(false)
		$AnimationSprite.play("Wizard Dying")
		yield($AnimationSprite, "animation_finished")
		hide()
		get_tree().reload_current_scene()


