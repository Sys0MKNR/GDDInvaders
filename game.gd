extends Node

var World = preload("res://World/world.tscn")
var world = null

@onready var main_music = %MainMusic
@onready var win_sound = $WinSoundPlayer

func _ready():
	reset()

func reset():
	Hud.reset()
	if world:
		world.queue_free()
		
	world = World.instantiate()

	main_music.play()
	world.connect("won", on_win)
	world.connect("lost", on_lose)
	add_child(world)

func _on_win_screen_restart():
	$WinScreen.visible = false
	reset()


func _on_lose_screen_restart():
	$LoseScreen.visible = false
	reset()

func on_win():
	$WinScreen.visible = true
	win_sound.play()
	round_end()
	
func on_lose(): 
	$LoseScreen.visible = true
	round_end()
	

func round_end():
	$AnimationPlayer.play("game_animations")
	world.disconnect("won", on_win)
	world.disconnect("lost", on_lose)
	


func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'game_animations': 
		main_music.stop()	
		$AnimationPlayer.play("RESET")

	

