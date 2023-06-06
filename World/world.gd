extends Node2D
signal lost
signal won

@onready var player = $Player
@onready var camera = $Camera

var finished = false

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
	

func _ready():
	Hud.direction = Vector2.RIGHT
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
	camera.shake(150, 0.05, 3)
	
func enemy_died(_enemy):
	if finished == true:
		return
		
	camera.shake()
	Hud.score += 1
	if $Enemies.get_children().size() == 1:
		emit_signal("won")
		finished = true


func _on_game_border_enemy_bump():	
	Hud.direction *= -1
	for e in $Enemies.get_children():
		e.turn_around()
