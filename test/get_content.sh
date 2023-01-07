

function while_read_desc(){
    while read LINE
    do
        if [[ "${LINE[@]}" =~ "Desc" ]];then
            echo $LINE
            new=${LINE#*:}
            echo $new
            desc=${new%*#}
            echo $desc
        fi
    done < $1
}

file="~/tools/commands/test/install.sh"
echo ${file##*/}
folder=${path%/*}
# while_read_desc $file