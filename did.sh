#!/bin/bash

# Usable with any command line editor, standard is nano but just edit the EDITOR variable to point to any editor you like.
# EDITOR will be used to show the journal and edit the script itself
# Also configure $didPath (where to store the journal) before using the script
#
# Dependencies:
# * pcregrep
# * sed

# Your preferred (command line) editor
EDITOR=nano

# Where you want to store the journal
didPath=~/did.txt


# You can change what the dateline that gets created for every new day looks like with these two lines
# But keep in mind that for any change in dateline you need to change the regular expression stored in $grepRegex to match your new "design"
# Also if you use some special characters that have meaning in regexp you may need to escape them
currentDate=$(date +"%d.%m.%Y")
dateLine="# $currentDate"


input=$1


function addLine(){

    # sed seems to have problems adding a line to the bottom of a file so i add one line at the bottom of a new file so sed never has to insert at the last line of the did.txt
    if ! [ -e "$didPath" ]; then
        echo "# You have reached the bottom of your Journal">"$didPath"
    fi

    fileCont=$(cat "$didPath")
    timeLine=$(date +"%T")

    # insert new dateline if top line does not contain current date
    if [[ $fileCont != $dateLine* ]]; then
        sed -i "1s/^/$dateLine\n/" "$didPath"
    fi

    # get number of lines and add 1 to get position for insert
    grepRegex="^#\s$currentDate[^#]*"
    numLines=$(pcregrep -M $grepRegex "$didPath" | wc -l)
    numLines=$(($numLines + 1))

    # insert new line
    newLine="[$timeLine] $input"
    sedCommand=$numLines"i$newLine"
    sed -i "$sedCommand" "$didPath"

}

# Check if dependencies are installed

for depName in pcregrep sed $EDITOR
do
    if [ "$(which $depName 2>/dev/null)" = "" ]; then
        echo "$depName needs to be installed."
        deps="1"
    fi
done

if [ "$deps" = "1" ]; then
    exit 1
fi


if [ "$#" -eq 0 ] ; then
    # show the journal in the editor
    $EDITOR "$didPath"

elif [ "$1" = "-e" ]; then
    # open script for editing
    $EDITOR $0

elif [ "$#" -ge 2 ]; then
    echo "USAGE: did INPUT or did [OPTION]"
    echo "    Options: -e ... open script itself in editor"
    echo "    Giving no option or input will open the journal in the editor"
    echo "    INPUT needs to be one argument, meaning enclosed in hyphens if it contains spaces"

else
    # add a new entry to the journal
    addLine
fi

