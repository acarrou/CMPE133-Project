extends KinematicBody2D

export (int) var speed = 300
var velocity = Vector2()

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

func spawn():
	get_parent().add_child(load("res://Enemies/Skeleton/Skeleton.tscn").instance())

func enemyContact(enemyHitbox):
	$DeathAnimationPlayer.play("Death")
	get_tree().reload_current_scene()
