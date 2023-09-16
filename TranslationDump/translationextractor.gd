extends Node
var exclusion_folders = []
var csv_file = File.new()
var message_list:Dictionary = {}
var languages = ["en", "de_DE", "eo","es_ES","es_MX","fr_FR","it_IT","ja_JP","ko_KR","pt_BR","zh_CN",]
var display_lang = ["English", "German", "Esperanto", "Spanish", "Spanish (Mexico)","French","Italian","Japanese","Korean","Portuguese","Chinese (Traditional)"]
onready var language_options:OptionButton = $PanelContainer/MarginContainer/GridContainer/OptionButton
var translation_files:Array = ["res://addons/TranslationDump/1.1_demo.csv.tres",
							   "res://addons/TranslationDump/1.1_release.csv.tres",
								"res://addons/TranslationDump/dialogue_demo.csv.tres",
								"res://addons/TranslationDump/dialogue_release.csv.tres",
								"res://addons/TranslationDump/strings_demo.csv.tres",
								"res://addons/TranslationDump/strings_release.csv.tres"
								]
func _ready():	
	for language in display_lang:
		language_options.add_item(language)

func add_messages():
	for key in message_list.keys():
		var new_string:String = message_list[key]
		new_string = "\"" + new_string.replacen("\n","\\n") + "\""
		message_list[key] = new_string
		csv_file.store_string(key + "," + message_list[key] + "\n")	

func _on_Button_pressed():
	$FileDialog.popup()		

func _on_FileDialog_dir_selected(dir):
	var language = languages[language_options.selected]
	TranslationServer.set_locale(language)	
	csv_file.open(dir+"/translation_extract_"+language+".csv", File.WRITE)
	csv_file.store_string("id,"+language+"\n") 
	var translationset
	for file in translation_files:
		translationset = load(file)		
		for i in range(0, translationset.translations[language].messages.size(), 2):
			if translationset.translations[language].messages[i] != "":
				message_list[translationset.translations[language].messages[i]] = translationset.translations[language].messages[i+1]
	add_messages()
	csv_file.close()
	SceneManager.change_scene("res://addons/TranslationDump/TranslationBox.tscn")

