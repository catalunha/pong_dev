extends Node2D
const BALL_SPEED = 150
const PLAYER_SPEED = 80

var screen_size
var ball_speed = BALL_SPEED
var ball_direction
var ball_position

func _ready():
	screen_size = get_viewport_rect().size
	$BallSprite.position = screen_size*0.5
	ball_direction = Vector2(-1,0)
	ball_position = $BallSprite.position

func _process(delta):
	# A bola inicia seu movimento na direção definida no _ready()
	ball_position += ball_direction * ball_speed * delta
	
	# Se a bola tocar no top ou embaixo volta ao campo
	if(ball_position.y < 0 or ball_position.y > screen_size.y):
		ball_direction.y = -ball_direction.y

	# Se a bola tocar na esq ou dir acaba a partida
	if(ball_position.x < 0 or ball_position.x > screen_size.x):
		ball_position = screen_size * 0.5
		ball_direction = Vector2(randf()*2.0-1,0).normalized()
		ball_speed = BALL_SPEED
	
	# movimentar player da direita
	var player_right_position = $PlayerRightSprite.position
	if(Input.is_action_pressed("ui_up") and player_right_position.y > 0):
		player_right_position.y += -PLAYER_SPEED * delta
	if(Input.is_action_pressed("ui_down") and player_right_position.y < screen_size.y):
		player_right_position.y += PLAYER_SPEED * delta
	$PlayerRightSprite.position = player_right_position

	# movimentar player da esquerda
	var player_left_position = $PlayerLeftSprite.position
	if(Input.is_action_pressed("ui_w") and player_left_position.y > 0):
		player_left_position.y += -PLAYER_SPEED * delta
	if(Input.is_action_pressed("ui_s") and player_left_position.y < screen_size.y):
		player_left_position.y += PLAYER_SPEED * delta
	$PlayerLeftSprite.position = player_left_position

	
	$BallSprite.position = ball_position
