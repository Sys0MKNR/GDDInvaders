extends Area2D


signal hit_plr(enemy)
signal died(enemy)
signal turn_done

const SPEED = 100.0
const DOWN_STEP = 50


@onready var animation = $Animation


func _physics_process(delta):
	var _dist = abs((global_position - get_parent().global_position).x)
	global_position += Hud.direction * SPEED * delta

func _on_body_entered(_body):
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
	animation.play("die")	
	$DieParticle.restart()

	

func turn_around(): 
	if have_died:
		return
	global_position.y += DOWN_STEP
	if Hud.direction.x == 1:
		animation.play('left')
	else: 
		animation.play("right")


func _on_animation_animation_finished(anim_name):
	if anim_name == 'die': 
		queue_free()

