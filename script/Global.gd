extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var color = {}
var dict = {}


func _ready() -> void:
	if dict.keys().is_empty():
		init_arr()
		init_color()
		init_dict()
	
	#get_tree().bourse.resource.after_init()
	
func init_arr() -> void:
	arr.aspect_designation = ["firepower", "radar", "hack", "barrier", "stealth", "filter"]
	arr.support = [
		TokenResource.Aspect.RADAR,
		TokenResource.Aspect.STEALTH
	]
	arr.defense = [
		TokenResource.Aspect.BARRIER,
		TokenResource.Aspect.FILTER
	]
	arr.offense = [
		TokenResource.Aspect.FIREPOWER,
		TokenResource.Aspect.HACK
	]
	
	arr.aspect = [
		TokenResource.Aspect.FIREPOWER,
		TokenResource.Aspect.RADAR,
		TokenResource.Aspect.HACK,
		TokenResource.Aspect.BARRIER,
		TokenResource.Aspect.STEALTH,
		TokenResource.Aspect.FILTER,
	]
	
func init_dict() -> void:
	init_direction()
	init_dice()
	
func init_direction() -> void:
	dict.direction = {}
	dict.direction.linear2 = [
		Vector2i( 0,-1),
		Vector2i( 1, 0),
		Vector2i( 0, 1),
		Vector2i(-1, 0)
	]
	dict.direction.diagonal = [
		Vector2i( 1,-1),
		Vector2i( 1, 1),
		Vector2i(-1, 1),
		Vector2i(-1,-1)
	]
	
	dict.direction.hybrid = []
	
	for _i in dict.direction.linear2.size():
		var direction = dict.direction.linear2[_i]
		dict.direction.hybrid.append(direction)
		direction = dict.direction.diagonal[_i]
		dict.direction.hybrid.append(direction)
	
func init_dice() -> void:
	dict.dice = {}
	dict.dice.aspect = {}
	dict.dice.aspect[TokenResource.Aspect.FIREPOWER] = [1,2,4,6,8,8]
	dict.dice.aspect[TokenResource.Aspect.RADAR] = [1,2,3,6,7,8]
	dict.dice.aspect[TokenResource.Aspect.HACK] = [1,2,5,7,7,7]
	dict.dice.aspect[TokenResource.Aspect.BARRIER] = [1,2,4,5,6,8]
	dict.dice.aspect[TokenResource.Aspect.STEALTH] = [2,3,4,5,6,7]
	dict.dice.aspect[TokenResource.Aspect.FILTER] = [1,3,3,5,7,7]
	
	dict.avg = {}
	dict.avg.aspect = {}
	
	for aspect in dict.dice.aspect:
		dict.avg.aspect[aspect] = 0.0
		
		for value in dict.dice.aspect[aspect]:
			dict.avg.aspect[aspect] += value
		
		dict.avg.aspect[aspect] /= dict.dice.aspect[aspect].size()
	
func init_color():
	pass
	var h = 360.0
	
	color.aspect = {}
	color.aspect[TokenResource.Aspect.FIREPOWER] = Color.from_hsv(20 / h, 0.9, 0.9)
	color.aspect[TokenResource.Aspect.RADAR] = Color.from_hsv(90 / h, 0.9, 0.9)
	color.aspect[TokenResource.Aspect.HACK] = Color.from_hsv(140 / h, 0.9, 0.9)
	color.aspect[TokenResource.Aspect.BARRIER] = Color.from_hsv(200 / h, 0.9, 0.9)
	color.aspect[TokenResource.Aspect.STEALTH] = Color.from_hsv(270 / h, 0.9, 0.9)
	color.aspect[TokenResource.Aspect.FILTER] = Color.from_hsv(340 / h, 0.9, 0.9)
	
func save(path_: String, data_): #: String
	var file = FileAccess.open(path_, FileAccess.WRITE)
	file.store_string(data_)
	
func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var _parse_err = json_object.parse(text)
	return json_object.get_data()
	
func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null
	
func get_all_combinations_based_on_size(array_: Array, size_: int) -> Array:
	var combinations = {}
	combinations[0] = array_.duplicate()
	combinations[1] = []
	
	for child in array_:
		combinations[1].append([child])
	
	for _i in size_ - 1:
		set_combinations_based_on_size(combinations, _i + 2)
	
	return combinations[size_]
	
func set_combinations_based_on_size(combinations_: Dictionary, size_: int) -> void:
	var parents = combinations_[size_ - 1]
	combinations_[size_] = []
	
	for parent in parents:
		for child in combinations_[0]:
			if !parent.has(child):
				var combination = []
				combination.append_array(parent)
				combination.append(child)
				combination.sort_custom(func(a, b): return combinations_[0].find(a) < combinations_[0].find(b))
				
				if !combinations_[size_].has(combination):
					combinations_[size_].append(combination)
	
#func get_str_aspect(aspect_: TokenResource.Type) -> String:
	#return TokenResource.Aspect.keys()[aspect_].to_lower().capitalize()
