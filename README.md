Powershell Handy Helpers Module
===============================
[![CodeFactor](https://www.codefactor.io/repository/github/jhwohlgemuth/pwsh-handy-helpers/badge)](https://www.codefactor.io/repository/github/jhwohlgemuth/pwsh-handy-helpers)
[![Build Status](https://travis-ci.com/jhwohlgemuth/pwsh-handy-helpers.svg?branch=master)](https://travis-ci.com/jhwohlgemuth/pwsh-handy-helpers)
[![codecov](https://codecov.io/gh/jhwohlgemuth/pwsh-handy-helpers/branch/master/graph/badge.svg?token=3NMKOGN0Q8)](https://codecov.io/gh/jhwohlgemuth/pwsh-handy-helpers/)
[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/pwsh-handy-helpers)](https://www.powershellgallery.com/packages/pwsh-handy-helpers)
> Useful helpers, functions, utilities, wrappers, and aliases for things you might find yourself wanting to do on a somewhat regular basis.

Imagine you are trying to perform some technical task on Windows, like executing commands on remote computers. And then you think:
- It should be easier to enable remoting...
- ...and to execute commands on other computers
- ...by passing idiomatic scriptblocks,
- ...to functions that do stuff like shutdown the remote computer
- ...and speak to me
- ...and other totally reasonable stuff ([see function section](#Functions))

If you have ever had a similar thought train, this module might be for you!

> "It is almost like he just browsed the [awesome-powershell](https://github.com/janikvonrotz/awesome-powershell) repository, read some Powershell scripting blogs, and then added all his favorite functions and aliases into a grab-bag module..."  
*- Probably some people that are reading this README*


Quick Start
-----------

1. Install module
```powershell
Install-Module -Name pwsh-handy-helpers
```

2. Import module
```powershell
Import-Module pwsh-handy-helpers
```

Examples
--------
- Create a new file
```powershell
touch somefile.txt
```
- Create a new directory and then enter it
```powershell
take ~/path/to/some/folder
```
- Navigate folders without having to use `cd`
```powershell
# old busted
cd path/to/some/folder

# new hotness
path/to/some/folder
```
- Find duplicate files (based on hash of content)
```powershell
Get-Location | Find-Duplicate
```
- Perform various operations on strings
```powershell
$abc = "b" | insert -To "ac" -At 2
$abc = "abcd" | remove -Last
```
- Leverage higher-order functions like reduce to add the first 100 integers (Just like Gauss!)
```powershell
$Sum = 1..100 | reduce -Callback { Param($a, $b) $a + $b } -InitialValue 0
```
- Exexute code on a remote computer
```powershell
{ whoami } | irc -ComputerNames PCNAME
```
- Make your computer talk
```powershell
say "Hello World"
```
- Make a remote computer talk
```powershell
{ say "Hello World" } | irc -ComputerNames PCNAME
```
- Use events to communicate within your script/app
```powershell
{ "Event triggered" | Write-Color -Red } | on "SomeEvent"

# You can even listen to variables!!!
# Declare a value for boot
$boot = 42
# Create a callback
$Callback = {
  $Data = $Event.MessageData
  say "$($Data.Name) was changed from $($Data.OldValue), to $($Data.Value)"
}
# Start the variable listener
$Callback | listenTo "boot" -Variable
# Change the value of boot and have your computer tell you what changed
$boot = 43
```
- Create an interactive CLI app (see the [./kitchensink.ps1](./kitchensink.ps1) for another example)
```powershell
Write-Title "Example"
$fullname = input "Full Name?" -Indent 4
$username = input "Username?" -MaxLength 10 -Indent 4
$age = input "Age?" -Number -Indent 4
$pass = input "Password?" -Secret -Indent 4
$word = input "Favorite Saiya-jin?" -Autocomplete -Indent 4 -Choices @(
  'Goku'
  'Gohan'
  'Goten'
  'Vegeta'
  'Trunks'
)
Write-Label 'Favorite number?' -Indent 4 -NewLine
$choice = menu @('one'; 'two'; 'three') -Indent 4
```
- Visualize file sizes in a directory with one line of code!
```powershell
Get-ChildItem -File | Invoke-Reduce -FileInfo | Show-BarChart
```

### And much more! Check out the [functions](#Functions) and [aliases](#Aliases) sections below for details

Functions
---------
> Use `Get-Help <Function-Name>` to see usage details. **Example**: `Get-Help Find-Duplicates -examples`

- `ConvertTo-PowershellSyntax`
- `Enable-Remoting`
- `Find-Duplicate`
- `Find-FirstIndex`
- `Get-File`
- `Install-SshServer`
- `Invoke-FireEvent`
- `Invoke-Input`
- `Invoke-InsertString`
- `Invoke-ListenTo`
- `Invoke-ListenForWord`
- `Invoke-Menu`
- `Invoke-Once`
- `Invoke-Reduce`
- `Invoke-RemoteCommand`
- `Invoke-Speak`
- `Join-StringsWithGrammar`
- `New-DailyShutdownJob`
- `New-File`
- `New-ProxyCommand`
- `New-SshKey`
- `New-Template`
- `Open-Session`
- `Out-Default`
- `Remove-Character`
- `Remove-DailyShutdownJob`
- `Remove-DirectoryForce`
- `Show-BarChart`
- `Take`
- `Test-Admin`
- `Test-Empty`
- `Test-Equal`
- `Test-Installed`
- `Use-Grammar`
- `Use-Speech`
- `Write-Color`
- `Write-Label`
- `Write-Title`

Aliases
-------
> Use `Get-Alias <Name>` to see alias details. **Example**: `Get-Alias dra`

- `~`
- `dip`
- `dra`
- `drai`
- `equal`
- `g`
- `gcam`
- `gd`
- `gpom`
- `grbi`
- `gsb`
- `input`
- `insert`
- `irc`
- `la`
- `listenFor`
- `listenTo`
- `ls`
- `menu`
- `on`
- `reduce`
- `remove`
- `repeat`
- `rf`
- `say`
- `touch`
- `tpl`
- `trigger`
