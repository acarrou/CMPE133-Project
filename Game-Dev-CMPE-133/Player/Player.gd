extends KinematicBody2D

var speed = 300
var max_health = 100
var current_health = max_health
var damage_out = 30
var current_exp = 0
var next_level_exp = 4
var level = 1
var enemies_killed = 0

var velocity = Vector2.ZERO
var t = Timer.new()

signal health_changed
signal exp_changed
signal died

func _ready():
	add_to_group("Player")
	emit_signal("exp_changed", current_exp, next_level_exp, level)
	emit_signal("health_changed", current_health, max_health)

func change_exp(value):
	current_exp += value
	while (next_level_exp <= current_exp):
		current_exp -= next_level_exp
		next_level_exp *= 1.50
		level += 1
	
	emit_signal("exp_changed", current_exp, next_level_exp, level)

func change_health(value):
	current_health = clamp(current_health + value, 0, max_health)
	emit_signal("health_changed", current_health, max_health)

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
	var bullet = load("res://Weapons&Spells/Bullet.tscn").instance()
	add_child(bullet)

func _on_Gem_area_entered(area):
	if (area.get_name() == "Gem"):
		print("Gem Collected")
		#make sound and animation here
		change_exp(18)

func _on_HealthPotion_area_entered(area):
	if (area.get_name() == "Health"):
		change_health(30)

#Needs its own hitbox function
func enemyContact(hitbox):
	if (hitbox.get_name() == "EnemyHurtbox"):
		change_health(-10)
	
	if (current_health <= 0):
		$AnimationSprite.stop()
		set_physics_process(false)
		$AnimationSprite.play("Wizard Dying")
		yield($AnimationSprite, "animation_finished")
		hide()
		emit_signal("died")
