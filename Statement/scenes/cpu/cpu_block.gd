extends Control

var ports : Array[int] = [10,90,10,0]
var index : int = 0

var statements : Array[ULA.Statement] = [ULA.Statement.new(),ULA.Statement.new(),ULA.Statement.new(),ULA.Statement.new()]
var arguments : Array[ULA.Arguments] = [ULA.Arguments.new(ports),ULA.Arguments.new(ports),ULA.Arguments.new(ports),ULA.Arguments.new(ports)]

func _ready():
	pass

func ld(sttmts : Array[Array], args : Array[Array]):
	for i in range(min(statements.size(),sttmts.size())):
		statements[i].ld(sttmts[i])
	
	for i in range(min(arguments.size(),args.size())):
		arguments[i].ld(args[i])
		
func clk():
	arguments[index].updateArgs()
	print(statements[index].exec(arguments[index].getArgs()))
	index = (index + 1) % 4
