# Needs Git installed prior to the script

# Setting Execution Policy
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
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
Write-Host "Press any key to close"
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Write-Host "`n"

# Get the location to instantiate web app
$Loc = Read-Host -Prompt 'Location of web app instantiation:'
cd $Loc
Write-Host "`n"

$AppName = Read-Host -Prompt 'Name of the app:'
$FullApp = $Loc + $AppName
Write-Host "Web app will be installed in '$FullApp' `n Close script if inaccurate."
Write-Host "`n"
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

# Initiate Angular App:
ng new $AppName

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

# Check parameters
$webpack_installed = .\node_modules\.bin\webpack --version
$webpack-cli_installed = .\node_modules\.bin\webpack --version
$karma_installed = karma --version
$protractor_installed = protractor --version

Write-Host "Installed Successfully. Here are the parameters:"
Write-Host "Node Version - '$node_installed'",  "(GLOBAL)" -ForegroundColor Blue, Blue
Write-Host "NPM Version - '$npm_installed'",  "(GLOBAL)" -ForegroundColor Blue, Blue
Write-Host "Karma Version - '$karma_installed'",  "(LOCAL)" -ForegroundColor Blue, Red
Write-Host "Protractor Version - '$protractor_installed'",  "(GLOBAL)" -ForegroundColor Blue, Blue
Write-Host "Webpack Version - '$webpack_installed'",  "(LOCAL)" -ForegroundColor Blue, Red
Write-Host "Webpack-CLI Version - '$webpack-cli_installed'",  "(LOCAL)" -ForegroundColor Blue, Red


# Wait for keypress to close
Write-Host "All done.. press any key to close"
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

