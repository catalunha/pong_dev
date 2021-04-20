extends Node2D

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$BallSprite.position = screen_size*0.5


func _process(delta):
	pass
