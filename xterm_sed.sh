#!/bin/bash
input="'$1'"
if [ -z "$1" ]
then
    echo "Empty input. Done." 1>&2
    exit 0
fi
#input="'$(</dev/stdin)'"

#Place to store sed output/error
output=/tmp/o_pipe
error=/tmp/e_pipe
info=/tmp/i_pipe

#It would be nice to do this with pipes, unfortunately I can't figure out how to
#write stderr and stdout to separate pipes and not block, and still be able to 
#read the data at the end.
# #Create pipe if it doesn't exist
# if [[ ! -p "$output" ]]; then
#   mkfifo "$output"
# fi
# 
# if [[ ! -p "$error" ]]; then
#   mkfifo "$error"
# fi
# 
# # Assign pipes to file descriptors to prevent writes from blocking until data is read?
# exec 3<> $output
# exec 4<> $error

#Ensure unique filenames
suffix="0"
while [ -e $output ]
do
    suffix=$((suffix+1))
    output="${output}_${suffix}"
done
suffix=0
while [ -e $error ]
do
    suffix=$((suffix+1))
    error="${error}_${suffix}"
done
suffix=0
while [ -e $info ]
do
    suffix=$((suffix+1))
    info="${info}_${suffix}"
done

# Create output/error files
touch $output
touch $error
touch $info

#Delete output/error when exiting
#trap "rm -f $output; rm -f $error; rm -f $info; exec 3>&-; exec 4>&-; exit"  EXIT

# echo "INPUT: $input"
#Launch sed replacement script
xterm -e "echo $input | /home/sosler/gss_bin/input_sed.sh $output $error $info"

# If there was info write it to stderr
msg=$(cat "$info")
if [ -n "$msg" ]
then
    echo "$msg" 1>&2
fi

#Read error from pipe
# echo "READING ERR" 1>&2
# while IFS='' read -r line || [[ -n "$line" ]]
# do
#   err="${err}""${line}"
# done < $error
err=$(cat $error)

# If there were errors write them to stderr and exit
if [ -n "$err" ]
then
    echo "Error: "
    echo "$err" 1>&2
    exit 1
fi

#Read output from pipe
#echo "READING OUTPUT" 1>&2
# while IFS='' read -r line || [[ -n "$line" ]]
# do
# #   echo "$txt"
#   echo -n "$line"
#   out="$out""$line"
# done < $output
out=$(cat $output)

#If there was output write it to stdout
if [ -n "$out" ]
then
    echo "$out"
else
    echo "Not outputting empty result" 1>&2
    exit 1
fi
