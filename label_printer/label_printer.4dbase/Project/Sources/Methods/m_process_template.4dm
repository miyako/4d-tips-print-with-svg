//%attributes = {"invisible":true}
C_TEXT:C284($1;$template;$processedTemplate)
C_OBJECT:C1216($2;$data)

$template:=$1
$data:=$2

C_BLOB:C604($svgData)
PROCESS 4D TAGS:C816($template;$processedTemplate;$data)
CONVERT FROM TEXT:C1011($processedTemplate;"utf-8";$svgData)

C_PICTURE:C286($0;$SVG)
BLOB TO PICTURE:C682($svgData;$SVG;".svg")

$0:=$SVG