extends Node2D

const BALL_SPEED = 150
const PLAYER_SPEED = 80

var screen_size
var ball_speed = BALL_SPEED
var ball_direction
var ball_position

var player_size

var player_left_goal = 0
var player_right_goal = 0

func _ready():
	screen_size = get_viewport_rect().size
	$BallSprite.position = screen_size*0.5
	ball_direction = Vector2(-1,0)
	ball_position = $BallSprite.position
	player_size = $PlayerLeftSprite.get_texture().get_size()
	randomize()

func _process(delta):
	# a bola inicia seu movimento partindo da posição atual, 
	# na direção definida e com a velocidade estimada. 
	# ajustando tudo com delta
	ball_position += ball_direction * ball_speed * delta

	player_left_moving(delta)
#	# movimentar player da direita

	player_right_moving(delta)
#	# movimentar player da esquerda

#	# Se a bola tocar no top ou embaixo volta ao campo
	if(ball_position.y < 0 or ball_position.y > screen_size.y):
		ball_touch_up_down()


#	# Se a bola tocar na esq ou dir, marca gol e reinicia a partida
	if(ball_position.x < 0 or ball_position.x > screen_size.x):
		ball_touch_left_right_goal()
		ball_touch_left_right()

#	# Criando um retangulo envolta dos players
	var player_left_rect2 = Rect2($PlayerLeftSprite.position-player_size/2,player_size)
	var player_right_rect2 = Rect2($PlayerRightSprite.position-player_size*0.5,player_size)
	if (player_right_rect2.has_point(ball_position) or player_left_rect2.has_point(ball_position)):
		ball_touch_player()

	# Depois das atualizações devidas movimenta o sprite
	$BallSprite.position = ball_position


func player_left_moving(delta):
	# movimentar player da esquerda
	var player_right_position = $PlayerRightSprite.position
	if(Input.is_action_pressed("ui_up") and player_right_position.y > 0):
		player_right_position.y += -PLAYER_SPEED * delta
	if(Input.is_action_pressed("ui_down") and player_right_position.y < screen_size.y):
		player_right_position.y += PLAYER_SPEED * delta
	$PlayerRightSprite.position = player_right_position

func player_right_moving(delta):
	# movimentar player da direita
	var player_left_position = $PlayerLeftSprite.position
	if(Input.is_action_pressed("ui_w") and player_left_position.y > 0):
		player_left_position.y += -PLAYER_SPEED * delta
	if(Input.is_action_pressed("ui_s") and player_left_position.y < screen_size.y):
		player_left_position.y += PLAYER_SPEED * delta
	$PlayerLeftSprite.position = player_left_position

func ball_touch_up_down():
	# Se a bola tocar no top ou embaixo volta ao campo
	ball_direction.y = -1 * ball_direction.y

func ball_touch_left_right():
	# Se a bola tocar na esq ou dir acaba a partida
	ball_position = screen_size * 0.5
	ball_direction = Vector2(randf()*2.0-1,0).normalized()
	ball_speed = BALL_SPEED

func ball_touch_left_right_goal():
	if ball_position.x < 0 :
		player_right_goal += 1
		$UHDNode/PlayerRightGoalLabel.text = str(player_right_goal)
	if ball_position.x > screen_size.x :
		player_left_goal += 1
		$UHDNode/PlayerLeftGoalLabel.text = str(player_left_goal)

func ball_touch_player():
		ball_speed *= 1.1
		ball_direction.x *= -1
		ball_direction.y = randf()*2.0-1
		ball_direction = ball_direction.normalized()
