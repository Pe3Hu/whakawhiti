class_name PoolResource extends Resource


var dices: Array[DiceResource]
var fixed_dice: Array[DiceResource]
var loose_dice: Array[DiceResource]

var aspects = {}
var values = {}
var stoppers = []

var failure: float = 0.0
var result: int = 0
var avg: float = 0.0


func _init() -> void:
	change_aspect(TokenResource.Aspect.HACK, 5)
	change_aspect(TokenResource.Aspect.RADAR, 3)
	init_dices()
	
	roll_dices()
	rate_roll()
	
func change_aspect(aspect_: TokenResource.Aspect, value_: int) -> void:
	if !aspects.has(aspect_):
		aspects[aspect_] = 0
	
	aspects[aspect_] += value_
	
	if aspects[aspect_] == 0:
		aspects.erase(aspect_)
	
func init_dices() -> void:
	for aspect in aspects:
		for _i in aspects[aspect]:
			var _dice = DiceResource.new(self, aspect)
	
	loose_dice.append_array(dices)
	failure = 0
	result = 0
	
func roll_dices() -> void:
	values = {}
	avg = 0
	
	for dice in dices:
		dice.roll()
		avg += Global.dict.avg.aspect[dice.aspect]
	
	avg /= dices.size()
	
func rate_roll() -> void:
	var weaks = []
	var strongs = []
	var options = []
	var fix_value
	
	for value in values:
		if value <= avg and values[value].size() == 1:
			weaks.append(value)
		
		if value >= avg and values[value].size() > 1:
			strongs.append(value)
	
	if !strongs.is_empty():
		var repeats = []
		fix_value = 0
	
	#print(avg)
	#var ordered_value = values.keys()
	#ordered_value.sort()
	#for value in ordered_value:
		#print([value, values[value].size()])
	
	
	fix_dices(fix_value)
	
func fix_dices(value_: int) -> void:
	stoppers.append(value_)
