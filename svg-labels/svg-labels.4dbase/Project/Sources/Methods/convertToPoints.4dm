//%attributes = {"invisible":true}
C_TEXT:C284($1;$value)
C_REAL:C285($0;$convertedValue)

$value:=$1
$convertedValue:=Num:C11($value)

Case of 
	: (Position:C15("mm";$value)#0)
		$convertedValue:=$convertedValue*This:C1470.PT_PER_MM
	: (Position:C15("cm";$value)#0)
		$convertedValue:=$convertedValue*This:C1470.PT_PER_CM
	: (Position:C15("in";$value)#0)
		$convertedValue:=$convertedValue*This:C1470.PT_PER_IN
	: (Position:C15("pc";$value)#0)
		$convertedValue:=$convertedValue*This:C1470.PT_PER_PC
End case 

$0:=$convertedValue