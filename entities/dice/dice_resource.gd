class_name DiceResource extends Resource


var pool: PoolResource
var faces: Array[FaceResource]
var aspect: TokenResource.Aspect
var is_fixed: bool = false
var current_face: FaceResource


func _init(pool_: PoolResource, aspect_: TokenResource.Aspect) -> void:
	pool = pool_
	aspect = aspect_
	
	for value in Global.dict.dice.aspect[aspect]:
		add_face(value)
	
	pool.dices.append(self)
	
func add_face(value_: int) -> void:
	var _face = FaceResource.new(self, value_)
	
func roll() -> void:
	var rnd_index = randi_range(0, faces.size() - 1)
	current_face = faces[rnd_index]
	
	if !pool.values.has(current_face.value):
		pool.values[current_face.value] = []
	
	pool.values[current_face.value].append(self)
