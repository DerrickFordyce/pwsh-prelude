﻿function ConvertTo-Iso8601 {
  [CmdletBinding()]
  Param(
    [Parameter(Position=0, ValueFromPipeline=$true)]
    [String] $Value
  )
  $Value | Get-Date -UFormat '+%Y-%m-%dT%H:%M:%S.000Z'
}
function ConvertTo-QueryString {
  <#
  .SYNOPSIS
  Returns URL-encoded query string
  #>
  [CmdletBinding()]
  [OutputType([String])]
  Param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [PSObject] $InputObject,
    [Switch] $UrlEncode
  )
  $Callback = {
    Param($Acc, $Item)
    $Key = $Item.Name
    $Value = $Item.Value
    "${Acc}$(if ($Acc -ne '') { '&' } else { '' })${Key}=${Value}"
  }
  $QueryString = $InputObject.GetEnumerator() | Sort-Object Name | Invoke-Reduce $Callback ''
  if ($UrlEncode) {
    Add-Type -AssemblyName System.Web
    [System.Web.HttpUtility]::UrlEncode($QueryString)
  } else {
    $QueryString
  }
}
function Import-Html {
  <#
  .SYNOPSIS
  Import and parse an a local HTML file or web page.
  .EXAMPLE
  Import-Html example.com | ForEach-Object { $_.body.innerHTML }
  .EXAMPLE
  Import-Html .\bookmarks.html | ForEach-Object { $_.all.tags('a') } | Selelct-Object -ExpandProperty textContent
  #>
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Alias('Uri')]
    [String] $Path
  )
  if (Test-Path $Path) {
    $Content = Get-Content -Path $Path -Raw
  } else {
    $Content = (Invoke-WebRequest -Uri $Path).Content
  }
  $Html = New-Object -ComObject "HTMLFile"
  $Html.IHTMLDocument2_write($Content)
  $Html
}
function Invoke-WebRequestBasicAuth {
  <#
  .SYNOPSIS
  Invoke-WebRequest wrapper that makes it easier to use basic authentication
  .PARAMETER TwoFactorAuthentication
  Name of API that requires 2FA. Use 'none' when 2FA is not required.

  Possible values:
  - 'Github'
  - 'none' [Default]

  .PARAMETER Data
  Data (Body) payload for HTTP request. Will only function with PUT and POST requests.
  ==> Analogous to the '-d' cURL flag
  ==> Data object will be converted to JSON string
  .EXAMPLE
  # Authenticate a GET request with a token
  $Uri = 'https://api.github.com/notifications'
  $Query = @{ per_page = 100; page = 1 }
  $Request = Invoke-WebRequestBasicAuth $Token -Uri $Uri -Query $Query
  $Request.Content | ConvertFrom-Json | Format-Table -AutoSize

  .EXAMPLE
  # Use basic authentication with a username and password
  $Uri = 'https://api.github.com/notifications'
  $Query = @{ per_page = 100; page = 1 }
  $Request = Invoke-WebRequestBasicAuth $Username -Password $Token -Uri $Uri -Query $Query
  $Request.Content | ConvertFrom-Json | Format-Table -AutoSize

  .EXAMPLE
  # Execute a PUT request with a data payload
  $Uri = 'https://api.github.com/notifications'
  @{ last_read_at = '' } | BasicAuth $Token -Uri $Uri -Put

  #>
  [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Scope='Function')]
  [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '')]
  [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', 'Password')]
  [CmdletBinding(DefaultParameterSetName='token')]
  [Alias('basicauth')]
  Param(
    [Parameter(ParameterSetName='basic', Position=0)]
    [String] $Username,
    [Parameter(ParameterSetName='basic')]
    [String] $Password,
    [Parameter(ParameterSetName='token', Position=0)]
    [String] $Token,
    [Parameter(Mandatory=$true)]
    [UriBuilder] $Uri,
    [PSObject] $Query = @{},
    [Switch] $UrlEncode,
    [Alias('OTP')]
    [String] $TwoFactorAuthentication = 'none',
    [Switch] $Get,
    [Switch] $Post,
    [Switch] $Put,
    [Switch] $Delete,
    [Parameter(ValueFromPipeline=$true)]
    [PSObject] $Data = @{}
  )
  Process {
    $Authorization = if ($Token.Length -gt 0) {
      "Bearer $Token"
    } else {
      $Credential = [Convert]::ToBase64String([System.Text.Encoding]::Ascii.GetBytes("${Username}:${Password}"))
      "Basic $Credential"
    }
    $Headers = @{
      Authorization = $Authorization
    }
    switch ($TwoFactorAuthentication) {
      'github' {
        'GitHub 2FA' | Write-Title -Green
        $Code = 'Code:' | Invoke-Input -Number -Indent 4
        $Headers.Accept = 'application/vnd.github.v3+json'
        $Headers['x-github-otp'] = $Code
      }
      Default {
        # Do nothing
      }
    }
    $Method = Find-FirstTrueVariable 'Get','Post','Put','Delete'
    $Uri.Query = $Query | ConvertTo-QueryString -UrlEncode:$UrlEncode
    $Parameters = @{
      Headers = $Headers
      Method = $Method
      Uri = $Uri.Uri
    }
    "==> Headers: $($Parameters.Headers | ConvertTo-Json)" | Write-Verbose
    "==> Method: $($Parameters.Method)" | Write-Verbose
    "==> URI: $($Parameters.Uri)" | Write-Verbose
    if ($Method -in 'Post','Put') {
      $Parameters.Body = $Data | ConvertTo-Json
      "==> Data: $($Data | ConvertTo-Json)" | Write-Verbose
    }
    Invoke-WebRequest @Parameters
  }
}
function Invoke-WebRequestOAuth {
  [CmdletBinding()]
  [Alias('oauth')]
  Param()

}