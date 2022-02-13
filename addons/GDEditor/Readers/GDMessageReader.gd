extends GDDialogueReader

class_name GDMessageReader


func can_handle(graph_node: GDGraphNode) -> bool:
	return graph_node is GNMessage


func render(graph_node: GNMessage, dialogue_viewer: GDDialogueView, cursor: GDDialogueCursor) -> void:
	var message := read(graph_node)
	
	dialogue_viewer.set_text_box(message)
	
	cursor.next()


func read(graph_node: GNMessage) -> String:
	return graph_node.s_message
