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
	"PosOffset": "PosOffset",
	"OrientationForward": "OrientationForward",
	"OrientationUp": "OrientationUp",
	"ObjectAttachedTo": "ObjectAttachedTo",
	"MountAttachedTo": "MountAttachedTo",
	"LoadedRoundsInChambers": "LoadedRoundsInChambers",
	"LoadedRoundsInMag": "LoadedRoundsInMag",
	"GenericInts": "GenericInts",
	"GenericStrings": "GenericStrings",
	"GenericVector3s": "GenericVector3s",
	"GenericRotations": "GenericRotations",
}

func _init(dict : Dictionary):
	for var_name : String in dict:
		var json_value = dict.get(var_name)
		set(var_name, json_value)
	
	##TODO: Implement Flags functionality

static func generateObjectElementsFromArray(json_array : Array) -> Array[ObjectElement]:
	var object_elements : Array[ObjectElement] = []
	for dict : Dictionary in json_array:
		var object_element = ObjectElement.new(dict)
		object_elements.append(object_element)
	return object_elements
