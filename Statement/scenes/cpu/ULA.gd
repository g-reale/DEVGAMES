extends Node

static func add(op1: int ,op2: int) -> int:
	return op1 + op2

static func sub(op1: int ,op2: int) -> int:
	return op1 - op2

static func mul(op1: int ,op2: int) -> int:
	return op1 * op2	

static func div(op1: int ,op2: int) -> int:
	return op1 / op2 if op2 != 0 else 0

static func aeq(op1: int ,op2: int) -> int:
	return 1 if op1 == op2 else 0

static func anq(op1: int ,op2: int) -> int:
	return 1 if op1 != op2 else 0

static func agt(op1: int ,op2: int) -> int:
	return 1 if op1 > op2 else 0

static func alt(op1: int ,op2: int) -> int:
	return 1 if op1 < op2 else 0
	
static func eps(op1: int ,op2: int) -> Object:
	return null

class Statement:
	
	var instructions : Array[String] = ["eps"]
	var is_conditional : bool = false 
	
	func ld(ins : Array[String]):
		
		if(ins.size() != 1 and ins.size() != 3):
			instructions = ["eps"]
			is_conditional = false
			return 

		if(ins.size() == 3):
			is_conditional = true
		instructions == ins.duplicate()
		
	func unconditional(args : Array[int]):
		return ULA.call(instructions[0],args[0],args[1])
	
	func conditional(args : Array[int]):
		if(ULA.call(instructions[0],args[0],args[1]) != 0):
			return ULA.call(instructions[1],args[2],args[3])
		else:
			return ULA.call(instructions[2],args[4],args[5])
		
	func exec(args : Array[int]):
		return conditional(args) if is_conditional else unconditional(args)		
	
class Arguments:
	
	var ports : Array[int] = []
	var dynamic_args_references : Array[int] = []
	var dynamic_args_positions : Array[int] = []
	var args : Array[int] = []
	
	func _init(prts : Array[int]):
		ports = prts
	
	func ld(refs : Array[String]):
		for ref in refs:
			if(ref.is_valid_int()):
				args.append(int(ref))
			else:
				var port_ref : int = ref.to_ascii_buffer()[0] - 97
				dynamic_args_positions.append(args.size())
				dynamic_args_references.append(port_ref)
				args.append(ports[port_ref])
		
	
	func updateArgs() -> Array[int]:
		for i in range(dynamic_args_references.size()):
			args[dynamic_args_positions[i]] = ports[dynamic_args_references[i]]
		return args
	
	func getArgs() -> Array[int]:
		return args
