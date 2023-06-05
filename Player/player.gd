extends CharacterBody2D


const SPEED = 300.0
#commented values are closer to unity version, but feel less nice imo
const ACCEL = 1000#270
const FRICTION = 2900#2300.0

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
	b.global_position = $Muzzle.global_position
	get_tree().current_scene.add_child(b)
