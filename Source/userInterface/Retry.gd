extends Button


func _on_Retry_button_up():
	get_tree().paused=false
	print("retry")
	get_tree().change_scene(Data.array[Data.level])
