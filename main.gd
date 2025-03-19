extends Node


var file_path = "res://TEST BOUNDARY_gp_hangar_VFS.json"

var output_file_path = "res://Json_Output_test.json"


func _ready():
	var file = FileAccess.open(file_path, FileAccess.READ)
	var string = file.get_as_text()
	var json_result = JSON.parse_string(string)
	print(json_result)
	var scenario : Scenario = json_to_scenario(json_result)
	var json_string = scenario_to_json(scenario)
	var output_file = FileAccess.open(output_file_path,FileAccess.WRITE)
	output_file.store_string(json_string)
	

func json_to_scenario(dict : Dictionary) -> Scenario:
	var scenario = Scenario.new(dict)
	return scenario

func scenario_to_json(scenario : Scenario) -> String:
	var dict = scenario.as_dict()
	var json_string = JSON.stringify(dict, "\t", false)
	return json_string
	
