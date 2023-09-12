extends Button

signal CORRECT()
signal INCORRECT() 

var correct = false 

var radius = 3
var theta = 0
var base_position
var angular_speed = 0.1

const SUCESS  = Color(0,255,0)
const FAILURE = Color(255,0,0)	
const HOVER = Color(125,116,116)

func _ready():
	self.add_theme_color_override("font_hover_color",HOVER)
	base_position = self.get("position")
	theta = randf()
	#randomly inverts the angular speed 
	if((randi()%2) == 0):
		angular_speed = -angular_speed
		
func _physics_process(delta):
	theta += angular_speed
	self.set("position",Vector2(radius,0).rotated(theta) + base_position)


func _on_pressed():
	if(correct):
		emit_signal("CORRECT")
		add_theme_color_override("font_disabled_color",SUCESS)
	else:
		emit_signal("INCORRECT")
		add_theme_color_override("font_disabled_color",FAILURE)		
	disabled = true
