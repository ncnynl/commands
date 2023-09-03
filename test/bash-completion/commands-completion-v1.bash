_my_custom_command() {
    local cur
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    echo $cur
    case "$cur" in
        *)
            COMPREPLY=( $(compgen -W "option1 option2 option3" -- $cur) )
            ;;
    esac
}
complete -F _my_custom_command cs
