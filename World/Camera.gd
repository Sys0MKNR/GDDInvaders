extends Camera2D

var shake_default = 75
var time_default = 0.05
#var tween: Tween = null
var rng = RandomNumberGenerator.new()

func _ready():
	print('lul')
#	tween = create_tween()
	rng.randomize()





func shake(amount: float = shake_default, time: float = time_default, loops: int  = 1):
		
	var tween = create_tween()	
#	var offset = Vector2(rng.randf_range(-1, 1) * amount, rng.randf_range(-1, 1) * amount)
	var _offset = Vector2(1 * amount, rng.randf_range(-1, 1) * amount)
	print(offset)
	tween.tween_property(self, 'offset', _offset , time)
	tween.tween_property(self, 'offset', Vector2(0.0, 0.0) , time)
	tween.tween_callback(test)
	tween.set_loops(loops)
	tween.play() 
	
func test():
	print('callback')




