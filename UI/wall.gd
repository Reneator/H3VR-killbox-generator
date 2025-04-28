extends Control

var wall_object : HangarObject

@onready var rotation_circle  = $Rotation_Circle
@onready var object_texture = $Object_Texture

func _ready():
	Events.editor_element_selected.connect(editor_element_selected)
	refresh()

func editor_element_selected(editor_element : Node):
	if editor_element == self:
		is_selected = true
	else:
		is_selected = false
	refresh()

func refresh():
	refresh_rotation_circle()

func refresh_rotation_circle():
	if not is_selected:
		rotation_circle.hide()
		return
		
	rotation_circle.show()

func _process(delta):
		handle_dragging()
		handle_rotation()

func handle_dragging():
	if not drag_offset:
		return
	global_position = get_global_mouse_position() - drag_offset

var previous_normalized_rotation_vector

func handle_rotation():
	if not mouse_drag_rotation:
		return
	var current_rotation_vector = get_global_mouse_position() - global_position
	var current_normalized_rotation_vector = current_rotation_vector.normalized()
	if not previous_normalized_rotation_vector:
		previous_normalized_rotation_vector =current_normalized_rotation_vector
		return
	var angle = current_normalized_rotation_vector.angle_to(previous_normalized_rotation_vector)
	print("Angle:%s" % angle)
	rotation -= angle
	previous_normalized_rotation_vector = current_normalized_rotation_vector


func as_wall_object():
	var element_pos = get_element_position()
	return wall_object

func get_element_position():
	pass
	
#relevant:
#Object_element:
#var PosOffset : Vector3
#var OrientationForward : Vector3
#var OrientationUp : Vector3 = Vector3(0,1.0,0)
#var ObjectID : String = "ShoothouseBarrierDoorSingle" ##the id fo the element with a full verbose id, like : "ShoothouseBarrierDoorSingle"

var mouse_dragging = false
var drag_offset = null
var is_selected = false
var mouse_drag_rotation = false

func _on_rotation_circle_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		mouse_drag_rotation = true
		Events.editor_element_selected.emit(self)
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
		mouse_drag_rotation = false
		previous_normalized_rotation_vector = null


func _on_object_texture_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		print("Mouse dragging true")
		drag_offset = get_global_mouse_position() - global_position
		mouse_dragging = true
		Events.editor_element_selected.emit(self)
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
		print("Mouse dragging false")
		mouse_dragging = false
		drag_offset = null
