Param (
	[string]$Filename
)

$contents = gc $Filename
$regex = '{{([a-zA-Z_0-9]+)}}'

[regex]::Matches($contents,$regex) |
foreach {
	$org = $_.groups[0].value
	$repl = iex ('$env:' + $_.groups[1].value)
	if ($repl) {
		$contents = $contents.replace($org,$repl)
	}
}
$contents | set-content $Filename
