#!/bin/bash
location=~/Tools
cd $location

function installBrew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile 
    eval "$(/opt/homebrew/bin/brew shellenv)"
}

function installVSCode () {
    brew install --cask visual-studio-code
}

function installBash() {
    brew install bash
    echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile && reset
    sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells' && reset
    chsh -s /usr/local/bin/bash && reset
}

function makeProfiles() {
    cd $location
    ./shell-profile-tool/generateProfiles.sh
}

bannerBorder="================================================================================"

function openBanner() {
    echo "$bannerBorder"
    echo ""
    echo "$1 - BEGIN"
    echo ""
    echo "$bannerBorder"
}

function closeBanner() {
    echo ""
    echo "$bannerBorder"
    echo "$1 - COMPLETE"
    echo "$bannerBorder"
    echo ""
    echo ""
}

function installBrewWithVisuals() {
    title="INSTALL-BREW"
    openBanner $title
    if [ "$1" = "MAIN" ]; then
        installBrew
    fi
    closeBanner
}

function installVSCodeWithVisuals() {
    title="INSTALL-VSCODE"
    openBanner $title
    if [ "$1" = "MAIN" ]; then
        installVSCode
    fi
    closeBanner $title
}

function installBashWithVisuals() {
    title="INSTALL-BASH"
    openBanner $title
    if [ "$1" = "MAIN" ]; then
        installBash
    fi
    closeBanner $title
}

function generateProfilesWithVisuals() {
    title="GENERATE-PROFILES"
    openBanner $title
    if [ "$1" = "MAIN" ]; then
        makeProfiles
    fi
    closeBanner $title
}

function printVSCodeInstructions() {
    vSCodeInstructions="Download VSCode shell extension: \n\n-> Launch VS Code. \n\n-> Open the Command Palette (Cmd+Shift+P) and type 'shell command' to find the Shell Command: Install 'code' command in PATH command. \n\n-> Restart the terminal \n\n-> Add the following lines to your bash_profile and zshrc files:\n"
    echo "$bannerBorder"
    echo "COMPLETE BASH SETUP (OPTIONAL)"
    echo "$bannerBorder"
    printf "$vSCodeInstructions"
    echo "export EDITOR=code"
    echo 'export VISUAL="$EDITOR"'
    echo ""
    echo "$bannerBorder"
    echo ""
    echo ""
}

function printBashInstructions() {
    vSCodeInstructions="Set Bash as Default Shell: \n\n-> Launch Terminal. \n\n-> Navigate to Terminal > Prefrences \n\n-> For 'Shells open with:' select 'Command (complete path): \n\n->Add the following value for the path: \n/opt/homebrew/bin/bash\n"
    echo "$bannerBorder"
    echo "COMPLETE VSCODE SETUP"
    echo "$bannerBorder"
    printf "$vSCodeInstructions"
    echo ""
    echo "$bannerBorder"
    echo ""
    echo ""
}

function performSetup() {
    installBrewWithVisuals $1
    installVSCodeWithVisuals $1
    installBashWithVisuals $1
    generateProfilesWithVisuals $1

    printVSCodeInstructions
    printBashInstructions
}

function main() {
    context=MAIN
    # runs test by default. comment out below line to run main
    context=TEST
    performSetup $context
}
main