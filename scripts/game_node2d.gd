extends Node2D
const BALL_SPEED = 150

var screen_size
var ball_speed = BALL_SPEED
var ball_direction
var ball_position

func _ready():
	screen_size = get_viewport_rect().size
	$BallSprite.position = screen_size*0.5
	ball_direction = Vector2(1,0)
	ball_position = $BallSprite.position


func _process(delta):
	ball_position += ball_direction * ball_speed * delta
	$BallSprite.position = ball_position
