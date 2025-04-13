extends Node2D

func get_by_name(element_name):
	var elements_array = get_children()
	for element in elements_array:
		if element.name == element_name:
			return element
