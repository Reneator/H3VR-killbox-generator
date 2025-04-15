extends Node
class_name Scenario

var FileName : String = "Json_Output_test" ##the name of the file and the level
var ReferencePath : String = "Vault\\SceneConfigs\\gp_hangar\\Json_Output_test_gp_hangar_VFS"
var Creator : String = "CreatorNameHere"
var ModsUsed : Array = []

var Objects : Array[HangarObject]

var variables_to_json : Dictionary[String, String] = {
	"FileName": "FileName",
	"ReferencePath": "ReferencePath",
	"Creator": "Creator",
	"ModsUsed": "ModsUsed"
}


func _init(level_name,dict : Dictionary):
	for variable_name in variables_to_json:
		var json_value = dict.get(variable_name)
		set(variable_name, json_value)
		
	var objects : Array = dict.get("Objects")
	Objects = HangarObject.generateHangarObjectsFromArray(objects)
	#Objects = HangarObject.new(objects)
	var properties = get_property_list()
	add_barrier_wall(Objects, Vector3(11,0,-6),135)
	add_barrier_wall(Objects, Vector3(11,0,-6),45)
	self.FileName = level_name
	self.ReferencePath = "Vault\\SceneConfigs\\gp_hangar\\" + level_name + "_gp_hangar_VFS"


func add_barrier_wall(object_array, position: Vector3, yaw_degrees: float):
	var barrier_wall_object = HangarObjects.create_new_object("BarrierWall")
	var barrier_wall_element : ObjectElement = barrier_wall_object.Elements[0]
	barrier_wall_element.PosOffset = position
	barrier_wall_element.OrientationUp = Vector3(0, 1, 0)
	barrier_wall_element.OrientationForward = get_forward_vector_from_yaw_degrees(yaw_degrees)
	object_array.append(barrier_wall_object)

func get_forward_vector_from_yaw_degrees(yaw_degrees: float) -> Vector3:
	var radians = deg_to_rad(yaw_degrees)
	return Vector3(sin(radians), 0, cos(radians)).normalized()
	
func as_dict():
	var dict : Dictionary = {}
	for var_name in variables_to_json:
		var object_value = get(var_name)
		dict[var_name] = object_value
	
	dict["Objects"] = HangarObject.convertArrayToJsonArray(Objects)
	return dict
