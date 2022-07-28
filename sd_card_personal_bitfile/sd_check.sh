#/bin/bash

cd $HOME
sd_dir=$HOME/sd
mkdir -p $sd_dir


# DEV=/dev/sda
# if [ -f "$DEV" ]; then
#     echo "$DEV exists."
# else
#     echo "$DEV not exists."
# fi

check_mount() {
    DEV=$1
    if [ -f "$DEV" ]; then
        echo "$DEV exists."
        mount $DEV $sd_dir
        cd $sd_dir
        mv personal/* ..
        cd $HOME
        sleep 3
        fusermount -u $sd_dir
        if $? -eq 0
        then
            sleep 20
            return 0
        else
            return 1
        fi 
        
    else
        # echo "$DEV not exists."
        return 1
    fi
}


while true
do
    DEV=/dev/sda

    check_mount $DEV

    DEV=/dev/sdb

    check_mount $DEV

    DEV=/dev/sdc

    check_mount $DEV

    sleep 1
done



