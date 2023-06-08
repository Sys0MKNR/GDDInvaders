extends CanvasLayer


@onready var score = 0 : set = set_score
@onready var direction = Vector2.RIGHT
@onready var score_label = %Score

@onready var loader = %Loader


func set_score(new):
	score = new
	score_label.text = str(score)
	var tween = create_tween()
	tween.tween_property(score_label, "scale", Vector2(1.5, 1.5), 0.2)
	tween.tween_property(score_label, "scale", Vector2(1.0, 1.0), 0.4)
	

func reset(): 
	self.score = 0


