#!/bin/sh
################################################################
# Function :ROS Commands Manager Shell Utils Script                
# Platform :All Linux Based Platform                           
# Version  :1.1                                                
# Date     :2023-09-03                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################

# Examples 
#
# working "1-Current path is under $currentPath"
# error "2-Current path is under $currentPath"
# success "3-Current path is under $currentPath"
# warning "4-Current path is under $currentPath"
# underline "5-Current path is under $currentPath"
# bold "6-Current path is under $currentPath"

# echo ${SUCCESS}
# echo ${COMPLETE}
# echo ${WARN}
# echo ${ERROR}
# echo ${WORKING}
# echo ${BOLD}

source $HOME/commands/cs_variables.sh

# Print error into stdout
function error() {
    echo ${RED}"ERROR: $@"${RESET} >&2
}

# Print success into stdout
function success() {
    echo ${GREEN}"SUCCESS: $@"${RESET} >&2
}

# Print warning
function warning() {
    echo ${YELLOW}"WARNING: $@"${RESET} >&2
}

# Print underline content
function underline() {
    echo ${UNDER}"$@"${RESET} >&2
}

# Print bold content
function bold() {
  echo ${BOLD}"$@"${RESET} >&2
}

# Print working
function working() {
  echo ${BLUE}"WORKING: $@"${RESET} >&2
}

# Print note
function hint() {
  echo ${UNDER}${BOLD}${BLUE}"HINT: $@"${RESET} >&2
}
