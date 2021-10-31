SuperStrict


Function pong: Int()

	Local tile_size: Int = 40
	Local paddle_speed: Float = 5

	Local left_paddle_x: Float = tile_size
	Local left_paddle_y: Float = tile_size * 3

	Local right_paddle_x: Float = tile_size * 14 
	Local right_paddle_y: Float = tile_size * 3

	Local ball_x: Float = tile_size * 8 - tile_size / 2
	Local ball_y: Float = tile_size * 4
	Local ball_speed_x: Float = paddle_speed * 1.3
	Local ball_speed_y: Float = paddle_speed * 1.1

	Local left_score: Int = 0
	Local right_score: Int = 0
	Local left_score_x: Int = 10
	Local right_score_x: Int = 620
	Local score_y: Int = 10

	Graphics(640, 360)

	SetClsColor(51, 152, 75)

	Local gameloop_running: Int = True

	While gameloop_running
		gameloop_running = Not AppTerminate()
		
		update(left_paddle_x,
		       left_paddle_y,
		       right_paddle_x,
		       right_paddle_y,
		       paddle_speed,
		       tile_size,
		       ball_x,
		       ball_y,
		       ball_speed_x,
		       ball_speed_y,
		       right_score,
		       left_score)
		draw(left_paddle_x,
		     left_paddle_y,
		     right_paddle_x,
		     right_paddle_y,
		     tile_size,
		     ball_x,
		     ball_y,
		     left_score,
		     left_score_x,
		     right_score,
		     right_score_x,
		     score_y)
	Wend
EndFunction


Function update:Int(left_paddle_x: Float,
		            left_paddle_y: Float Var,
		            right_paddle_x: Float,
		            right_paddle_y: Float Var,
		            paddle_speed: Float,
		            tile_size: Int,
		            ball_x: Float Var,
		            ball_y: Float Var,
		            ball_speed_x: Float Var,
		            ball_speed_y: Float Var,
		            right_score: Int Var,
		            left_score: Int Var)
	move_left_paddle(left_paddle_y, paddle_speed, tile_size)
	move_right_paddle(right_paddle_y, paddle_speed, tile_size)
	move_ball(ball_x,
	          ball_y,
	          ball_speed_x,
	          ball_speed_y,
	          tile_size,
	          left_score,
	          right_score,
	          left_paddle_x,
	          left_paddle_y,
	          right_paddle_x,
	          right_paddle_y)
	
	If left_score >= 11 Or right_score >= 11
		initialize(left_paddle_y,
		           right_paddle_y,
		           ball_x,
		           ball_y,
		           ball_speed_x,
		           ball_speed_y,
		           tile_size,
		           paddle_speed,
		           left_score,
		           right_score)
	EndIf
EndFunction


Function draw:Int(left_paddle_x: Float,
		     left_paddle_y: Float,
		     right_paddle_x: Float,
		     right_paddle_y: Float,
		     tile_size: Int,
		     ball_x: Float,
		     ball_y: Float,
		     left_score: Int,
		     left_score_x: Int,
		     right_score: Int,
		     right_score_x: Int,
		     score_y: Int)
	Cls()
	SetColor(0, 152, 220)
	draw_left_paddle:Int(left_paddle_x, left_paddle_y, tile_size)
	draw_right_paddle:Int(right_paddle_x, right_paddle_y, tile_size)
	SetColor(255, 200, 37)
	draw_ball:Int(ball_x, ball_y, tile_size)
	draw_left_score:Int(left_score, left_score_x, score_y)
	draw_right_score:Int(right_score, right_score_x, score_y)
	Flip()
EndFunction


Function move_left_paddle(left_paddle_y: Float Var,
                          paddle_speed: Float,
                          tile_size: Int)
	If KeyDown(KEY_Z)
		left_paddle_y :- paddle_speed
	EndIf
	If KeyDown(KEY_S)
		left_paddle_y :+ paddle_speed
	EndIf
	If left_paddle_y < 0
		left_paddle_y = 0
	EndIf
	If left_paddle_y > tile_size * 6
		left_paddle_y = tile_size * 6
	EndIf	
