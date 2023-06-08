extends Area2D

signal enemy_bump

@onready var border = $Border

#this is used so in one frame only one 
#turn will be detected. this prevents multiple
#enemies from bumping in the same frame and swapping 
#the direction multiple
var already_triggered = false

#must be an enemy
func _on_area_entered(_area):
	if already_triggered:
		return
		
	var tween = create_tween()
	
	
	border.material.set_shader_parameter('width', 0.01)
	tween.tween_interval(0.2).finished.connect(border.material.set_shader_parameter.bind('width', 0.005))
	

	
	emit_signal("enemy_bump")
	already_triggered = true
	set_deferred("already_triggered",false)

