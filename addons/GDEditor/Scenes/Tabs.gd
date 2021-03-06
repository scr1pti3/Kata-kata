tool

extends Tabs

signal tab_closed(tab)
signal tab_renamed(tab, old_name, new_name)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not event.doubleclick:
			return


		var curr_tab_rect := get_tab_rect(current_tab)

		if not curr_tab_rect.has_point(event.position):
			return

		var curr_tab_title := get_tab_title(current_tab)

		# Repositioned NameEdit.
		$NameEdit.rect_size = curr_tab_rect.size
		$NameEdit.rect_position = get_global_rect().position + curr_tab_rect.position
		$NameEdit.text = curr_tab_title
		$NameEdit.caret_position = curr_tab_title.length()
		$NameEdit.set_as_toplevel(true)
		$NameEdit.show_modal()
		$NameEdit.grab_focus()
		
		accept_event()


func add_tab(title := "", icon: Texture = null) -> void:
	.add_tab(title, icon)
	
	current_tab = get_tab_count() - 1
	
	emit_signal("tab_changed", current_tab)

func _on_tab_close(tab: int) -> void:
	if $NameEdit.visible:
		return

	remove_tab(tab)
	
	emit_signal("tab_closed", tab)


func _on_NameEdit_text_entered(new_text: String) -> void:
	$NameEdit.hide()


func _on_NameEdit_hide() -> void:
	var tab_name := get_tab_title(current_tab)
	var new_name : String = $NameEdit.text
	
	if not new_name == tab_name:
		print_debug(self, " tab(%d) renamed from %s to %s" % [current_tab, tab_name, new_name])
		set_tab_title(current_tab, new_name)
		
		emit_signal("tab_renamed", current_tab, tab_name, new_name)
