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

static func generateHangarObjectsFromArray(json_objects : Array) -> Array[HangarObject]:
	var array : Array[HangarObject] = []
	for json_object : Dictionary in json_objects:
		var hangar_object = HangarObject.new(json_object)
		array.append(hangar_object)
	return array
