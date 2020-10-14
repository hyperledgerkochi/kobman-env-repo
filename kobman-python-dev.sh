#!/bin/bash

function __kobman_install_python-dev(){
    python3 --version
    if [[ "$?" != "0" ]]; then
        echo "No python package found. Installing python3.7..."
        sudo apt update -y
        sudo apt install software-properties-common
        sudo add-apt-repository ppa:deadsnakes/ppa
        sudo apt install python3.7
        sudo apt-get install python3-venv
    else
        echo "Python package already exists. Installing virtual environment.."
        sudo apt-get update -y
        sudo apt-get install python3-venv
        
    fi
    echo "Creating python virtual environment"
    python3 -m venv $HOME/python-dev
    create_test_script > $HOME/python-dev/test.py
    read -p "Do you want to install Visual Studio Code as your python IDE?[y/n]" ans
    if [[ $ans == "y" || $ans == "Y" ]]; then
        echo "Installing IDE for development"
        sudo apt update
        sudo apt install software-properties-common apt-transport-https wget
        get -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
        sudo apt update
        sudo apt install code
    fi
    echo "Python development environment and IDE installation complete"
    echo "Use command 'source python-dev/bin/activate' to enter the python virtual environment"
}

function create_test_script(){

cat << EOF
import getpass
username = getpass.getuser()
print("Welcome " + username)
EOF
}

function __kobman_uninstall_python-dev(){

    rm -rf $HOME/python-dev
    

}

function __kobman_validate_python(){
    python3 --version
    if [[ "$?" != "0" ]]; then
        echo "No python package found. Test failed!"
        return 1
        
    else
        echo "Python package exists"
        if [[ -d "$HOME/python-dev" ]]; then
            echo "Virtual environment exists" 
            echo "Test Sucessful!!"
            return 0
        else
            echo "Test Failed!!"
            return 1
        fi
    fi
}

#__kobman_update_python(){

#}
#__kobman_upgrade_python(){

#}
#__kobman_start_python(){

#}
#__kobman_stop_python(){

#}