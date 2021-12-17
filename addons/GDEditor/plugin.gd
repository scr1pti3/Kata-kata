tool
extends EditorPlugin

const DialogueEditorScene = preload("res://addons/GDEditor/Scenes/DialogueEditor.tscn")

var dialogue_editor : PanelContainer

func _enter_tree() -> void:
	dialogue_editor = DialogueEditorScene.instance()
	get_editor_interface().get_editor_viewport().add_child(dialogue_editor)
	
	add_custom_type(
			"ComponentData", 
			"Resource", 
			load("res://addons/GDEditor/Resources/Custom/ComponentData.gd"), 
			get_editor_interface().get_base_control().get_icon("ResourcePreloader", "EditorIcons"))
	
	GDUtil.add_state("editor_interface", get_editor_interface())
	
	# Prevent competing active main screen
	make_visible(false)


func _exit_tree() -> void:
	if dialogue_editor:
		dialogue_editor.queue_free()
		
	GDUtil.erase_state("editor_interface")


func has_main_screen() -> bool:
	return true
	
	
func make_visible(visible: bool) -> void:
	if dialogue_editor:
		dialogue_editor.visible = visible

	
func get_plugin_name() -> String:
	return "GDEditor"
	
	
func get_plugin_icon() -> Texture:
	return get_editor_interface().get_base_control().get_icon("Node", "EditorIcons")


#func handles(object: Object) -> bool:
#	return true