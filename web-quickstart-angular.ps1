<#
QUICKSTART SCRIPT - Angular Progressive WebApp

REQUIRES
* NPM and Node - https://nodejs.org/en/download/
* Protractor (global install) - http://www.protractortest.org/#/
** npm install -g protractor
** webdriver-manager update

INSTALLS
* Angular app using @angular*cli
** custom schematic * @custom\balas_schema
(locally to project)
* Webpack 
* Webpack CLI 
* Karma 
* Karma CLI 
* Bootstrap
* ng*bootstrap  (optional * ngx*bootstrap)
* source*map*explorer
* FontAwesome
 
DEPENDENCY AUDIT AND FIX
* npm audit fix

PROESSES
* webdriver*mangager update and start
* ng*build & ng*serve (optional)
 
OPTIONAL INSTALLS
* Visual Studio Code
** Entension * Angular 6 (by Mikael or John Papa)
* 
#>

#****************************************************************************************************
# Setting Execution Policy
try {
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
}
catch [System.Security.SecurityException] {
    Write-Host "Issue in setting up execution policy. Continuing with script..." -ForegroundColor Red
}
catch {
    Write-Host "An error occurred that could not be resolved" -ForegroundColor Red
    Write-Host "Step: Setting execution policy"
    Write-Host $_.Exception.GetType().FullName, $_.Exception.Message
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); 
    exit
}

$ErrorActionPreference = "Stop"

#****************************************************************************************************
# Checking whether Git, Node and NPM are installed
try {
    $_npm_v = npm -v
    $_node_v = node -v
    $_git_v = git --version
}
catch [System.Management.Automation.CommandNotFoundException] {
    Write-Host "The following dependencies need to be installed prior to this - `n" -ForegroundColor Red
    Write-Host "Node" -ForegroundColor Red
    Write-Host "NPM" -ForegroundColor Red
    Write-Host "Git" -ForegroundColor Red
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); 
    exit
}
catch {
    Write-Host "An error occurred that could not be resolved" -ForegroundColor Red
    Write-Host "Step: NPM, Node and Git installation check"
    Write-Host $_.Exception.GetType().FullName, $_.Exception.Message
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); 
    exit  
}

#****************************************************************************************************
# Check if @angular-cli is installed; If not, let script install after user permission
try {
    $_ng_v = ng -v
}
catch [System.Management.Automation.CommandNotFoundException] {
    Write-Host "The following dependencies need to be installed prior to this - "
    Write-Host "@angular-cli" -ForegroundColor Red
    Write-Host "`n"
    $option = Read-Host -Prompt 'Do you want the script to install @angular-cli globally? [YES] / [NO]: '
    If ($option -eq 'YES' -or $option -eq 'yes' -or $option -eq 'y') {
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); 
        npm install -g @angular/cli
        $_ng_v = ng -v
    }
    Else {
        exit
    }
}
catch {
    Write-Host "An error occurred that could not be resolved" -ForegroundColor Red
    Write-Host "Step: @angular-cli installation check"
    Write-Host $_.Exception.GetType().FullName, $_.Exception.Message
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); 
    exit   
}

#****************************************************************************************************
# Obtain all needed information from User
$Loc = Read-Host -Prompt 'Local Folder to setup App (existing folder): '
$AppName = Read-Host -Prompt 'Name of the App:'

# Moving to the folder provided
try {
    Set-Location $Loc
}
catch {
    Write-Host "Folder not found" -ForegroundColor Red
    Write-Host "Step: Folder Location setup check"
    Write-Host $_.Exception.GetType().FullName, $_.Exception.Message
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); 
    exit
}

# Get the Github location
$GitUserID = Read-Host -Prompt 'Github User ID:'
$GitRepoName = Read-Host -Prompt 'Githubrepo Name (Make sure it is already created):'

