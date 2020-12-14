//%attributes = {"invisible":true}
TRUNCATE TABLE:C1051([PERSON:1])
SET DATABASE PARAMETER:C642([PERSON:1];Table sequence number:K37:31;0)

$o:=New object:C1471
$o.chars:=New collection:C1472
For ($i;Character code:C91("あ");Character code:C91("ん"))
	$o.chars.push(Char:C90($i))
End for 

$o.nums:=New collection:C1472
For ($i;Character code:C91("0");Character code:C91("9"))
	$o.nums.push(Char:C90($i))
End for 

$o.getOne:=Formula:C1597(This:C1470.chars[Random:C100%This:C1470.chars.length])
$o.getNum:=Formula:C1597(This:C1470.nums[Random:C100%This:C1470.nums.length])

READ PICTURE FILE:C678(Folder:C1567(fk resources folder:K87:11).file("4D.png").platformPath;$icon)

For ($i;1;20)
	
	$person:=ds:C1482.PERSON.new()
	
	For ($ii;1;10)
		$person.name:=$person.name+$o.getOne()
	End for 
	
	For ($ii;1;30)
		$person.address:=$person.address+$o.getOne()
	End for 
	
	For ($ii;1;7)
		$person.postcode:=$person.postcode+$o.getNum()
	End for 
	
	$person.photo:=$icon
	$person.save()
	
End for 