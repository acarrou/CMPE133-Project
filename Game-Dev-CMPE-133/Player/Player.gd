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
onready var HealthBar = $HealthBar
onready var ExpBar = $ExpBar


func _ready():
	add_to_group("Player")
	ExpBar.max_value = next_level_exp
	ExpBar.value = current_exp
	HealthBar.max_value = maxhealth

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		$AnimationSprite.flip_h = false
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		$AnimationSprite.flip_h = true
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
		
func _physics_process(delta):
	get_input()
	if (velocity.x or velocity.y != 0):
		$AnimationSprite.animation = "Wizard Running"
		velocity = move_and_slide(velocity)
	else:
		$AnimationSprite.animation = "Wizard Idle"

func shoot():
	add_child(load("res://Weapons&Spells/Bullet.tscn").instance())

func _on_Gem_area_entered(area):
	if (area.get_name() == "Gem"):
		print("Gem Collected")
		#make sound and animation here
		current_exp += 1
		ExpBar.value = current_exp
		if (current_exp >= next_level_exp):
			var over_exp = current_exp - next_level_exp
			level += 1
			print("Player leveled up!")
			print("Level ", level)
			current_exp = over_exp
			next_level_exp *= 1.50
			ExpBar.max_value = next_level_exp
			
func _on_HealthPotion_area_entered(area):
	if (area.get_name() == "Health"):
		currenthealth += 30
		HealthBar.value = currenthealth


#Needs its own hitbox function
func enemyContact(enemyHitbox):
	if (enemyHitbox.get_name() == "EnemyHurtbox"):
		currenthealth -= 10
		HealthBar.value = currenthealth
	
	if (currenthealth <= 0):
		$AnimationSprite.stop()
		set_physics_process(false)
		$AnimationSprite.play("Wizard Dying")
		yield($AnimationSprite, "animation_finished")
		hide()
		get_tree().reload_current_scene()


