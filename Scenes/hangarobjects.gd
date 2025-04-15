extends Node2D

func create_new_object(element_name):
	var new_object_element = ObjectElements.get_by_name(element_name).duplicate()
	var new_hangar_object = HangarObject.new()
	new_hangar_object.Elements.append(new_object_element)
	return new_hangar_object
