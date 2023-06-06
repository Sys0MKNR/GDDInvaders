extends CharacterBody2D


const SPEED = 300.0
#commented values are closer to unity version, but feel less nice imo
const ACCEL = 1000#270
const FRICTION = 2900#2300.0


@onready var shot_sound = %ShotSound


var in_shoot = false


func _physics_process(delta):
	#input by arrow keys
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x += direction * ACCEL * delta
		velocity.x = clamp(velocity.x,-SPEED,+SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
		
	move_and_slide()

func shoot(): 
	var b = preload("res://Player/bullet.tscn").instantiate()
		
	if not in_shoot:
		in_shoot = true
		var tween = create_tween()

		tween.tween_property(self, "position:y", 16, 0.15).as_relative().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "position:y", -16, 0.10).as_relative()
		tween.tween_callback(on_shot_finished)
	
	shot_sound.play()
	b.global_position = $Muzzle.global_position
	get_tree().current_scene.add_child(b)

func on_shot_finished():
	in_shoot = false
	
