extends Node

var save_path = "user://variable.save"
var highscore = null

signal highscore_changed

func _on_save_timeout():
	save()
	
func _ready(): 
	load_data()
	
func save():
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	if file != null:
		file.store_var(highscore)
		file.close()
	else:
		print("Failed to open file for writing")

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path,FileAccess.READ)
		highscore = file.get_var()
		file.close()
	else:
		highscore = 0
	highscore_changed.emit(highscore)  # emit the signal with the correct name
	print(highscore)


func _on_game_over_menu_save_highscore(changed_highscore):
	highscore = changed_highscore
