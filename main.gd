extends Node


var file_path = "res://TEST BOUNDARY_gp_hangar_VFS.json"

var output_file_path = "res://Json_Output_test.json"


func _ready():
	var level_name = "Json_Output_test"
	var file = FileAccess.open(file_path, FileAccess.READ)
	var string = file.get_as_text()
	var json_result = JSON.parse_string(string)
	print(json_result)
	var scenario : Scenario = json_to_scenario(level_name, json_result)
	var json_string = scenario_to_json(scenario)
	var output_file_name = level_name + "_gp_hangar_VFS.json"
	var output_dir = get_h3vr_config_path()
	var output_file_path = output_dir + output_file_name
	
	var output_file = FileAccess.open(output_file_path,FileAccess.WRITE)
	output_file.store_string(json_string)
	get_tree().quit()
	

func json_to_scenario(level_name, dict : Dictionary) -> Scenario:
	var scenario = Scenario.new(level_name, dict)
	return scenario

func scenario_to_json(scenario : Scenario) -> String:
	var dict = scenario.as_dict()
	var json_string = JSON.stringify(dict, "\t", false)
	return json_string
	

func get_h3vr_config_path() -> String:
	var user_profile = OS.get_environment("USERPROFILE") # C:\Users\YourName
	var path = user_profile + "/Documents/My Games/H3VR/Vault/SceneConfigs/gp_hangar/"
	return path
