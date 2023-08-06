extends Node
var exclusion_folders = []
var csv_file = File.new()
var message_list:Dictionary = {}
var languages = ["en", "de", "eo","es","es_mx","fr","it","ja","ko","pt","zh",]
var display_lang = ["English", "German", "Esperanto", "Spanish", "Spanish (Mexico)","French","Italian","Japanese","Korean","Portuguese","Chinese (Traditional)"]
onready var language_options:OptionButton = $PanelContainer/MarginContainer/GridContainer/OptionButton
func _ready():	
	for language in display_lang:
		language_options.add_item(language)

func add_messages():
	for key in message_list.keys():
		csv_file.store_string(key + "," + message_list[key] + "\n")	
	
func parse_directory(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name != "." and file_name != ".." and not exclusion_folders.has(file_name):
				if dir.current_is_dir():
					parse_directory(path + file_name + "/")
				elif file_name.ends_with(".tscn") or file_name.ends_with(".tres"):
					parse_file(path + file_name)
			file_name = dir.get_next()				

func parse_file(path):
	var file = File.new()
	if file.open(path, File.READ) == OK:
		while not file.eof_reached():
			var line = file.get_line()
			var regex = RegEx.new()
			regex.compile("\"[A-Z0-9_]*\"") 
			var results = regex.search(line)
			if results:
				for string in results.strings:
					if string == "":
						continue					
					var key = string
					var message = tr(string.replacen("\"", ""))
					if key == message:
						continue
					if key.length() <= 5:
						continue
					if message != "":
						if not message_list.has(key):
							message_list[key] = message			            
						
											
	file.close()

func _on_Button_pressed():
	$FileDialog.popup()		


func _on_FileDialog_dir_selected(dir):
	var language = languages[language_options.selected]
	TranslationServer.set_locale(language)	
	csv_file.open(dir+"/translation_extract_"+language+".csv", File.WRITE)
	csv_file.store_string("Key,Translation\n") 
	parse_directory("res://")
	add_messages()
	csv_file.close()
	SceneManager.change_scene("res://addons/TranslationDump/TranslationBox.tscn")

