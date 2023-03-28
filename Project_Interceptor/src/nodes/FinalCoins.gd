extends Label


func _process(delta):

	var NewScore = int(Global.Score)
	self.text = "Coins: + " + str(round(NewScore/5))
	
