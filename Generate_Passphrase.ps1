# Generates Passphrases
# Stolen from http://www.hanselman.com/blog/DictionaryPasswordGeneratorInPowershell.aspx
# Can take a variable for the # of passwords to generate, or how long the passwords should be
# 

[CmdletBinding()]
param (
	[Parameter( Mandatory=$false)]
	[int]$PasswordsToGenerate=30,

	[Parameter( Mandatory=$false)]
	[int]$MaxPasswordLength=16
	
	)

$rand = new-object System.Random
$conjunction = "The","My","We","Our","And","But","For","So","Not","To","Any"
$special = "%","*","+","&","."
$number = "1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"
$separator = ",","-","_","."
$words = Get-Content '.\wordlist.txt'
#$max_pw_length = 12


	
Function Generate1Passphrase {
	$word1 = ($words[$rand.Next(0,$words.Count)])
	$con = ($conjunction[$rand.Next(0,$conjunction.Count)])
	$word2 = ($words[$rand.Next(0,$words.Count)])
	$num = ($number[$rand.Next(0,$number.Count)])
	$sep1 = ($separator[$rand.Next(0,$separator.Count)])
	$sep2 = ($separator[$rand.Next(0,$separator.Count)])
	$sc = ($special[$rand.Next(0,$special.Count)])
	
	#$result = $word1 + $sep1 + $con + $sep1 + $word2 + $sc + $num
	$result = $word1 + $sep1 + $con + $sep1 + $word2 + $num
	return $result
	}

<# # test if a variable is passed, if not generate 30 passwords
if (!$args[0]){
	$GenNo = 30	}
	Else{
	$GenNo = $args[0] } #>

for ($ii = 1; $ii -le $PasswordsToGenerate; $ii++){
	$PF_Test = Generate1Passphrase
	while ($PF_Test.length -gt $MaxPasswordLength){
		$PF_Test = Generate1Passphrase
		}
	$Result = $PF_Test
	

	Write-Host -NoNewLine $PF_Test "`t" "$($PF_Test.length)" "`r`n"
	
	}
