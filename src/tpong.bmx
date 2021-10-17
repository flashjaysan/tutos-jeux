SuperStrict

Import "tpaddle.bmx"
Import "tball.bmx"
Import "tscore.bmx"


Type TPong
	Private
		Const SCREEN_WIDTH: Int = 640
		Const SCREEN_HEIGHT: Int = 360
		
		Field tile_size: Int
		Field paddle_speed: Int
		
		Field left_paddle: TPaddle
		Field right_paddle: TPaddle
		Field ball: TBall
		Field left_score: TScore
		Field right_score: TScore
	
	
	Public
		Method New(tile_size: Int, paddle_speed: Int)
			Self.tile_size = tile_size
			Self.paddle_speed = paddle_speed
			
			TPaddle.width = tile_size
			TPaddle.height = tile_size * 3
			TPaddle.speed = paddle_speed
			TPaddle.min_y = 0
			TPaddle.max_y = tile_size * 6
			left_paddle = New TPaddle(tile_size, tile_size * 3, KEY_Z, KEY_S)
			right_paddle = New TPaddle(tile_size * 14, tile_size * 3, KEY_UP, KEY_DOWN)
			ball = New TBall(tile_size * 8 - tile_size / 2, tile_size * 4, tile_size, tile_size, paddle_speed * 1.7, 60.0, 0, tile_size * 15, 0, tile_size * 8)
			left_score = New TScore(10, 10)
			right_score = New TScore(620, 10)
			
			AppTitle = "BlitzMaxPong"
			Graphics(SCREEN_WIDTH, SCREEN_HEIGHT)
			SetClsColor(51, 152, 75)
		EndMethod
		
		
		Method Start()
			Local gameloop_running: Int = True
			Local previous_time: Int = MilliSecs()
			Local current_time: Int

			While gameloop_running
				gameloop_running = Not (AppTerminate() Or KeyDown(KEY_ESCAPE))
				
				current_time = MilliSecs()
				Local delta_time: Float = (current_time - previous_time) / 1000.0
				previous_time = current_time
				Update(delta_time)
				Draw()
			Wend
		EndMethod
		
		
		Method Update(delta_time: Float)
			left_paddle.Update(delta_time: Float)
			right_paddle.Update(delta_time: Float)
			ball.Update(delta_time: Float)
			If ball.IsLeftGoal()
				right_score.Add(1)
			EndIf
			If ball.IsRightGoal()
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
		
		
		Method Initialize: Int()
			left_paddle.Initialize()
			right_paddle.Initialize() 
			ball.Initialize(paddle_speed * 1.3, paddle_speed * 1.1) 
			left_score.Initialize()
			right_score.Initialize()
		EndMethod
		
				
		Method CheckCollisions()
			If ball.GetX() + ball.GetWidth() > left_paddle.GetX() And ball.GetX() < left_paddle.GetX() + left_paddle.GetWidth() And ball.GetY() + ball.GetHeight() > left_paddle.GetY() And ball.GetY() < left_paddle.GetY() + left_paddle.GetHeight()
				ball.SetX(left_paddle.GetX() + left_paddle.GetWidth())
				ball.SetSpeedX(-ball.GetSpeedX())
			EndIf
			If ball.GetX() + ball.GetWidth() > right_paddle.GetX() And ball.GetX() < right_paddle.GetX() + right_paddle.GetWidth() And ball.GetY() + ball.GetHeight() > right_paddle.GetY() And ball.GetY() < right_paddle.GetY() + right_paddle.GetHeight()
				ball.SetX(right_paddle.GetX() - ball.GetWidth())
				ball.SetSpeedX(-ball.GetSpeedX())
			EndIf
		EndMethod
		
		
		Method CheckEndGame()
			If left_score.GetValue() >= 11 Or right_score.GetValue() >= 11
				Initialize()
			EndIf
		EndMethod
EndType
