extends Node2D
signal lost
signal won

@onready var player = $Player
@onready var camera = $Camera
@onready var explosion_enemy = $ExplosionEnemy
@onready var explosion_player = $ExplosionPlayer
@onready var mega_explosion = $MegaExplosion

var timer = Timer.new()

var finished = false
var draw_count = 0
var first = true

var Enemy = preload("res://Enemy/enemy.tscn")
func spawn_enemies():
	var pos = Vector2(0,0)
	var enemy_size = Vector2(32,32)
	var space = Vector2(32,32)
	for i in 4:
		for j in 14:
			var e = Enemy.instantiate()
			$Enemies.add_child(e)
			e.position = pos
			
			pos.x += enemy_size.x + space.x
		pos.x = 0
		pos.y += enemy_size.y + space.y
	

func init(first_val):
	first = first_val

func _ready():
	if first: 
		Hud.loader.start()
		modulate = Color(.0,.0,.0,.0)
		mega_explosion.restart()
		timer.one_shot = true
		timer.wait_time = 2
		timer.autostart = true
		timer.connect('timeout', on_loaded)
		add_child(timer)
	
	else:
		start_round()
	

	

func on_loaded():
	modulate = Color(1.0,1.0,1.0,1.0)
	Hud.loader.stop()
	start_round()

	

func start_round():
	Hud.direction = Vector2.RIGHT
	player.set_physics_process(true)
	spawn_enemies()
	connect_enemies()
	


func connect_enemies():
	for e in $Enemies.get_children():
		e.connect("hit_plr",plr_hit)
		e.connect("died",enemy_died)

func plr_hit(_enemy):
	if finished == true:
		return
		
	finished = true
	emit_signal("lost")
	
	player.set_physics_process(false)
	explosion_player.play()
	mega_explosion.position = player.position
	mega_explosion.restart()
	var tween = create_tween()	
	tween.tween_property(player, 'scale', Vector2(0.0, 0.0), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)

	
	camera.shake(150, 0.05, 3)
	
func enemy_died(_enemy):
	if finished == true:
		return
	
	explosion_enemy.play()
	camera.shake()
	Hud.score += 1
	if $Enemies.get_children().size() == 1:
		emit_signal("won")
		finished = true


func _on_game_border_enemy_bump():	
	camera.shake()
	Hud.direction *= -1
	for e in $Enemies.get_children():
		e.turn_around()
