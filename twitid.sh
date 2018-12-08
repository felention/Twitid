#!/bin/bash
d='~/Documents/Misc'
f="$d/TwitterIDs.txt"
if [[ -z $1 ]]; then
    echo "Enter a handle."
    exit 0
fi
sus=$(curl -I https://twitter.com/$1 --silent | grep -o "location: https://twitter.com/account/suspended")
ex=$(curl -I https://twitter.com/$1 --silent | grep -o "status: 404 Not Found")
if [[ -z $(ls $d | grep "TwitterIDs.txt") ]]; then
    touch $f
fi
if [[ $1 =~ ^[0-9]+$ ]]; then
    ex=$(curl -I "https://twitter.com/intent/user?user_id=$1" --silent | grep -o "status: 404 Not Found")
    sus=$(curl -I "https://twitter.com/intent/user?user_id=$1" --silent | grep -o "location: https://twitter.com/account/suspended")
    if [[ -n $ex ]]; then
        echo "ID is invalid."
        exit 0
    elif [[ -n $sus ]]; then
        echo "User is suspended"
        if [[ -n $(grep -iF "$1" $f) ]]; then
            echo "Usernames were: $(grep -iF "$1" $f)"
        fi
        exit 0
    else
        usr=$(curl "https://twitter.com/intent/user?user_id=$1" --silent | grep "<title>" | sed 's/.*@//g; s/).*//g')
        echo $usr
        if [[ -z $(grep -iF "$usr" $f) ]]; then
            echo -e "$1  ==>  $usr\n" >> $f
        fi
    fi
    exit 0
elif [[ -n $sus ]]; then
    echo "User is suspended."
    if [[ -n $(grep -iF "$1" $f) ]]; then
        echo "Usernames were: $(grep -iF "$1" $f)"
    fi
    exit 0
elif [[ -n $ex ]]; then
    echo "User no longer exists."
    if [[ -n $(grep -iF "$1" $f) ]]; then
        echo "ID was $(grep "$1" $f)"
    fi
    exit 0
else
    id=$(curl "https://twitter.com/$1" --silent | sed -e $'s/,/\\\n/g' | grep "profile_id" | sed 's/.*://g; s/,.*//g')
    echo $id
    if [[ -z $(grep -iF "$1" $f) ]]; then
        echo -e "$id  ==>  $1\n" >> $f
    fi
fi
exit 0
