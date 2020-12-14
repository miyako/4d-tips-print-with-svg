//%attributes = {"invisible":true,"preemptive":"incapable"}
/*

thread unsafe method (contains printing commands)
this is a semaphore; we can only have one printing process at a time
	
*/

Use (Storage:C1525)
	Storage:C1525.printing:=New shared object:C1526
End use 

C_OBJECT:C1216($1;$2)

$params:=$1
$signal:=$2

C_BOOLEAN:C305($printPreview;$toPdf)
$printPreview:=$params.printPreview
$toPdf:=$params.toPdf

If ($toPdf)
	$folder:=Folder:C1567(Temporary folder:C486;fk platform path:K87:2).folder(Generate UUID:C1066)
	$folder.create()
	$file:=$folder.file($signal.fileName)
End if 

$template:=$params.template.getText()

Use (Storage:C1525.printing)
	
	SET PRINT OPTION:C733(Hide printing progress option:K47:12;1)
	
	C_LONGINT:C283($marginLeft;$marginTop;$marginRight;$marginBottom)
	GET PRINTABLE MARGIN:C711($marginLeft;$marginTop;$marginRight;$marginBottom)
	SET PRINTABLE MARGIN:C710(0;0;0;0)
	
	If ($toPdf)
		SET PRINT PREVIEW:C364(False:C215)
		SET PRINT OPTION:C733(Spooler document name option:K47:10;$file.fullName)
		SET PRINT OPTION:C733(Paper option:K47:1;"A4")
	Else 
		SET PRINT PREVIEW:C364($printPreview)
	End if 
	
	GET PRINT OPTION:C734(Orientation option:K47:2;$orientation)
	SET PRINT OPTION:C733(Orientation option:K47:2;Num:C11($params.orientation))
	
	If ($params.paperWidth#Null:C1517) & ($params.paperHeight#Null:C1517)
		SET PRINT OPTION:C733(Paper option:K47:1;Num:C11($params.paperWidth);Num:C11($params.paperHeight))
	End if 
	
	C_LONGINT:C283($paperWidth;$paperHeight)
	GET PRINTABLE AREA:C703($paperHeight;$paperWidth)
	$paperWidth:=$paperWidth+1
	$paperHeight:=$paperHeight+1
	
	If ($toPdf)
		If (Is Windows:C1573)
			$currentPrinter:=Get current printer:C788
			SET CURRENT PRINTER:C787(Generic PDF driver:K47:15)
			SET PRINT OPTION:C733(Destination option:K47:7;2;$file.platformPath)
		Else 
			SET PRINT OPTION:C733(Destination option:K47:7;3;$file.platformPath)
		End if 
	End if 
	
	$params.init:=Formula:C1597(This:C1470.max:=$1)
	$params.start:=Formula:C1597(This:C1470.index:=0)
	$params.next:=Formula:C1597(This:C1470.index:=This:C1470.index+1)
	
	$params.get:=Formula:C1597(This:C1470.data[This:C1470.index+This:C1470.offset])
	
	  //the number of records to print
	$params.getTotal:=Formula:C1597(This:C1470.data.length)
	
	  //the number of records printed
	$params.getLength:=Formula:C1597(This:C1470.getTo()-This:C1470.from)
	
	  //the number of records not printed
	$params.getRemaining:=Formula:C1597(This:C1470.getTotal()-This:C1470.from)
	
	$params.getTo:=Formula:C1597(This:C1470.from+Choose:C955(This:C1470.getRemaining()<=This:C1470.max;This:C1470.getRemaining();This:C1470.max))
	
	  //the number of records to skip
	$params.offset:=0
	
	  //the first record to print
	$params.from:=0
	
	OPEN PRINTING JOB:C995
	FORM LOAD:C1103("SVG")
	OBJECT SET RGB COLORS:C628(*;"SVG";Foreground color:K23:1;Background color none:K23:10)
	
	OBJECT Get pointer:C1124(Object named:K67:5;"SVG")->:=m_process_template ($template;$params)
	$printed:=Print object:C1095(*;"SVG";0;0;$paperWidth;$paperHeight)
	
	  //only available here because the .max is computed inside the template
	$params.to:=$params.getTo()
	
	While ($params.getTo()<$params.getTotal())
		
		PAGE BREAK:C6(>)
		
		$params.from:=$params.to
		$params.offset:=$params.offset+$params.getLength()
		$params.to:=$params.getTo()
		
		OBJECT Get pointer:C1124(Object named:K67:5;"SVG")->:=m_process_template ($template;$params)
		$printed:=Print object:C1095(*;"SVG";0;0;$paperWidth;$paperHeight)
		
	End while 
	
	FORM UNLOAD:C1299
	CLOSE PRINTING JOB:C996
	
/*
		
restore settings
		
*/
	
	SET PRINT OPTION:C733(Orientation option:K47:2;$orientation)
	SET PRINTABLE MARGIN:C710($marginLeft;$marginTop;$marginRight;$marginBottom)
	If ($toPdf)
		If (Is Windows:C1573)
			SET CURRENT PRINTER:C787($currentPrinter)
		End if 
		SET PRINT PREVIEW:C364($printPreview)
	End if 
	
End use 

/*
	
quit gracefully
	
*/

If (Not:C34(Process aborted:C672))
	If ($toPdf)
		Use ($signal)
			$signal.path:=$file.platformPath
		End use 
	End if 
	$signal.trigger()
Else 
	KILL WORKER:C1390
End if 