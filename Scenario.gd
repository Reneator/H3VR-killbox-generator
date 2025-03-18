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


func _init(json_dict : Dictionary):
	
	for variable_name in variables_to_json:
		var json_value = json_dict.get(variable_name)
		set(variable_name, json_value)
		
	var objects : Array = json_dict.get("Objects")
	Objects = HangarObject.generateHangarObjectsFromArray(objects)
	#Objects = HangarObject.new(objects)
	var properties = get_property_list()
	pass

func as_json():
	##TODO: Implement parsing to json
	pass
