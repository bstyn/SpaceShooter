extends Label

func _process(_delta):

	var NewScore = int(Global.Score)
	self.text = "Final Score: " + str(NewScore)
