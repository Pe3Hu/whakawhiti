class_name TokenResource extends Resource


enum Support {STEALTH = 4, RADAR = 1}
enum Offense {FIREPOWER = 0, HACK = 2}
enum Defense {BARRIER = 3, FILTER = 5}
enum Aspect {FIREPOWER, RADAR, HACK, BARRIER, STEALTH, FILTER}

@export var aspect: Aspect
@export_multiline var description: String
@export var texture: Texture2D
@export_range(-25, 25, 1) var value: int


func init(aspect_: Aspect, value_: int) -> void:
	aspect = aspect_
	value = value_
	texture = load("res://entities/token/images/coin.png")
	
