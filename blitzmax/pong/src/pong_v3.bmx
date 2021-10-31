SuperStrict


Type TPong
	Field tile_size: Int
	Field paddle_speed: Int
	
	Field left_paddle: TPaddle
	Field right_paddle: TPaddle
	Field ball: TBall
	Field left_score: TScore
	Field right_score: TScore
	
	
	Method New(tile_size: Int, paddle_speed: Int)
		Self.tile_size = tile_size
		Self.paddle_speed = paddle_speed
		
		left_paddle = New TPaddle(tile_size, tile_size * 3, tile_size, tile_size * 3, paddle_speed, 0, tile_size * 6, KEY_Z, KEY_S)
		right_paddle = New TPaddle(tile_size * 14, tile_size * 3, tile_size, tile_size * 3, paddle_speed, 0, tile_size * 6, KEY_UP, KEY_DOWN)
		ball = New TBall(tile_size * 8 - tile_size / 2, tile_size * 4, tile_size, tile_size, paddle_speed * 1.3, paddle_speed * 1.1, 0, tile_size * 15, 0, tile_size * 8)
		left_score = New TScore(10, 10)
		right_score = New TScore(620, 10)
		
		Graphics(640, 360)
		SetClsColor(51, 152, 75)
	EndMethod
	
	
	Method Start()
		Local gameloop_running: Int = True

		While gameloop_running
			gameloop_running = Not AppTerminate()
			
			Update()
			Draw()
		Wend
	EndMethod
	
	
	Method Update()
		left_paddle.Update()
		right_paddle.Update()
		ball.Update()
		If ball.left_goal
			right_score.Add(1)
		EndIf
		If ball.right_goal
			left_score.Add(1)
		EndIf
		CheckCollisions()
		CheckEndGame()
	EndMethod
	
	
	Method Draw()
		Cls()
		SetColor(0, 152, 220)
		left_paddle.Draw()
		right_paddle.Draw()
		SetColor(255, 200, 37)
		ball.Draw()
		left_score.Draw()
		right_score.Draw()
		Flip()
	EndMethod
	
	
	Method Initialize:Int()
		left_paddle.Initialize()
		right_paddle.Initialize() 
		ball.Initialize(paddle_speed * 1.3, paddle_speed * 1.1) 
		left_score.Initialize()
		right_score.Initialize()
	EndMethod
	
	
	Method CheckCollisions()
		If ball.x + ball.width > left_paddle.x And ball.x < left_paddle.x + left_paddle.width And ball.y + ball.height > left_paddle.y And ball.y < left_paddle.y + left_paddle.height
			ball.x = left_paddle.x + left_paddle.width
			ball.speed_x :* -1
		EndIf
		If ball.x + ball.width > right_paddle.x And ball.x < right_paddle.x + right_paddle.width And ball.y + ball.height > right_paddle.y And ball.y < right_paddle.y + right_paddle.height
			ball.x = right_paddle.x - ball.width
			ball.speed_x :* -1
		EndIf
	EndMethod
	
	
	Method CheckEndGame()
		If left_score.value >= 11 Or right_score.value >= 11
			Initialize()
		EndIf
	EndMethod
EndType


Type TPaddle
	Field x: Float
	Field y: Float
	Field initial_y: Float
	Field width: Int
	Field height: Int
	Field speed: Float
	Field min_y: Float
	Field max_y: Float
	Field key_up: Int
	Field key_down: Int
	
	
	Method New(x: Float, y: Float, width: Int, height: Int, speed: Float, min_y: Float, max_y: Float, key_up: Int, key_down: Int)
		Self.x = x
		Self.y = y
		initial_y = y
		Self.width = width
		Self.height = height
		Self.speed = speed
		Self.min_y = min_y
		Self.max_y = max_y
		Self.key_up = key_up
		Self.key_down = key_down
	EndMethod
	
	
	Method Initialize()
		y = initial_y
	EndMethod
	
	
	Method Update()
		If KeyDown(key_up)
			y :- speed
		EndIf
		If KeyDown(key_down)
			y :+ speed
		EndIf
		If y < min_y
			y = min_y
		EndIf
		If y > max_y
			y = max_y
		EndIf
	EndMethod
	
	
	Method Draw()
		DrawRect(x, y, width, height)
	EndMethod
EndType


Type TBall	
	Field x: Float
	Field y: Float
	Field initial_x: Float
	Field initial_y: Float
	Field width: Int
	Field height: Int
	Field speed_x: Float
	Field speed_y: Float
	Field min_x: Int
	Field max_x: Int
	Field min_y: Int
	Field max_y: Int
	Field left_goal: Int
	Field right_goal: Int
	
	
	Method New(x: Float, y: Float, width: Int, height: Int, speed_x: Float, speed_y: Float, min_x: Float, max_x: Float, min_y: Float, max_y: Float)
		Self.x = x
		Self.y = y
		initial_x = x
		initial_y = y
		Self.width = width
		Self.height = height
		Self.speed_x = speed_x
		Self.speed_y = speed_y
		Self.min_x = min_x
		Self.max_x = max_x
		Self.min_y = min_y
		Self.max_y = max_y
		left_goal = False
		right_goal = False
	EndMethod
	
	
	Method Initialize(speed_x: Float, speed_y: Float)
		x = initial_x
		y = initial_y
		Self.speed_x = speed_x
		Self.speed_y = speed_y
	EndMethod
	
	
	Method Update()
		x :+ speed_x
		y :+ speed_y
		If y < min_y
			y = min_y
			speed_y :* -1
		EndIf
		If y > max_y
			y = max_y
			speed_y :* -1
		EndIf
		left_goal = x < min_x
		If left_goal
			x = initial_x
			y = initial_y
			speed_x :* -1
		EndIf
		right_goal = x > max_x
		If right_goal
			x = initial_x
			y = initial_y
			speed_x :* -1
		EndIf
	EndMethod
	
	
	Method Draw()
		DrawRect(x, y, width, height)
	EndMethod
EndType


Type TScore
	Field value: Int
	Field x: Int
	Field y: Int
	
	
	Method New(x: Int, y: Int)
		value = 0
		Self.x = x
		Self.y = y
	EndMethod
	
	
	Method Initialize()
		value = 0
	EndMethod
	
	
	Method Add(value: Int)
		Self.value :+ value
	EndMethod
	
	
	Method Draw()
		DrawText(String(value), x, y)
	EndMethod
EndType


Function start: Int()
	Local pong: TPong = New TPong(40, 5)
	pong.Start()
EndFunction


start()
