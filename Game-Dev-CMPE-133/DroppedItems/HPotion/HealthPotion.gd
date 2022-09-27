extends KinematicBody2D

var collected = false
var spawn_distance = 1800
		
func _ready():
	position = get_parent().get_node("Player").position + Vector2(spawn_distance, 0).rotated(rand_range(0, 2*PI))

func _on_Magnet_area_entered(area):
	if (area.get_name() == "PlayerHurtbox"):
		#Come closer to player
		pass


func _on_Health_area_entered(area):
	if (area.get_name() == "PlayerHurtbox"):
		hide()
		queue_free()
