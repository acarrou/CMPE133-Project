extends Node2D

var max_health = 30
var current_health = max_health
var weapon_damage = 15

func enemyHit(area: Area2D):
	#var enemy_health = area.get_node(".")
	current_health -= weapon_damage
	#area.get_parent().get_node("AnimationPlayer").play("Hurt") #Put hurt animation here
	if(current_health <= 0):
		area.get_parent().get_node("AnimationPlayer").play("Death")
