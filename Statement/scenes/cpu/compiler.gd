extends Node

enum {INS_1,ARG_1,ARG_2,INS_2,ARG_3,ARG_4,INS_3,ARG_5,ARG_6,DONE,REGECT}

@onready var instruction  : RegEx  = RegEx.new()
@onready var separator : RegEx = RegEx.new()
@onready var epsilon  : RegEx = RegEx.new()
@onready var argument : RegEx = RegEx.new()
@onready var endl  : RegEx = RegEx.new()

func _ready():
	instruction.compile("^add|sub|mul|div|aeq|anq|agt|alt$")
	epsilon.compile("^eps$")
	argument.compile("^(\\d+|a|b|c|d)$")
	
func Compile(line : String) -> Dictionary:	
	var state : int = 0
	var instructions : Array[String]
	var arguments : Array[String]
	
	for lexeme in line.split(" ",false):
		
		match state:
			INS_1:
				if instruction.search(lexeme):
					instructions.push_back(lexeme)
					state += 1
				elif epsilon.search(lexeme):
					instructions.push_back(lexeme)
					arguments.push_back("0 0")
					state = DONE
				else:
					state = REGECT
			ARG_1:
				if argument.search(lexeme):
					arguments.push_back(lexeme)
					state += 1
				else:
					state = REGECT
			ARG_2:
				if argument.search(lexeme):
					arguments.push_back(lexeme)
					state += 1
				else:
					state = REGECT
			INS_2:
				if instruction.search(lexeme):
					instructions.push_back(lexeme)
					state += 1
				elif epsilon.search(lexeme):
					instructions.push_back(lexeme)
					arguments.push_back("0 0")
					state = INS_3
				else:
					state = REGECT
			ARG_3:
				if argument.search(lexeme):
					arguments.push_back(lexeme)
					state += 1
				else:
					state = REGECT
			ARG_4:
				if argument.search(lexeme):
					arguments.push_back(lexeme)
					state += 1
				else:
					state = REGECT
			INS_3:
				if instruction.search(lexeme):
					instructions.push_back(lexeme)
					state += 1
				elif epsilon.search(lexeme):
					instructions.push_back(lexeme)
					arguments.push_back("0 0")
					state = DONE
				else:
					state = REGECT
			ARG_5:
				if argument.search(lexeme):
					arguments.push_back(lexeme)
					state += 1
				else:
					state = REGECT
			ARG_6:
				if argument.search(lexeme):
					arguments.push_back(lexeme)
					state += 1
				else:
					state = REGECT
			DONE:
				state += 1
			REGECT:
				return {
					"Ins" : null,
					"Arg" : null
				}
				
	if(state == DONE || state == INS_2):
		return {
			"Ins" : instructions,
			"Arg" : arguments
		}
	
	return {
		"Ins" : null,
		"Arg" : null
	}
