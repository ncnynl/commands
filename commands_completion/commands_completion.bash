#/usr/bin/env bash
_commands_completions() {
    local cur
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    local suggestions=()
    local suggestions2=()
    local num=${#COMP_WORDS[@]}
    local sugnum
    local number

    case "$num" in
        4)
            #for files options
            local scriptName=${COMP_WORDS[2]}
            local folderName=${COMP_WORDS[1]}
            local prefix="$CSROOT/$folderName/shell/"
            local scriptFile="$prefix$scriptName.sh"

            local start=`grep "^Option" -n $scriptFile | head -n 1 | cut -d ":" -f1`
            if [[ $start == "" ]]; then 
              return 
            fi
            
            local end=`grep "^EOF" -n $scriptFile | head -n 1 | cut -d ":" -f1`
            if [[ $end == "" ]]; then 
              return 
            fi

            local length=$[ $end - $start ]
            if [[ $length == 0 ]]; then
              return
            fi

            local items1=()
            local items2=()
            local items3=()
            local options="$(cat $scriptFile | tail -n +$start | head -n $length)"

            index=0
            while read line; do
                local content=$line
                if [[ "$content" =~ ^\ *--.+:.+ ]]; then
                    # echo $content
                    local desc=`echo $content | cut -d ":" -f2 | sed "s/^ *--//"`
                    local opts=`echo $content | cut -d ":" -f1`
                    local opt1=`echo $opts | cut -d "|" -f1`
                    local opt2=`echo $opts | cut -d "|" -f2`

                    items1[$index]=$opt1
                    items2[$index]=$opt2
                    items3[$index]=$desc

                    index=$[ index + 1 ]
                fi
            done <<< "$options"

            #suggestions
            suggestions=($(compgen -W "${items1[*]}" -- $cur))
            sugnum=${#suggestions[@]}

            case "$sugnum" in
              0)
                return 
                ;;            
              1)
                number="${suggestions[0]}"
                COMPREPLY=("$number")
                ;;
              *)
                #replace
                local descOfCmd
                for i in "${!suggestions[@]}"; do
                  suggestions[$i]="$(printf '%-30s %-10s %-2s' ${items1[$i]} ${items2[$i]} -- ) ${items3[$i]}" 
                done

                #COMPREPLY
                COMPREPLY=("${suggestions[@]}")
                ;;
            esac
            ;;
        3)
            #for files
            local folder=${COMP_WORDS[1]}
            declare subscripts=(`subscripts ${COMP_WORDS[1]}`)

            #skip .sh
            for i in "${!subscripts[@]}"; do
              subscripts[i]=${subscripts[i]%.*}
            done

            suggestions2=($(compgen -W "${subscripts[*]}" -- $cur))
            sugnum=${#suggestions2[@]}
            local prefix="$CSROOT/$folder/shell/"

            case "$sugnum" in
              0)
                return 
                ;;            
              1)
                number="${suggestions2[0]/%\ */}"
                COMPREPLY=("$number")
                ;;
              *)
                for i in "${!suggestions2[@]}"; do
                  #get desc of file
                  local scriptName=${suggestions2[$i]}
                  local scriptFile="$prefix${suggestions2[$i]}.sh"
                  #old
                  # local start=`grep "Description" -n $scriptFile | head -n 1 | cut -d ":" -f1`
                  # start=$[ $start + 1 ]
                  # local descOfScript=`cat $scriptFile | tail -n +$start | head -n 1 | sed "s/^--//" | sed "s/^ *//g"`
                  
                  #new 
                  local start=`grep "Desc" -n $scriptFile | head -n 1 | cut -d ":" -f1`
                  local descOfScript=`cat $scriptFile | tail -n +$start | head -n 1 | sed "s/^# Desc     ://" | sed "s/^ *//g"`
                  if [[ $descOfScript ]]; then
                    descOfCmd="$(printf '%-30s %-10s' $scriptName --) $descOfScript" 
                  fi
                  # echo $descOfScript
                  suggestions2[$i]="$(printf '%*s' "-$COLUMNS"  "$descOfCmd")"
                done
                COMPREPLY=("${suggestions2[@]}")
              ;;
            esac
            ;;    
        2)
            #for folder
            declare subdirs=(`subdirs`)
            suggestions=($(compgen -W "${subdirs[*]}" -- $cur))
            local prefix="$CSROOT/"

            sugnum=${#suggestions[@]}
            case "$sugnum" in
              0)
                return 
                ;;            
              1)
                number="${suggestions[0]/%\ */}"
                COMPREPLY=("$number")
                ;;
              *)
                for i in "${!suggestions[@]}"; do
                  #get description
                  local dirName=${suggestions[$i]}
                  local descFile=$prefix"${dirName}/shell/.description"
                  local descOfCmd
                  local desc

                  #if have .description
                  if [[ -f $descFile ]]; then
                    desc=`cat $descFile | head -n 1 `
                    if [[ $desc ]]; then
                        descOfCmd="$(printf '%-30s %-10s' $dirName --) $desc" 
                    fi
                  else
                    descOfCmd="$(printf '%-30s %-10s %-4s\n' $dirName -- 相关功能)"
                  fi

                  suggestions[$i]="$(printf '%*s' "-$COLUMNS"  "$descOfCmd")"
                done
                COMPREPLY=("${suggestions[@]}")
              ;;
            esac
            ;;
        *)
          return 
          ;;
    esac
}

# functions
export CSROOT="${HOME}/commands"
# 获取目录
function subdirs() {
  echo `ls -l $CSROOT | awk '/^d/ {print $NF}'`
}

# 获取脚本
function subscripts() {
  if [ -d $CSROOT/$1 ]; then 
    echo `ls -l $CSROOT/$1/shell/ | awk '/.sh$/ {print $NF}'`
  fi
}

complete -F _commands_completions cs
