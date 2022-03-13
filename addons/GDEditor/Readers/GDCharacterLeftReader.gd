tool

extends GDDialogueReader

class_name GDCharacterLeftReader


func render(character: CharacterData, dialogue_view: GDDialogueView, cursor: GDDialogueCursor) -> void:
	if dialogue_view.has_method("character_rleft"):
		dialogue_view.character_rleft(character)
	
#	cursor.next(0)
#	dialogue_view.next()
	cursor.forward(0)
