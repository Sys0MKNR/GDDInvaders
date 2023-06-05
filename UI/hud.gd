extends CanvasLayer


@onready var score = 0 : set = set_score
@onready var direction = Vector2.RIGHT
@onready var score_label = %Score


func set_score(new):
	score = new
	score_label.text = str(score)

func reset(): 
	self.score = 0
