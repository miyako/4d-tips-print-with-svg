//%attributes = {"invisible":true}
C_PICTURE:C286($1;$img)

$img:=$1

C_BLOB:C604($imgData)
PICTURE TO BLOB:C692($img;$imgData;".png")

C_TEXT:C284($dataUri)
BASE64 ENCODE:C895($imgData;$dataUri)

$0:="data:image/png;base64,"+$dataUri