EndFunction


Function move_right_paddle(right_paddle_y: Float Var,
                          paddle_speed: Float,
                          tile_size: Int)
	If KeyDown(KEY_UP)
		right_paddle_y :- paddle_speed
	End If
	If KeyDown(KEY_DOWN)
		right_paddle_y :+ paddle_speed
	EndIf
	If right_paddle_y < 0
		right_paddle_y = 0
	EndIf
	If right_paddle_y > tile_size * 6
		right_paddle_y = tile_size * 6
	EndIf
EndFunction


Function move_ball(ball_x: Float Var,
                   ball_y: Float Var,
                   ball_speed_x: Float Var,
                   ball_speed_y: Float Var,
                   tile_size: Int,
                   left_score: Int Var,
                   right_score: Int Var,
                   left_paddle_x: Float,
                   left_paddle_y: Float,
                   right_paddle_x: Float,
                   right_paddle_y: Float)
	ball_x :+ ball_speed_x
	ball_y :+ ball_speed_y
	If ball_y < 0
		ball_y = 0
		ball_speed_y :* -1
	EndIf
	If ball_y > tile_size * 8
		ball_y = tile_size * 8
		ball_speed_y :* -1
	EndIf
	If ball_x < 0
		ball_x = tile_size * 8 - tile_size / 2
		ball_y = tile_size * 4
		ball_speed_x :* -1
		right_score :+ 1
	EndIf
	If ball_x > tile_size * 15
		ball_x = tile_size * 8 - tile_size / 2
		ball_y = tile_size * 4
		ball_speed_x :* -1
		left_score :+ 1
	EndIf
	If ball_x + tile_size > left_paddle_x And ball_x < left_paddle_x + tile_size And ball_y + tile_size > left_paddle_y And ball_y < left_paddle_y + tile_size * 3
		ball_x = tile_size * 2
		ball_speed_x :* -1
	EndIf
	If ball_x + tile_size > right_paddle_x And ball_x < right_paddle_x + tile_size And ball_y + tile_size > right_paddle_y And ball_y < right_paddle_y + tile_size * 3
		ball_x = tile_size * 13
		ball_speed_x :* -1
	EndIf
EndFunction


Function initialize:Int(left_paddle_y: Float Var,
		                right_paddle_y: Float Var,
		                ball_x: Float Var,
		                ball_y: Float Var,
		                ball_speed_x: Float Var,
		                ball_speed_y: Float Var,
		                tile_size: Int,
		                paddle_speed: Float,
		                left_score: Int Var,
		                right_score: Int Var)
	left_paddle_y = tile_size * 3
	right_paddle_y = tile_size * 3 
	ball_x = tile_size * 8 - tile_size / 2
	ball_y = tile_size * 4
	ball_speed_x = paddle_speed * 1.3
	ball_speed_y = paddle_speed * 1.1
	left_score = 0
	right_score = 0
EndFunction


Function draw_left_paddle:Int(left_paddle_x: Float, left_paddle_y: Float, tile_size: Int)
	DrawRect(left_paddle_x, left_paddle_y, tile_size, tile_size * 3)
EndFunction


Function draw_right_paddle:Int(right_paddle_x: Float, right_paddle_y: Float, tile_size: Int)
	DrawRect(right_paddle_x, right_paddle_y, tile_size, tile_size * 3)
EndFunction


Function draw_ball:Int(ball_x: Float, ball_y: Float, tile_size: Int)
	DrawRect(ball_x, ball_y, tile_size, tile_size)
EndFunction


Function draw_left_score:Int(left_score: Int, left_score_x: Int, score_y: Int)
	DrawText(String(left_score), left_score_x, score_y)
EndFunction


Function draw_right_score:Int(right_score: Int, right_score_x: Int, score_y: Int)
	DrawText(String(right_score), right_score_x, score_y)
EndFunction


pong()
