extends Node

var World = preload("res://World/world.tscn")
var world = null

func _ready():
	reset()

func reset():
	Hud.reset()
	if world:
		world.queue_free()
	world = World.instantiate()
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
	world.disconnect("won", on_win)
	world.disconnect("lost", on_lose)
func on_lose(): 
	$LoseScreen.visible = true
	world.disconnect("won", on_win)
	world.disconnect("lost", on_lose)
	
