#Use shell script to implement a word 
#counter without using wc. It should take a file as input and output the number of words in it. You should use a loop

#!/bin/bash

if [ ! $# -eq 1 ]
then echo "usage: command <argument>"
exit 0
fi

if [ ! -f $1 ]
then echo "usage: <file type>"
exit 1
fi

count=0
for word in `cut -b1-10000 $1`
do      
                count=$(($count + 1))
done 
echo $count



#Write a script that creates a directory 'dir' and following empty files in it:

#file1
#File1
#FILE2
#FiLe3
#The script should then rename the files to contain lower-case letters only. If 
#a ﬁle name in lower-case letters already exists which would be overwritten by 
#the renaming of the original file, the program should warn the user "file <filename> 
#already exists", and should not rename the original file to overwrite the existing ﬁle. 
#You should use a loop and the 'tr' utility.
#!/bin/bash

if [ -e dir ];
then
rm -rf dir
fi

mkdir dir
cd dir
touch  file1

touch  File1

touch  FILE2

touch  FiLe3

cd ..


for file in  dir/*;
do
        fn=$(basename "$file")
        fl=$(echo $fn | tr [A-Z] [a-z])
        if [ ! "$fn" == "$fl"  ];
                then    
                        var=$(find dir/* -name "$fl")
                        var=$(basename "$var")
                        if [ "$fl" == "$var" ];
                                then echo "file $fl already exists"
                        else     mv "dir/$fn" "dir/$fl"
                        fi
        fi
done


#Write a script that takes 1 user argument, and checks if it is:
#'install': it has to create a subdirectory bin in a current working directory and a script file run.sh there.
#'uninstall': it has to delete the installed script and directory.
#For any other argument, it should return the error message "wrong argument". You should use the 'case' command.
#run.sh should be executable. It should print all executable files in the '/etc/init.d/', no directories.
                                                                                                              
#!/bin/bash

if [ $# -ne 1 ];
        then echo "wrong argument"
        exit 0
fi

case "$1" in

"install")
mkdir bin
cd  bin
cat<< EOF > run.sh
#!/bin/bash
find /etc/init.d/ -type f -perm +111
EOF

chmod +x run.sh
cd ..
/bin/bash ./bin/run.sh
;;
uninstall)
rm -rf bin
;;
*)
echo "wrong argument"
;;
esac
exit 0


#Write a script that takes as input one argument - a directory path. It then recursively lists the directory structure below the given path as in this example:

#/path/to/dir
#|-- subdir1
#| |-- file1
#| |-- file2
#|-- subdir2
#  |-- file3
#  |-- subdir3
#    |-- file4

#The script does not need to list hidden files. Files and directories should be sorted by name.
#You should implement a recursive function with local variables and pass indentation as an argument.

#!/bin/bash
if [ $# -ne 1 ];
then echo "Usage: command <arg>" 
exit 0 
fi 

if [ ! -d $1 ]; 
then echo "Not a dir"  
exit 1
fi
echo $1
fun()
{
cd $2
local dcount=0
local dtotal=$( ls | wc -l)
for i in $(ls)
        do
        dcount=$(($dcount+1))
        echo "$1|-- $i"

        if [ -d $i ];then
                if [ $dcount -eq $dtotal ];then
                        fun "$1  " $i
                else
                        fun "$1| "  $i
                fi
        fi

done
cd ..
}
fun "" $1





