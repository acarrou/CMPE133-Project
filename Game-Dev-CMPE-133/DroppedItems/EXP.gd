extends KinematicBody2D

var collected = false
var spawn_distance = 0
		
#func physics_process():
	#move_and_slide((get_parent().get_node("Player").position - position).normalized() * $AnimatedSprite.speed_scale*2)

func _on_Magnet_area_entered(area):
	if (area.get_name() == "PlayerHurtbox"):
		#Come closer to player
		pass


func _on_Gem_area_entered(area):
	if (area.get_name() == "PlayerHurtbox"):
		hide()
		queue_free()
