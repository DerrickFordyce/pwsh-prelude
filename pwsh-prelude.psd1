﻿@{
  ModuleVersion = '0.0.26'
  RootModule = 'pwsh-prelude.psm1'
  GUID = '5af3199a-e01b-4ed6-87ad-fdea39aa7e77'
  CompanyName = 'Wohlgemuth Technology Foundation'
  Author = 'Jason Wohlgemuth'
  Copyright = '(c) 2020 Jason Wohlgemuth. All rights reserved.'
  Description = 'A "standard" library for PowerShell inspired by the preludes of other languages'
  PowerShellVersion = '5.0'
  FileList = @()
  CmdletsToExport = @()
  VariablesToExport = @()
  TypesToProcess = @(
    'types\Int.Types.ps1xml'
    'types\String.Types.ps1xml'
    'types\Array.Types.ps1xml'
    'types\Hashtable.Types.ps1xml'
    'types\Matrix.Types.ps1xml'
    'types\FileInfo.Types.ps1xml'
  )
  AliasesToExport = @(
    '~'
    'basicauth'
    'chunk'
    'dip'
    'dra'
    'drai'
    'dropWhile'
    'equal'
    'flatten'
    'fromPair'
    'input'
    'insert'
    'invert'
    'irc'
    'listenFor'
    'listenTo'
    'matrix'
    'max'
    'menu'
    'merge'
    'method'
    'min'
    'money'
    'on'
    'op'
    'partition'
    'plain'
    'permute'
    'prop'
    'reduce'
    'remove'
    'repeat'
    'rf'
    'say'
    'tap'
    'takeWhile'
    'title'
    'touch'
    'tpl'
    'toPair'
    'transform'
    'trigger'
    'screenshot'
    'unzip'
    'zip'
    'zipWith'
  )
  FunctionsToExport = @(
    'ConvertFrom-ByteArray'
    'ConvertFrom-Html'
    'ConvertFrom-Pair'
    'ConvertFrom-QueryString'
    'ConvertTo-PowershellSyntax'
    'ConvertTo-Iso8601'
    'ConvertTo-Pair'
    'ConvertTo-PlainText'
    'ConvertTo-QueryString'
    'Enable-Remoting'
    'Find-Duplicate'
    'Find-FirstIndex'
    'Format-MoneyValue'
    'Get-Extremum'
    'Get-Factorial'
    'Get-File'
    'Get-GithubOAuthToken'
    'Get-HostsContent'
    'Get-Maximum'
    'Get-Minimum'
    'Get-Permutation'
    'Get-Screenshot'
    'Get-State'
    'Home'
    'Import-Html'
    'Install-SshServer'
    'Invoke-Chunk'
    'Invoke-DockerInspectAddress'
    'Invoke-DockerRemoveAll'
    'Invoke-DockerRemoveAllImage'
    'Invoke-DropWhile'
    'Invoke-Flatten'
    'Invoke-FireEvent'
    'Invoke-GetProperty'
    'Invoke-GitCommand'
    'Invoke-GitCommit'
    'Invoke-GitDiff'
    'Invoke-GitPushMaster'
    'Invoke-GitStatus'
    'Invoke-GitRebase'
    'Invoke-GitLog'
    'Invoke-Input'
    'Invoke-InsertString'
    'Invoke-ListenTo'
    'Invoke-ListenForWord'
    'Invoke-Menu'
    'Invoke-Method'
    'Invoke-ObjectInvert'
    'Invoke-ObjectMerge'
    'Invoke-Once'
    'Invoke-Operator'
    'Invoke-Partition'
    'Invoke-PropertyTransform'
    'Invoke-Reduce'
    'Invoke-RemoteCommand'
    'Invoke-RunApplication'
    'Invoke-Speak'
    'Invoke-TakeWhile'
    'Invoke-Tap'
    'Invoke-Unzip'
    'Invoke-WebRequestBasicAuth'
    'Invoke-Zip'
    'Invoke-ZipWith'
    'Join-StringsWithGrammar'
    'New-ApplicationTemplate'
    'New-DailyShutdownJob'
    'New-File'
    'New-Matrix'
    'New-ProxyCommand'
    'New-SshKey'
    'New-Template'
    'Open-Session'
    'Remove-Character'
    'Remove-DailyShutdownJob'
    'Remove-DirectoryForce'
    'Remove-Indent'
    'Rename-FileExtension'
    'Save-State'
    'Show-BarChart'
    'Take'
    'Test-Admin'
    'Test-DiagonalMatrix'
    'Test-Empty'
    'Test-Equal'
    'Test-Installed'
    'Test-SquareMatrix'
    'Test-SymmetricMatrix'
    'Update-HostsFile'
    'Use-Grammar'
    'Use-Speech'
    'Use-Web'
    'Write-Color'
    'Write-Label'
    'Write-Repeat'
    'Write-Title'
  )
  PrivateData = @{
    PSData = @{
      Tags = @('dev', 'helpers', 'git', 'docker', 'fp', 'cli', 'app', 'scrapp')
      LicenseUri = 'https://github.com/jhwohlgemuth/pwsh-prelude/blob/master/LICENSE'
      ProjectUri = 'https://github.com/jhwohlgemuth/pwsh-prelude'
    }
  }
}
