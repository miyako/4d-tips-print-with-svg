//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
C_TEXT:C284($1)
C_OBJECT:C1216($0; $EXPORT)

$name:=Current method name:C684

If (Storage:C1525[$name]=Null:C1517)
	Use (Storage:C1525)
		$EXPORT:=New shared object:C1526
		Storage:C1525[$name]:=$EXPORT
	End use 
Else 
	$EXPORT:=Storage:C1525[$name]
End if 

$THIS_OBJECT_NAME:=Current method name:C684

If ($EXPORT[$THIS_OBJECT_NAME]=Null:C1517)
	
	Use ($EXPORT)
		
		$EXPORT.TEMP_FILE_NAME:=$THIS_OBJECT_NAME+".pdf"
		$EXPORT.PT_PER_MM:=2.83465
		$EXPORT.PT_PER_CM:=$EXPORT.MM_PER_PT*10
		$EXPORT.PT_PER_IN:=72
		$EXPORT.PT_PER_PC:=12
		
		$EXPORT.convertToPoints:=Formula:C1597(convertToPoints)
		$EXPORT.print:=Formula:C1597(print)
		
		$EXPORT[$THIS_OBJECT_NAME]:=Formula:C1597(This:C1470)
		
	End use 
	
End if 

$0:=$EXPORT