# Computing links
$FullApp = $Loc + $AppName
$GitRepoLink = "https://github.com/" + $GitUserID + "/" + $GitRepoName
$GitRepoFullName = "https://github.com/" + $GitUserID + "/" + $GitRepoName + ".git"
$GitIOPath = "https://" + $GitUserID + ".github.io" + "/" + $GitRepoName + "/"


#****************************************************************************************************
##  Check whether github repo is accesible
function CheckGitRepoStatus([int]$HTTP_Status) {
    $HTTP_Request = [System.Net.WebRequest]::Create($GitRepoLink)
    $HTTP_Request.Method = "GET"
    $HTTP_Request.Accept = 'application/json;odata=verbose'

    try {
        $HTTP_Response = $HTTP_Request.GetResponse()
        $HTTP_Status = [int]$HTTP_Response.StatusCode
        If ($HTTP_Status -eq 200) {
            $HTTP_Response.Close()
            return 
            }
        }
        catch {
            Write-Host "Github repo - '$GitRepoLink' doesn't exist" -ForegroundColor Red
            Write-Host "To continue, press any key after the Github repo is created..."
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
            CheckGitRepoStatus(400)  
        }
}
CheckGitRepoStatus(400)

 
#****************************************************************************************************

$_npm_latest = npm view --lts npm version
$_node_latest = npm view --lts node version
$_git_latest = npm view --lts git version

# Confirm all parameters
Write-Host "`nPackages Installed"
Write-Host "Package Name`tInstalled Version`tLatest Version"
Write-Host "------------`t-----------------`t--------------"
Write-Host "NPM`t'$_npm_v'`t'$_npm_latest'"
Write-Host "Node`t'$_node_v'`t'$_node_latest'"
Write-Host "Git`t'$_git_v'`t'$_git_latest'"
Write-Host "`nYour Application"
Write-Host "------------------"
Write-Host "Local install in '$FullApp' " 
Write-Host "Git Repo Name: '$GitRepoFullName' "
Write-Host "Git IO URL: '$GitIOPath' "
Write-Host "`n"
Write-Host "CLOSE script if inaccurate." -ForegroundColor Red
Write-Host "`n"
$option = Read-Host -Prompt '[YES] to continue [NO] to close'

If ($option -eq 'YES' -or $option -eq 'yes' -or $option -eq 'y') {
}
Else {
    Write-Host "`n Press any key to close"
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    exit
}

#****************************************************************************************************
################################# TO DO
# Use custom schematics 
# Code to identify, copy and use in ng new
# Code to edit the package.json, 
# @custom\balas_schema

#****************************************************************************************************
# Setting Up Application in Local
# Initiate Angular App:  /adds flags for SASS, and Routing features
ng new $AppName --style=scss --routing

## Moving into App folder to install dependecies locally for the project
Set-Location $AppName

# Install Webpack:
npm install --save-dev webpack
npm install --save-dev webpack-cli

# Install Karma:
npm install karma --save-dev

# Install plugins that your project needs:
npm install karma-jasmine karma-chrome-launcher jasmine-core --save-dev

# Install Karma CLI:
npm install -g karma-cli

# Install Bootstrap
npm install bootstrap

# Install Bootstrap Javascript components
npm install --save @ng-bootstrap/ng-bootstrap

# Install FontAwesome
npm install --save-dev @fortawesome/fontawesome-free

# prod bundles inspection
npm install source-map-explorer --save-dev

# Fix dependecies
npm audit fix

# Check parameters
$webpack_installed = .\node_modules\.bin\webpack --version
$webpackcli_installed = .\node_modules\.bin\webpack --version
$karma_installed = karma --version
$protractor_installed = protractor --version
$bootstrap_installed = npm bootstrap --v
$ng_bootstrap_installed = npm ng-bootstrap -v
$fontawesome_installed = npm ng-bootstrap -v

# Update Webdriver
# webdriver-manager update
# webdriver-manager start

#****************************************************************************************************
################################# TO DO
# ng serve
# setup config files for karma, protractor
# webpack build, start server

