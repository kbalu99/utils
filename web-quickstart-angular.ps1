# Needs Git installed prior to the script

# Setting Execution Policy
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
$ErrorActionPreference = "Stop"

# Verifying latest software installed
$npm_installed = npm -v
$node_installed = node -v

$npm_latest = npm view --lts npm version
$node_latest = npm view --lts node version

If ($npm_installed -eq $npm_latest){
} Else {
Write-Host "NPM is not in latest version. Installed - '$npm_installed'  / Latest - '$npm_latest' `n Press any key to continue"
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}
Write-Host "`n"
If ($node_installed -eq $node_latest){
} Else {
Write-Host "Node is not in latest version. Installed - '$node_installed'  / Latest - '$node_latest' `n Press any key to continue"
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}
Write-Host "`n"
ng -v
Write-Host "Press any key to continue"
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Write-Host "`n"

################
## TO DO
# Use custom schematics 
# Code to identify, copy and use in ng new
# Code to edit the package.json, 
# @custom\balas_schema
################

# Get the location to instantiate web app
$Loc = Read-Host -Prompt 'Location of web app instantiation:'
cd $Loc
Write-Host "`n"

$AppName = Read-Host -Prompt 'Name of the app:'
$FullApp = $Loc + $AppName
Write-Host "Web app will be installed in '$FullApp' `n" -ForegroundColor Blue
Write-Host "CLOSE script if inaccurate." -ForegroundColor Red
Write-Host "`n"
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

# Initiate Angular App:  /adds flags for SASS, and Routing features
ng new $AppName --style=scss --routing

## Moving into App folder to install dependecies locally for the project
cd $AppName
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


# Update Webdriver
webdriver-manager update
webdriver-manager start

####################
##  TO DO
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


####################

Write-Host "`n `n"
Write-Host "Installed Successfully. Here are the parameters:"
Write-Host "Node Version - '$node_installed'",  "(GLOBAL)" -ForegroundColor Blue, Blue
Write-Host "NPM Version - '$npm_installed'",  "(GLOBAL)" -ForegroundColor Blue, Blue
Write-Host "Karma Version - '$karma_installed'",  "(LOCAL)" -ForegroundColor Blue, Red
Write-Host "Protractor Version - '$protractor_installed'",  "(GLOBAL)" -ForegroundColor Blue, Blue
Write-Host "Webpack Version - '$webpack_installed'",  "(LOCAL)" -ForegroundColor Blue, Red
Write-Host "Webpack-CLI Version - '$webpackcli_installed'",  "(LOCAL)" -ForegroundColor Blue, Red


# Wait for keypress to close
Write-Host "All done.. press any key to close"
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

