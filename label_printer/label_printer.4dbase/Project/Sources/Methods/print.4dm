//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1; $params; $2; $signal)
C_OBJECT:C1216($0; $file)

$cp:=Count parameters:C259

Case of 
	: ($cp=0)
		
		$0:=New shared object:C1526("error"; "$1 is missing!")
		
	: ($cp=1)
		
		$TEMP_FILE_NAME:=This:C1470.TEMP_FILE_NAME
		
		$params:=$1
		
		$signal:=New signal:C1641
		
/*
		
because "Get print preview" scope is the process
we need to pass a parameter from the caller
		
		
*/
		
		C_TEXT:C284($name)
		C_LONGINT:C283($state; $time; $mode)
		PROCESS PROPERTIES:C336(Current process:C322; $name; $state; $time; $mode)
		C_BOOLEAN:C305($printPreview)
		If ($mode ?? 0)
			//%T-
			$printPreview:=Get print preview:C1197
			//%T+
		End if 
		
		Use ($signal)
			$signal.fileName:=$TEMP_FILE_NAME
			$signal.printPreview:=$printPreview
		End use 
		
		//%T-
		CALL WORKER:C1389(Current method name:C684; "print_w"; $params; $signal)
		//%T+
		
		C_TEXT:C284($path)
		
		If ($signal.wait())
			Use ($signal)
				$path:=$signal.path
			End use 
			$file:=File:C1566($path; fk platform path:K87:2)
		End if 
		
		$0:=$file
		
End case 