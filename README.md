# TranslationExtractorPlus
This tool is intended to extract translated dialog from the game using a pattern for identifying translation IDs found in the project files (typically written as DIALOG_NAME_1 or similar). The extracted CSV file will contain the translation IDs and their respective translations in the language chosen. 

# Requirements
 In order for the translation to work, the project needs to be running so the required objects can be setup. The following is required: 

 * The extracted project files as described in the [developer modding guide](https://wiki.cassettebeasts.com/wiki/Modding:Mod_Developer_Guide) 
 * The files from this repository added to the extracted project folder as described above.

# Installation Instructions 
* Download the zip file from this repository and extract the files from the zip folder.
* Move the ```TranslationDump``` folder into the ```addons``` folder of the extracted Cassette Beasts project files as seen below:

  Contents of the extracted folder.
  
  ![image](https://github.com/ninaforce13/TranslationExtractorPlus/assets/68625676/5c34dd66-a49b-49d6-ac9f-9f0186b0e26e)

  Location to move that folder into.
  
  ![image](https://github.com/ninaforce13/TranslationExtractorPlus/assets/68625676/d4f28f72-d082-4f80-95f7-3f75d35a022a)

  What it should look like inside the ```addons``` folder.
  
  ![image](https://github.com/ninaforce13/TranslationExtractorPlus/assets/68625676/aef464b3-90e8-44ca-9784-92271e12f0eb)

* Open the Cassette Beasts project in Godot and navigate to the ```TranslationDump``` folder inside the ```addons``` folder.

  ![image](https://github.com/ninaforce13/TranslationExtractorPlus/assets/68625676/cdd2dcc1-983d-4760-9e35-6a0aafdd18fe)

* Open the ```TranslationBox.tscn``` file and click the ```Play Scene``` button located at the top right of the screen.

  ![image](https://github.com/ninaforce13/TranslationExtractorPlus/assets/68625676/1de36fd8-1db7-46ba-8b91-a5d8b9d73d2e)

* After clicking ```PlayScene``` a new window will open to load the extraction UI. From here just choose a ```language```, click ```Extract Translations```, and select a location to save the translated file. The window will take a second to process the file, the dialog window will be open this entire time. When the window closes and you see the swirling animation then it is finished extracting.

  ![extraction_tutorial](https://github.com/ninaforce13/TranslationExtractorPlus/assets/68625676/3f379211-a91f-464e-bc6d-5e83a18a5570)

