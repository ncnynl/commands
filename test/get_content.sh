

function while_read_desc(){
    FILENAME="install.sh"
    while read LINE
    do
        if [[ "${LINE[@]}" =~ "Desc" ]];then
            echo $LINE
            echo ${LINE#*:}
            echo $LINE | sed -e 's/.*Desc\(.*\)#\1/g' 
        fi
    done < $FILENAME
}
while_read_desc