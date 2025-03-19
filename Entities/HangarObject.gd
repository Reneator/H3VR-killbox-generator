extends Node
class_name HangarObject

var Index : int ##incrementing id for the objects
var IsContainedIn : int = -1 ##-1 means its not contained, and the number is the id of the object i think
var QuickbeltSlotIndex : int = -1
var InSlotOfRootObjectIndex : int = -1
var InSlotOfElementIndex : int = -1
var Elements : Array[ObjectElement]

var variables_to_json : Dictionary[String, String] = {
	"Index": "Index",
	"IsContainedIn": "IsContainedIn",
	"QuickbeltSlotIndex": "QuickbeltSlotIndex",
	"InSlotOfRootObjectIndex": "InSlotOfRootObjectIndex",
	"InSlotOfElementIndex": "InSlotOfElementIndex"
}

func _init(json_object : Dictionary):
	for var_name in variables_to_json:
		var json_value = json_object.get(var_name)
		set(var_name, json_value)
	var elements = json_object.get("Elements")
	Elements = ObjectElement.generateObjectElementsFromArray(elements)

func as_dict():
	var dict = {}
	for var_name in variables_to_json:
		var object_value = get(var_name)
		dict[var_name] = object_value
	
	dict["Elements"] = ObjectElement.convertArrayToJsonArray(Elements)
	return dict

static func generateHangarObjectsFromArray(json_objects : Array) -> Array[HangarObject]:
	var array : Array[HangarObject] = []
	for json_object : Dictionary in json_objects:
		var hangar_object = HangarObject.new(json_object)
		array.append(hangar_object)
	return array

static func convertArrayToJsonArray(hangar_objects : Array[HangarObject], starting_index : int = 0)-> Array[Dictionary]:
	var array_with_json_dicts : Array[Dictionary]
	
	##the index serves to give the h3vr scene file the correct index value for each object
	##after we made changes and added new objects or changed order of the objects
	var current_index = starting_index -1
	for hangar_object in hangar_objects:
		current_index += 1
		hangar_object.Index = current_index
		array_with_json_dicts.append(hangar_object.as_dict())
	return array_with_json_dicts
