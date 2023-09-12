extends Node2D
const t_window = preload("res://window/window.tscn")

#positions of the windows
var positions = [[54,125],[54,110],[54,94],[54,78],[54,62],[54,46],[64,30],
				   [116,88],[116,72],[116,56],[116,40],[116,24],[116,8],
				   [148,100],[166,100],[184,100],[202,100],
				   [220,88],[236,88],[236,72],[236,56],
				   [258,80],[258,64],[258,48],[258,32],[258,16]]

var letters = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
			
func scramble(vec:Array,amount:int):
	for i in range(amount):
		var idx_a = randi() % vec.size()
		var idx_b = randi() % vec.size()
		
		var buff = vec[idx_a]
		vec[idx_a] = vec[idx_b]
		vec[idx_b] = buff
	

func _ready():
	#random letter generator
	randomize()
	
	#randomly permutate the positions and letters x255
	scramble(positions,255)
	scramble(letters,255)	
	
	#write the alphabet on the windows 
	for i in range(positions.size()):
		#creates the window
		var window = t_window.instantiate()
		
		#configures the window
		window.text = letters[i]
		window.set_position(Vector2(positions[i][0],positions[i][1]))
		if(i < 4): # first 4 letters are the correct ones
			window.correct = true
			$Answer.text += window.text.capitalize() + " "
			
		#configures the signals
		window.connect("CORRECT",hit)
		window.connect("INCORRECT",miss)
		
		#adds the window
		add_child(window)

func miss():
	print("miss")

func hit():
	print("hit")
