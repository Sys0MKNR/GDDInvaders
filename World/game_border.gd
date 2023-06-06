extends Area2D

signal enemy_bump

#this is used so in one frame only one 
#turn will be detected. this prevents multiple
#enemies from bumping in the same frame and swapping 
#the direction multiple
var already_triggered = false

#must be an enemy
func _on_area_entered(_area):
	if already_triggered:
		return
	emit_signal("enemy_bump")
	already_triggered = true
	set_deferred("already_triggered",false)
