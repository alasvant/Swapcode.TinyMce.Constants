# ©2018 Antti Alasvuo

#stop execution on error
$ErrorActionPreference = "Stop"


# generated class full file path and name
sv -Name outFileNameTemplate -Option Constant -Value "..\{0}.cs"

# set constant class footer
sv -Name $sharedfooter -Option Constant -Value @"
`t}
}
"@

# set constant class header template (requires double '{{' because of format in multi-line)
sv -Name classHeaderTemplate -Option Constant -Value @"
// This file was generated: {2}
// Constant values are scraped from web page: https://www.tinymce.com/docs/advanced/editor-control-identifiers/
// Content on the web page is licensed under: https://creativecommons.org/licenses/by-nc-sa/3.0/ (https://creativecommons.org/licenses/by-nc-sa/3.0/legalcode)
// And the same license is forced on this file.
// ©2018 Antti Alasvuo

namespace Swapcode.TinyMce.Constants
{{
`t/// <summary>
`t/// {0}
`t/// </summary>
`tpublic static class {1}
`t{{
"@

# core constant template
sv -Name coreConstantTemplate -Option Constant -Value @"
`t`t/// <summary>
`t`t/// {0}
`t`t/// </summary>
`t`tpublic const string {1} = "{2}";

"@

# plugin constant template
sv -Name pluginConstantTemplate -Option Constant -Value @"
`t`t/// <summary>
`t`t/// {0} NOTE! Requires plugin: {1}.
`t`t/// </summary>
`t`tpublic const string {2} = "{3}";

"@

# function to generate TinyMCE constant classes
function Generate-TinymceConstantsClass{
	param([parameter(Mandatory=$true)][string]$className,
		[parameter(Mandatory=$true)][string]$classDescription,
		[parameter(Mandatory=$true)][bool]$core,
		$csv)

	$items = if($core) {
		$csv | Where-Object { $_.Plugin -eq 'core'}
	}
	else {
		$csv | Where-Object { $_.Plugin -ne 'core'}
	}

	$classHeaderTemplate -f $classDescription,$className,(Get-Date -Format "yyyy-MM-dd HH:mm.ss")

	$items | ForEach-Object {
		if($core){
			$coreConstantTemplate -f $_.Description,(Get-Culture).TextInfo.ToTitleCase($_.Id),$_.Id
		}
		else {
			$pluginConstantTemplate -f $_.Description,$_.Plugin,(Get-Culture).TextInfo.ToTitleCase($_.Id),$_.Id
		}
	}

	$sharedfooter
}

# function to generate TinyMCE plugin names constant class
function Generate-TinymcePluginNameConstantClass{
	param($csv)

	$classHeaderTemplate -f "Contains TinyMCE plugin names that has a toolbar and/or menubar button. For full list see: https://www.tinymce.com/docs/plugins/.","PluginNames",(Get-Date -Format "yyyy-MM-dd HH:mm.ss")

	$csv | Where-Object {$_.Plugin -ne 'core'} | select -ExpandProperty Plugin -Unique | Sort-Object | ForEach-Object {
		$coreConstantTemplate -f ('Plugin name: '+$_),(Get-Culture).TextInfo.ToTitleCase($_),$_
	}

	$sharedfooter
}

# the csv file doesn have header because the would be a special character in the column name so here defining the columns
$CsvHeader = "Id", "Plugin", "Description"

# CSV file, first use the toolbar identifiers
$csvtoolbar = Import-Csv .\toolbar-identifiers.csv -Header $CsvHeader

$className = "ToolbarControlIdentifiers"
Generate-TinymceConstantsClass $className 'Contains TinyMCE core toolbar control identifiers (https://www.tinymce.com/docs/advanced/editor-control-identifiers/#toolbarcontrols).' $true $csvtoolbar | Out-File ($outFileNameTemplate -f $className)

$className = "ToolbarPluginControlIdentifiers"
Generate-TinymceConstantsClass $className 'Contains TinyMCE plugin toolbar control identifiers (https://www.tinymce.com/docs/advanced/editor-control-identifiers/#toolbarcontrols).' $false $csvtoolbar | Out-File ($outFileNameTemplate -f $className)


# switch CSV file to the menubar identifiers
$csvmenubar = Import-Csv .\menubar-identifiers.csv -Header $CsvHeader

$className = "MenubarControlIdentifiers"
Generate-TinymceConstantsClass $className 'Contains TinyMCE core menubar control identifiers (https://www.tinymce.com/docs/advanced/editor-control-identifiers/#menucontrols).' $true $csvmenubar | Out-File ($outFileNameTemplate -f $className)

$className = "MenubarPluginControlIdentifiers"
Generate-TinymceConstantsClass $className 'Contains TinyMCE plugin menubar control identifiers (https://www.tinymce.com/docs/advanced/editor-control-identifiers/#menucontrols).' $false $csvmenubar | Out-File ($outFileNameTemplate -f $className)

# merge the CSV files and create a class that has the plugin names
# note that this list only contains plugin names that have toolbar and/or menubar button
$csvcontent = $csvtoolbar + $csvmenubar
Generate-TinymcePluginNameConstantClass $csvcontent | Out-File ..\PluginNames.cs