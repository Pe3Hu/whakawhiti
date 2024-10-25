class_name BourseResource extends Resource


var pools: Array[PoolResource]


func _init() -> void:
	var a = Time.get_unix_time_from_system()
	Global._ready()
	init_pools()
	#
	var b = Time.get_unix_time_from_system()
	print(b - a)
	
func init_pools() -> void:
	for _i in 1:
		var _pool = PoolResource.new()
	
