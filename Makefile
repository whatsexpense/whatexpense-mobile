projectname := whatsexpense

# paths
localization_path := ./$(projectname)/Resources/Localization/Localizable.xcstrings

# Localization Generation
import_localization:
	xcodebuild -importLocalizations -project $(projectname) -localizationPath $(localization_path)

export_localization:
	xcodebuild -exportLocalizations -localizationPath $(localization_path) -exportLanguage es -exportLanguage vi
