extends Node

var csv_file = File.new()
var message_list:Dictionary = {}
var languages = ["en", "de_DE", "eo","es_ES","es_MX","fr_FR","it_IT","ja_JP","ko_KR","pt_BR","zh_CN",]
var display_lang = ["English", "German", "Esperanto", "Spanish", "Spanish (Mexico)","French","Italian","Japanese","Korean","Portuguese","Chinese (Traditional)"]
onready var language_options:OptionButton = $PanelContainer/MarginContainer/GridContainer/OptionButton

func _ready():	
	for language in display_lang:
		language_options.add_item(language)

func add_messages():
	for key in message_list.keys():
		var newstring:String
		newstring = "\"" + message_list[key] + "\""
		message_list[key] = newstring
		csv_file.store_string(key + "," + message_list[key] + "\n")	

func _on_Button_pressed():
	$FileDialog.popup()		

func _on_FileDialog_dir_selected(dir):
	var language = languages[language_options.selected]
	var datafiles:Array = []
	var import_translations:Array = []
		
	csv_file.open(dir+"/translation_extract_"+language+".csv", File.WRITE)
	csv_file.store_string("id,"+language+"\n") 

	Datatables.list_dir(datafiles,"res://.import/","res")
	for file in datafiles:
		var loaded_file = load(file)
		if loaded_file.get("translations"):
			import_translations.append(loaded_file)
	
	for translationset in import_translations:				
		for i in range(0, translationset.translations[language].messages.size(), 2):
			if translationset.translations[language].messages[i] != "":
				message_list[translationset.translations[language].messages[i]] = translationset.translations[language].messages[i+1]
	add_messages()
	csv_file.close()
	SceneManager.change_scene(SceneManager.current_scene)

