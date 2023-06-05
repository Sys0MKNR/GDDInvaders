extends CanvasLayer

signal restart

func _ready():
	visible = false

func _on_button_pressed():
	emit_signal("restart")
