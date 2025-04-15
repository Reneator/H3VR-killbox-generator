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
	add_barrier_wall(Objects, Vector3(11,0,-6),0,0)
	add_barrier_wall(Objects, Vector3(10,0,-5),1,1)
	self.FileName = level_name
	self.ReferencePath = "Vault\\SceneConfigs\\gp_hangar\\" + level_name + "_gp_hangar_VFS"


func add_barrier_wall(object_array, position, orientation_x, orientation_z):
	var barrier_wall_object = HangarObjects.create_new_object("BarrierWall")
	var barrier_wall_element : ObjectElement = barrier_wall_object.Elements[0]
	barrier_wall_element.PosOffset = position
	barrier_wall_element.OrientationUp = Vector3(0,1,0)
	#Todo: Figure out how Orientation works
	barrier_wall_element.OrientationForward = Vector3(orientation_x,0,orientation_z)
	object_array.append(barrier_wall_object)

func as_dict():
	var dict : Dictionary = {}
	for var_name in variables_to_json:
		var object_value = get(var_name)
		dict[var_name] = object_value
	
	dict["Objects"] = HangarObject.convertArrayToJsonArray(Objects)
	return dict
