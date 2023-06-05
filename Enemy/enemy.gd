extends Area2D


signal hit_plr(enemy)
signal died(enemy)
signal turn_done

const SPEED = 100.0
const DOWN_STEP = 50



func _physics_process(delta):
	var dist = abs((global_position - get_parent().global_position).x)
	global_position += Hud.direction * SPEED * delta

func _on_body_entered(body):
	emit_signal("hit_plr",self)

#prevents double death in case of bullet overlap
#imo bullets should have a cooldown and therefore would
#never overlap but ok
var have_died = false
func die():
	if have_died:
		return
	have_died = true
	emit_signal("died",self)
	queue_free()

func turn_around(): 
	global_position.y += DOWN_STEP
