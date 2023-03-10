function backupProfiles() {
    touch ~/.zprofile
    zshTally=$(cd ~/Tools/shell-profile-tool/shell-profile-backups/zsh && find . -name 'zshrc*' | grep -c zshrc)
    cd ~/Tools/shell-profile-tool/shell-profile-backups/zsh/
    zprofileBackupFile="zprofile_$zshTally.txt"
    mv ~/.zprofile $zprofileBackupFile

    touch ~/.bash_profile
    bashTally=$(cd ~/Tools/shell-profile-tool/shell-profile-backups/bash && find . -name 'bash*' | grep -c bash)
    cd ~/Tools/shell-profile-tool/shell-profile-backups/bash/
    bashBackupFile="bash_profile_$bashTally.txt"
    mv ~/.bash_profile $bashBackupFile
}

function populateProfiles() {
    touch ~/.zprofile
    echo "export PROFILE_LOCATION=~/.zprofile" >  ~/.zprofile
    cat ~/Tools/shell-profile-tool/profilecomponents/profile-template >> ~/.zprofile
    echo "" >> ~/.zprofile
    cat ~/Tools/shell-profile-tool/profilecomponents/local-profile >> ~/.zprofile

    touch ~/.bash_profile
    echo "export PROFILE_LOCATION=~/.bash_profile" >  ~/.bash_profile
    cat ~/Tools/shell-profile-tool/profilecomponents/profile-template >> ~/.bash_profile
    echo "" >> ~/.bash_profile
    cat ~/Tools/shell-profile-tool/profilecomponents/local-profile >> ~/.bash_profile
}

backupProfiles
populateProfiles