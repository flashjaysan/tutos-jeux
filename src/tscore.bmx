SuperStrict


Type TScore
	Private
		Field value: Int
		Field position: SVec2I
	
	
	Public
		Method New(x: Int, y: Int)
			value = 0
			position = New SVec2I(x, y)
		EndMethod
		
		
		Method Initialize()
			value = 0
		EndMethod
		
		
		Method Add(value: Int)
			Self.value :+ value
		EndMethod
		
		
		Method Draw()
			DrawText(String(value), position.x, position.y)
		EndMethod
		
		
		Method GetValue: Int()
			Return value
		EndMethod
EndType
