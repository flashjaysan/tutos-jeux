SuperStrict


Type TPaddle
	Private
		Field position: SVec2F
		Field initial_y: Float
		Field key_up: Int
		Field key_down: Int


	Public
		Global width: Int
		Global height: Int
		Global speed: Float
		Global min_y: Float
		Global max_y: Float
		
		
		Method New(x: Float, y: Float, key_up: Int, key_down: Int)
			position = New SVec2F(x, y)
			initial_y = position.y
			Self.key_up = key_up
			Self.key_down = key_down
		EndMethod
		
		
		Method Initialize()
			position = New SVec2F(position.x, initial_y)
		EndMethod
		
		
		Method Update(delta_time: Float)
			If KeyDown(key_up)
				position = New SVec2F(position.x, position.y - speed * delta_time)
			EndIf
			If KeyDown(key_down)
				position = New SVec2F(position.x, position.y + speed * delta_time)
			EndIf
			If position.y < min_y
				position = New SVec2F(position.x, min_y)
			EndIf
			If position.y > max_y
				position = New SVec2F(position.x, max_y)
			EndIf
		EndMethod
		
		
		Method Draw()
			DrawRect(position.x, position.y, width, height)
		EndMethod
		
		
		Method GetX: Float()
			Return position.x
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
EndType
