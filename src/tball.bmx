SuperStrict


Type TBall
	Private
		Field position: SVec2F
		Field initial_position: SVec2F
		Field width: Int
		Field height: Int
		Field speed: Float
		Field max_angle: Float
		Field velocity: SVec2F
		Field min_position: SVec2I
		Field max_position: SVec2I
		Field left_goal: Int
		Field right_goal: Int


	Public
		Method New(x: Float, y: Float, width: Int, height: Int, speed: Float, max_angle: Float, min_x: Int, max_x: Int, min_y: Int, max_y: Int)
			position = New SVec2F(x, y)
			initial_position = position
			Self.width = width
			Self.height = height
			Self.speed = speed
			Self.max_angle = max_angle
			velocity = New SVec2F(speed, 0)
			velocity = velocity.Rotate(Rnd(-max_angle, max_angle))
			min_position = New SVec2I(min_x, min_y)
			max_position = New SVec2I(max_x, max_y)
			left_goal = False
			right_goal = False
		EndMethod
		
		
		Method Initialize(speed_x: Float, speed_y: Float)
			position = initial_position
			velocity = New SVec2F(speed, 0)
			velocity = velocity.Rotate(Rnd(-max_angle, max_angle))
		EndMethod
		
		
		Method Update(delta_time: Float)
			position = New SVec2F(position.x + velocity.x * delta_time, position.y + velocity.y * delta_time)
			If position.y < min_position.y
				position = New SVec2F(position.x, min_position.y)
				velocity = New SVec2F(velocity.x, -velocity.y)
			EndIf
			If position.y > max_position.y
				position = New SVec2F(position.x, max_position.y)
				velocity = New SVec2F(velocity.x, -velocity.y)
			EndIf
			left_goal = position.x < min_position.x
			If left_goal
				position = initial_position
				velocity = New SVec2F(speed, 0)
				velocity = velocity.Rotate(Rnd(-max_angle, max_angle))
			EndIf
			right_goal = position.x > max_position.x
			If right_goal
				position = initial_position
				velocity = New SVec2F(-speed, 0)
				velocity = velocity.Rotate(Rnd(-max_angle, max_angle))
			EndIf
		EndMethod
		
		
		Method Draw()
			DrawRect(position.x, position.y, width, height)
		EndMethod
		
		
		Method IsLeftGoal: Int()
			Return left_goal
		EndMethod
		
		
		Method IsRightGoal: Int()
			Return right_goal
		EndMethod
		
		
		Method GetX: Float()
			Return position.x
		EndMethod
		
		
		Method SetX(new_value: Float)
			position = New SVec2F(new_value, position.y)
		EndMethod
		
		
		Method GetY: Float()
			Return position.y
		EndMethod
		
		
		Method GetWidth: Int()
			Return width
		EndMethod
		
		
		Method GetHeight: Int()
			Return height
		EndMethod


		Method GetSpeedX: Float()
			Return velocity.x
		EndMethod
		
		
		Method SetSpeedX(new_value: Float)
			velocity = New SVec2F(new_value, velocity.y)
		EndMethod
EndType