## JIT compilation
# ng build
# ng serve
## AOT compilation
# ng build --aot
# ng serve --aot

## PROD build/serve
# ng build --prod --build-optimizer

## Dev Tools
# Visual Studio Code
# 	- Extension - Angular

#****************************************************************************************************
# Build App
Write-Host "Building Production" -ForegroundColor Red
ng build --prod --build-optimizer

#****************************************************************************************************
# Deploy App - Push changes and publish
Write-Host "Deploying to Github pages" -ForegroundColor Red
git init
git add README.md
git commit -m "first commit"
git remote add origin $GitRepoFullName
git push -u origin master
ng build --prod --base-href $GitIOPath
ngh --dir dist/$AppName

#****************************************************************************************************
# Open deployed app
Start-Process $GitIOPath

#****************************************************************************************************
# Display all changes
$display_string = @"
                ------------------------------------------------------------------------------------------------------------------------
                Package Name        Installed Version               Latest Version              Location
                ------------------------------------------------------------------------------------------------------------------------
                NPM                 $_npm_v                           $_npm_latest                       GLOBAL
                Node                $_node_v                         $_node_latest                      GLOBAL
                Git                 $_git_v    $_git_latest                       GLOBAL
                @angular-cli        _ng_cheat_v                     _ng_cheat_latest            GLOBAL
                Karma               $karma_installed            _karma_latest               LOCAL
                Protractor          $protractor_installed                   _protractor_latest          GLOBAL
                Webpack             $webpack_installed                          _webpack_latest             LOCAL
                Webpack-CLI Version $webpackcli_installed                          _webpack_cli_latest         LOCAL
                Bootstrap           $bootstrap_installed                           _bootstrap_latest           LOCAL
                ng-bootstrap        $ng_bootstrap_installed                           _ng-bootstrap_latest        LOCAL
                Fontawesome         $fontawesome_installed                           _ft_latest                  LOCAL
"@

Write-Host "Packages Installed"
$display_string

Write-Host "`n`nYour Application"
Write-Host "------------------"
Write-Host "Local install in" "'$FullApp' ", -ForegroundColor Blue, Red
Write-Host "Git Repo Name:" "'$GitRepoFullName' " -ForegroundColor Blue, Red
Write-Host "Git IO URL:" "'$GitIOPath' " -ForegroundColor Blue, Red

<# 
Write-Host "Package Name`tInstalled Version`tLatest Version"
Write-Host "------------`t-----------------`t--------------"
Write-Host "NPM`t'$_npm_v'`t'$_npm_latest'",  "(GLOBAL)" -ForegroundColor Blue, Blue
Write-Host "Node`t'$_node_v'`t'$_node_latest'",  "(GLOBAL)" -ForegroundColor Blue, Blue
Write-Host "Git`t'$_git_v'`t'$_git_latest'",  "(GLOBAL)" -ForegroundColor Blue, Blue
Write-Host "Karma`t'$karma_installed'",  "(LOCAL)" -ForegroundColor Blue, Red
Write-Host "Protractor`t'$protractor_installed'",  "(GLOBAL)" -ForegroundColor Blue, Blue
Write-Host "Webpack`t'$webpack_installed'",  "(LOCAL)" -ForegroundColor Blue, Red
Write-Host "Webpack-CLI Version`t'$webpackcli_installed'",  "(LOCAL)" -ForegroundColor Blue, Red
Write-Host "Bootstrap`t'$bootstrap_installed'",  "(LOCAL)" -ForegroundColor Blue, Red
Write-Host "ng-bootstrap`t'$ng_bootstrap_installed'",  "(LOCAL)" -ForegroundColor Blue, Red
Write-Host "Fontawesome`t'$fontawesome_installed'",  "(LOCAL)" -ForegroundColor Blue, Red #>

#****************************************************************************************************
# Wait for keypress to close
Write-Host "All done.. press any key to close"
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

#****************************************************************************************************
