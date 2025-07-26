#!/bin/bash
FLASK_APP_PATH="$HOME/tools/commands/commands_gui"
source $HOME/.bashrc 
cd $FLASK_APP_PATH
source venv/bin/activate
pyinstaller -F commands.py share.py resources.py script.py category.py
#/home/ubuntu/.local/bin/pyinstaller -F commands.py share.py resources.py
