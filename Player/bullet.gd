extends Area2D

const SPEED = 300

func _process(delta):
	global_position.y -= SPEED * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	area.die()
	queue_free()
