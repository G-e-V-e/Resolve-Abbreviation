<#
.Synopsis
	Resolves abbreviation(s) to expanded string(s).
.DESCRIPTION
	The passed abbreviation(s) is/are checked against equally passed fully expanded string(s) and the latter is/are returned to the caller.
.Parameter Expanded
	The fully expanded string(s) that will be returned if abbreviation(s) is/are found.
.Parameter Abbreviated
	The abbreviation(s) to be checked against the expanded string(s).
.Parameter Split
	The regular expression to be used to split the exxpanded string(s) before doing the abbreviation check.
.Parameter Char
	The abbreviation string has to be interpreted as a char array.
.Inputs
   [string[]]Expanded
   [string[]]Abbreviated
.Outputs
   [string[]]Result
.EXAMPLE
	Checks the array of possible abbreviations 'a','ba' and 'cit' against the strings 'apple','banana' and 'cranberry'. Only those strings for which abbreviations are found are returned.
	Resolve-Abbreviation -Expanded apple,banana,cranberry -Abbreviated a,ba,cit
	==> apple,banana
.EXAMPLE
	Check the array of possible abbreviations 'a','ba' and 'cit' against the strings 'apple','banana' and 'cranberry'. Only those strings for which abbreviations are found are returned.
	Resolve-Abbreviation -Expanded apple,banana,cranberry -Abbreviated abc
	==> $null
	Resolve-Abbreviation -Expanded apple,banana,cranberry -Abbreviated abc -Char
	==> apple,banana,cranberry
.EXAMPLE
	Pass the expanded string value(s) from the pipeline, split in words using a regular expression and return those string(s) for which abbreviations are found.  
	'test | echo','Next / Pair','Last \ Option \ Available' | Resolve-Abbreviation -split ' \| | / | \\ ' -Abbreviated teno -char
	==> test,echo,Next,Option
	'test | echo','Next / Pair','Last \ Option \ Available' | Resolve-Abbreviation -split ' \| | / | \\ ' -Abbreviated te,pa
	==> test,Pair
	'test | echo','Then / Else','Last \ Option \ Available' | Resolve-Abbreviation -split ' \| | / | \\ ' -abb te,pa -char
	==> test,echo,Then,Else,Available
#>
Function Resolve-Abbreviation
{
[CmdletBinding()]
Param	(
		[Parameter(ValueFromPipeline=$true,Position=0)][Alias('Exp')][String[]]$Expanded,
		[Parameter(Position=1)][String]$Split,
		[Parameter(Position=2)][Alias('Abb')][String[]]$Abbreviated,
		[switch]$Char
		)
Begin	{if		($Char)			{$Abbreviated = $Abbreviated.ToCharArray()}}
Process	{if		($Split)		{$Expanded = $Expanded -Split $Split}
		switch	($Abbreviated)	{{$Expanded -like "$_*"}{$Expanded -like "$_*"}}
		}
}
