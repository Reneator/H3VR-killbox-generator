extends Node
class_name ObjectElement

var Index : int
var ObjectID : String = "ShoothouseBarrierDoorSingle" ##the id fo the element with a full verbose id, like : "ShoothouseBarrierDoorSingle"
var Type : String =  "object"
var PosOffset : Vector3
var OrientationForward : Vector3
var OrientationUp : Vector3
var ObjectAttachedTo : int = -1
var MountAttachedTo : int = -1
var LoadedRoundsInChambers : Array = []
var LoadedRoundsInMag : Array = []
var GenericInts : Array = []
var GenericStrings : Array = []
var GenericVector3s : Array = []
var GenericRotations : Array = []

##needs to be translated to an object with 2 arrays "_keys" and "_values"
var Flags : Dictionary[String, String] = {
"IsKinematicLocked" : "True",
"IsPickupLocked" : "False",
"QuickBeltSpecialStateEngaged" : "False"
						 }

var variables_to_json : Dictionary[String, String] = {
	"Index": "Index",
	"ObjectID": "ObjectID",
	"Type": "Type",

	"ObjectAttachedTo": "ObjectAttachedTo",
	"MountAttachedTo": "MountAttachedTo",
	"LoadedRoundsInChambers": "LoadedRoundsInChambers",
	"LoadedRoundsInMag": "LoadedRoundsInMag",
	"GenericInts": "GenericInts",
	"GenericStrings": "GenericStrings",
	"GenericVector3s": "GenericVector3s",
	"GenericRotations": "GenericRotations",
	"Flags" : "Flags",
}

var vector3_variables_to_json : Dictionary[String, String] = {
	"PosOffset": "PosOffset",
	"OrientationForward": "OrientationForward",
	"OrientationUp": "OrientationUp",
}

func _init(dict : Dictionary):
	for var_name : String in dict:
		var json_value = dict.get(var_name)
		set(var_name, json_value)
	
	for var_name : String in vector3_variables_to_json:
		set(var_name, convert_json_vector3_to_vector3(dict.get(var_name)))

func as_dict():
	var dict = {}
	for var_name : String in variables_to_json:
		var object_value = get(var_name)
		dict[var_name] = object_value
	
	for vector3_var_name : String in vector3_variables_to_json:
		var vector3_value = get(vector3_var_name)
		dict[vector3_var_name] = convert_vector3_to_json_vector3(vector3_value)
	
	return dict

static func generateObjectElementsFromArray(json_array : Array) -> Array[ObjectElement]:
	var object_elements : Array[ObjectElement] = []
	for dict : Dictionary in json_array:
		var object_element = ObjectElement.new(dict)
		object_elements.append(object_element)
	return object_elements

static func convert_json_vector3_to_vector3(dictionary):
	if not dictionary:
		assert(false)
		return Vector3.ZERO
	var x = dictionary.get("x")
	var y = dictionary.get("y")
	var z = dictionary.get("z")
	var vector3 : Vector3 = Vector3(x,y,z)
	return vector3

static func convert_vector3_to_json_vector3(vector3 : Vector3):
	var json_vector3_dict = {}
	json_vector3_dict["x"] = vector3.x
	json_vector3_dict["y"] = vector3.y
	json_vector3_dict["z"] = vector3.z
	return json_vector3_dict

static func convertArrayToJsonArray(object_array : Array[ObjectElement], starting_index = 0) -> Array[Dictionary]:
	var array_with_json_dict : Array[Dictionary] = []
	var current_index = starting_index - 1
	for object_element : ObjectElement in object_array:
		starting_index += 1
		object_element.Index =current_index
		array_with_json_dict.append(object_element.as_dict())
	return array_with_json_dict
