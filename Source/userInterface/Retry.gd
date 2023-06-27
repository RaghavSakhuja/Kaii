extends Button


func _on_Retry_button_up():
	get_tree().paused=false
	print("retry")
	get_tree().reload_current_scene()
