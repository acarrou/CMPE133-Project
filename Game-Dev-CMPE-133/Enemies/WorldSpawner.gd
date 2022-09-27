extends KinematicBody2D

#Add a timer here so at each time different enemies will spawn
func spawn():
	get_parent().add_child(load("res://Enemies/Skeleton/Skeleton.tscn").instance())
	get_parent().add_child(load("res://Enemies/Bat/Bat.tscn").instance())
