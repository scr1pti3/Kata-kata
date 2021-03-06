tool

extends PopupMenu

signal preview_dialogue
signal new_dialogue(dialogue_name)
signal save_dialogue
signal open_dialogue(graph_editor)


enum {
	MENU_PREVIEW_DIALOGUE,
	MENU_NEW_DIALOGUE,
	MENU_OPEN_DIALOGUE,
	MENU_SAVE_DIALOGUE,
	MENU_SAVE_DIALOGUE_AS,
}

# This variable is set externally, don't touch.
var active_preview: GDDialogueView


func _ready() -> void:
	# There exist a case where somehow an item 
	# is added multiple time. This is to prevent that.
	if get_item_count():
		clear()
	
	add_item("Preview [off]", MENU_PREVIEW_DIALOGUE)
	add_separator("", -999)
	add_item("New Dialogue", MENU_NEW_DIALOGUE)
	add_item("Open Dialogue", MENU_OPEN_DIALOGUE)
	add_separator("", -998)
	add_item("Save Dialogue", MENU_SAVE_DIALOGUE)
	add_item("Save Dialogue As", MENU_SAVE_DIALOGUE_AS)


func _on_id_pressed(id: int) -> void:
	match id:
		MENU_PREVIEW_DIALOGUE:
			emit_signal("preview_dialogue")
		MENU_NEW_DIALOGUE:
			$DialogueNamePrompt.popup_centered()
		MENU_SAVE_DIALOGUE:
			emit_signal("save_dialogue")
		MENU_OPEN_DIALOGUE:
			$DialogueQuickOpen.popup_dialog("PackedScene", GDUtil.get_save_dir())


func _on_DialogueNamePrompt_confirmed(dialogue_name) -> void:
	emit_signal("new_dialogue", dialogue_name)


func _on_about_to_show() -> void:
	if active_preview.visible:
		set_item_text(MENU_PREVIEW_DIALOGUE, "Preview [on]")
	else:
		set_item_text(MENU_PREVIEW_DIALOGUE, "Preview [off]")


func _on_DialogueQuickOpen_confirmed() -> void:
	var file_name = $DialogueQuickOpen.get_selected()
	
	print_debug(self, " DialogueQuickOpen Selected: %s" % file_name)
	
	if not file_name.empty():
		var file_path : String = "res://" + file_name
		
		var graph_editor = load(file_path).instance()
		print_debug(self, " Loading GDGraphEditor: %s" % file_path)
		
		if graph_editor is GDGraphEditor:
			emit_signal("open_dialogue", graph_editor)
			print_debug(self, " GDGraphEditor Loaded: ", graph_editor)
