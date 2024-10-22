class_name BourseResource extends Resource


#var junctions: Array[JunctionResource]



func _init() -> void:
	var a = Time.get_unix_time_from_system()
	Global._ready()
	init_junctions()
	#
	var b = Time.get_unix_time_from_system()
	print(b - a)
	
func init_junctions() -> void:
	for _i in 1:
		var _junction = JunctionResource.new(self)
	
