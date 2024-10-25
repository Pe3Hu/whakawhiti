class_name FaceResource extends Resource


var dice: DiceResource
var value: int
var index: int


func _init(dice_: DiceResource, value_: int) -> void:
	dice = dice_
	value = value_
	
	index = dice.faces.size()
	dice.faces.append(self)
