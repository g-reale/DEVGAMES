extends Button

var run_vote : int = 4

func _on_accepted_program():
	run_vote += 1
	if(run_vote == 4):
		disabled = false
	print(run_vote)

func _on_regected_program():
	run_vote -= 1
	disabled = true 
	print(run_vote)
