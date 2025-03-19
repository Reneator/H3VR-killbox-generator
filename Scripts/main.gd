extends Node


var file_path = "res://TEST BOUNDARY_gp_hangar_VFS.json"


func _ready():
	var file = FileAccess.open(file_path, FileAccess.READ)
	var string = file.get_as_text()
	var json_result = JSON.parse_string(string)
	print(json_result)
	var scenario : Scenario = json_to_scenario(json_result)
	pass
	#var json = scenario_to_json(scenario)

func json_to_scenario(json_dict : Dictionary) -> Scenario:
	var scenario = Scenario.new(json_dict)
	return scenario

func scenario_to_json(scenario : Scenario) -> Dictionary:
	return scenario.as_json()
	
