extends KinematicBody2D

#Add a timer here so at each time different enemies will spawn
func spawn():
	print("Spawned Enemies")
	get_parent().add_child(load("res://Enemies/Skeleton/Skeleton.tscn").instance())
	get_parent().add_child(load("res://Enemies/Bat/Bat.tscn").instance())


func spawn_health():
	print("Spawned Health Potion")
	get_parent().add_child(load("res://DroppedItems/HPotion/HealthPotion.tscn").instance())
