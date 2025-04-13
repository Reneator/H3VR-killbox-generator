extends Node
class_name Scenario

var FileName : String = "TEST BOUNDARY2" ##the name of the file and the level
var ReferencePath : String = "Vault\\SceneConfigs\\gp_hangar\\TEST BOUNDARY_gp_hangar_VFS.json"
var Creator : String = "CreatorNameHere"
var ModsUsed : Array = []

var Objects : Array[HangarObject]

var variables_to_json : Dictionary[String, String] = {
	"FileName": "FileName",
	"ReferencePath": "ReferencePath",
	"Creator": "Creator",
	"ModsUsed": "ModsUsed"
}


func _init(dict : Dictionary):
	
	for variable_name in variables_to_json:
		var json_value = dict.get(variable_name)
		set(variable_name, json_value)
		
	var objects : Array = dict.get("Objects")
	Objects = HangarObject.generateHangarObjectsFromArray(objects)
	#Objects = HangarObject.new(objects)
	var properties = get_property_list()
	var new_barrier_wall = create_barrier_wall(Vector3(12,1,-6),Vector3(0,1,0))
	Objects.append(new_barrier_wall)

func create_barrier_wall(position, orientation):
	var barrier_wall_object = HangarObjects.create_new_object("BarrierWall")
	var barrier_wall_element : ObjectElement = barrier_wall_object.Elements[0]
	barrier_wall_element.PosOffset = position
	barrier_wall_element.OrientationForward = orientation
	return barrier_wall_object

func as_dict():
	var dict : Dictionary = {}
	for var_name in variables_to_json:
		var object_value = get(var_name)
		dict[var_name] = object_value
	
	dict["Objects"] = HangarObject.convertArrayToJsonArray(Objects)
	return dict
