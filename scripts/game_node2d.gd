extends Node2D
const BALL_SPEED = 150

var screen_size
var ball_speed = BALL_SPEED
var ball_direction
var ball_position

func _ready():
	screen_size = get_viewport_rect().size
	$BallSprite.position = screen_size*0.5
	ball_direction = Vector2(0,-1)
	ball_position = $BallSprite.position

func _process(delta):
	# A bola inicia seu movimento na direção definida no _ready()
	ball_position += ball_direction * ball_speed * delta
	
	# Se a bola tocar no top ou embaixo volta ao campo
	if(ball_position.y < 0 or ball_position.y > screen_size.y):
		ball_direction.y = -ball_direction.y

	$BallSprite.position = ball_position
