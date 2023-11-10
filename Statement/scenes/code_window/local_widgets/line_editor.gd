extends LineEdit
var lexems : Dictionary
var last_state : bool = true

signal accepted_program
signal regected_program

func _on_text_changed(new_text):
	lexems = Compiler.Compile(new_text)
	
	if(!lexems["Ins"]):
		get_node("%" + name).set("theme_override_colors/font_color",Color(1,0,0))
		if(last_state):
			regected_program.emit()
			last_state = false 
	else:
		get_node("%" + name).set("theme_override_colors/font_color",Color(1,1,1))
		if(!last_state):
			accepted_program.emit()
			last_state = true

func _on_regected_program():
	pass # Replace with function body.
