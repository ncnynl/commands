#!/bin/bash
export PATH="$HOME/.local/bin:$PATH"
pyinstaller -F commands.py share.py resources.py script.py category.py
#/home/ubuntu/.local/bin/pyinstaller -F commands.py share.py resources.py
