#!/bin/bash

FLASK_APP_PATH="$HOME/tools/commands/commands_web"

source $HOME/.bashrc 

cd $FLASK_APP_PATH

source venv/bin/activate

./app.sh