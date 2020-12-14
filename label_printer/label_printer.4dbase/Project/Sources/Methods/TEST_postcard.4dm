//%attributes = {}
/*

コンポーネントとして使用する場合
label_printer
が唯一の共有メソッド

*/

$label_printer:=label_printer 

$params:=New object:C1471
$params.data:=ds:C1482.PERSON.all().toCollection()
$params.toPdf:=True:C214  //印刷ではなくPDFファイルを出力する
$params.template:=Folder:C1567(fk resources folder:K87:11).file("postcard.svg")
$params.orientation:=1
$params.printGridLines:=False:C215  //用紙の升目を表示するか
$params.paperWidth:=$label_printer.convertToPoints("100mm")
$params.paperHeight:=$label_printer.convertToPoints("148mm")

$PDF:=$label_printer.print($params)

If (Bool:C1537($params.toPdf))
	OPEN URL:C673($PDF.platformPath)
End if 