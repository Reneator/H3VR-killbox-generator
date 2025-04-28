extends Control


@export var wall_scene : PackedScene

var current_selected_editor_element 

func _ready():
	Events.editor_element_selected.connect(editor_element_selected)

func editor_element_selected(editor_element):
	current_selected_editor_element = editor_element
	current_duplicate_position = Vector2(0,0)

var current_copy_buffer 
var current_duplicate_position = Vector2(0,0)

func _input(event: InputEvent) -> void:
	handle_shortcuts(event)

func handle_shortcuts(event : InputEvent):
	if not current_selected_editor_element:
		return
	if is_copy_shortcut(event):
		current_copy_buffer = current_selected_editor_element
		pass
	if is_duplicate_shortcut(event):
		var duplicate_element = current_selected_editor_element.duplicate()
		current_duplicate_position += Vector2(10,10)
		duplicate_element.global_position += current_duplicate_position
		add_child(duplicate_element)
		
	if is_paste_shortcut(event) and current_copy_buffer:
		var paste_position = get_global_mouse_position()
		var paste_element = current_copy_buffer.duplicate()
		paste_element.global_position = paste_position
		add_child(paste_element)


func is_copy_shortcut(event: InputEvent):
	if  event.is_pressed() and event.as_text() == "Ctrl+C":
		#für besseres debugging so aufgebaut
		return true
	return false

func is_duplicate_shortcut(event : InputEvent):
	if event.is_pressed() and event.as_text() == "Ctrl+D":
		#für besseres debugging so aufgebaut
		return true
	return false

func is_paste_shortcut(event : InputEvent):
	if event.is_pressed() and event.as_text() == "Ctrl+V":
		#für besseres debugging so aufgebaut
		return true
	return false

func _on_add_wall_button_pressed() -> void:
	var wall = wall_scene.instantiate()
	add_child(wall)


func _on_export_as_json_button_pressed() -> void:
	pass # Replace with function body.
