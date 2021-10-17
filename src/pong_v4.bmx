SuperStrict

Import "tpong.bmx"


Function start: Int()
	SeedRnd(MilliSecs())

	Local pong: TPong = New TPong(40, 300)
	pong.Start()
EndFunction


start()
