extends KinematicBody2D

export (int) var speed = 300
export (int) var maxhealth = 100
export (int) var currenthealth = maxhealth

var velocity = Vector2()
var t = Timer.new()
onready var HealthBar = $HealthBar
onready var ExpBar = $ExpBar

func ready():
	add_to_group("Player")
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

func enemyContact(enemyHitbox):
	currenthealth -= 10
	HealthBar.value = currenthealth
	
	if (currenthealth <= 0):
		$AnimationSprite.stop()
		set_physics_process(false)
		$AnimationSprite.play("Wizard Dying")
		yield($AnimationSprite, "animation_finished")
		hide()
		get_tree().reload_current_scene()
