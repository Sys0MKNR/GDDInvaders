extends TextureProgressBar

var tween: Tween



func start():
	visible = true
	tween = create_tween()
	tween.tween_property(self, "value", 100, 2)
#	tween.tween_property(self, "value", 0, 0.5)
	tween.set_loops()

	
	
func stop():
	visible = false
	tween.stop()
	
