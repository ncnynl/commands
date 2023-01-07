

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

# file="~/tools/commands/test/install.sh"
# echo ${file##*/}
# folder=${path%/*}
# while_read_desc $file

function is_empty_dir(){ 
    return `ls -A $1|wc -w`
}

# folder="$HOME/commands/walking/shell/"
folder="$HOME/commands/common/shell/"
# ls $folder | wc
if is_empty_dir $folder 
then 
    echo " $1 is empty"
else 
    echo " $1 is not empty" 
fi