Import-Module ./pwsh-handy-helpers.psm1

Describe "Find-Duplicates" {
    It "can identify duplicate files" {
        # Under construction
    }
}
Describe "Join-StringsWithGrammar" {
    It "accepts one parameter" {
        Join-StringsWithGrammar @("one") | Should -Be "one"
    }
    It "accepts two parameter" {
        Join-StringsWithGrammar @("one", "two") | Should -Be "one and two"
    }
    It "accepts three or more parameters" {
        Join-StringsWithGrammar @("one", "two", "three") | Should -Be "one, two, and three"
        Join-StringsWithGrammar @("one", "two", "three", "four") | Should -be "one, two, three, and four"
    }
}
Describe "New-File (touch)" {
    AfterAll {
        Remove-Item -Path .\SomeFile
    }
    It "can create a file" {
        $Content = "testing"
        ".\SomeFile" | Should -Not -Exist
        New-File SomeFile
        Write-Output $Content >> .\SomeFile
        ".\SomeFile" | Should -FileContentMatch $Content
    }
}
Describe "New-Template" {
    Context "when passed an empty object" {
        $script:Expected = "<div>Hello </div>"
        It "can return function that accepts positional parameter" {
            $function:render = New-Template '<div>Hello {{ name }}</div>'
            render @{} | Should -Be $Expected
        }
        It "can return function when instantiated as function variable" {
            $function:render = New-Template -Template '<div>Hello {{ name }}</div>'
            render @{} | Should -Be $Expected
        }
        It "can return function when instantiated as normal variable" {
            $renderVariable = New-Template -Template '<div>Hello {{ name }}</div>'
            & $renderVariable @{} | Should -Be $Expected
        }
    }
    It "can create function from template string using mustache notation" {
        $Expected = "<div>Hello World!</div>"
        $function:render = New-Template '<div>Hello {{ name }}!</div>'
        render @{ name = "World" } | Should -Be $Expected
        @{ name = "World" } | render | Should -Be $Expected
    }
    It "can create function from template string using Powershell syntax" {
        $Expected = "<div>Hello World!</div>"
        $function:render = New-Template '<div>Hello $($Data.name)!</div>'
        render @{ name = "World" } | Should -Be $Expected
        @{ name = "World" } | render | Should -Be $Expected
    }
    It "can be nested within other templates" {
        $Expected = "<section>
            <h1>Title</h1>
            <div>Hello World!</div>
        </section>"
        $div = New-Template -Template '<div>{{ text }}</div>'
        $section = New-Template "<section>
            <h1>{{ title }}</h1>
            $(& $div @{text = "Hello World!"})
        </section>"
        & $section @{ title = "Title" } | Should -Be $Expected
    }
    It "can be nested within other templates (with Powershell syntax)" {
        $Expected = "<section>
            <h1>Title</h1>
            <div>Hello World!</div>
        </section>"
        $div = New-Template -Template '<div>{{ text }}</div>'
        $section = New-Template "<section>
            <h1>`$(`$Data.title)</h1>
            $(& $div @{text = "Hello World!"})
        </section>"
        & $section @{ title = "Title" } | Should -Be $Expected
    }
}
Describe "Remove-DirectoryForce (rf)" {
    It "can create a file" {
        New-File SomeFile
        ".\SomeFile" | Should -Exist
        Remove-DirectoryForce .\SomeFile
        ".\SomeFile" | Should -Not -Exist
    }
}
# Describe "Test-Admin" {
#     It "should return false if not Administrator" {
#         Test-Admin | Should -Be $false
#     }
# }
Describe "Test-Empty" {
    It "should return true for directories with no contents" {
        "TestDrive:\Foo" | Should -Not -Exist
        mkdir "TestDrive:\Foo"
        "TestDrive:\Foo" | Should -Exist
        Test-Empty "TestDrive:\Foo" | Should -Be $true
        mkdir "TestDrive:\Foo\Bar"
        mkdir "TestDrive:\Foo\Bar\Baz"
        Test-Empty "TestDrive:\Foo" | Should -Be $false
    }
}
Describe "Test-Installed" {
    It "should return true if passed module is installed" {
        Test-Installed Pester | Should -Be $true
        Test-Installed NotInstalledModule | Should -Be $false
    }
}
Describe "Invoke-Speak (say)" {
    It "can passthru text without speaking" {
        $Text = "this should not be heard"
        Invoke-Speak $Text -Silent | Should -Be $Text
    }
    It "can output SSML" {
        $Text = "this should not be heard either"
        Invoke-Speak $Text -Silent -Output ssml | Should -Match "<p>$Text</p>"
    }
    It "can output SSML with custom rate" {
        $Text = "this should not be heard either"
        $Rate = 10
        Invoke-Speak $Text -Silent -Output ssml -Rate $Rate | Should -Match "<p>$Text</p>"
        Invoke-Speak $Text -Silent -Output ssml -Rate $Rate | Should -Match "<prosody rate=`"$Rate`">"
    }
}