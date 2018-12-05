# Twitid
Grab users Twitter ID to track username changes, and get their username from their ID.

If the user is suspended it will tell you along with their previous usernames that you saved.

However if the user no longer exists, it will tell you but if you have gotten their ID before it'll give you the ID with the usernames that you saved. You can then choose to get their new username if they did change it by running the script again with the ID.

This will work in the Windows Subsystem for Linux (WSL).

 

### Setup
Since you have to build the username-ID list yourself the script stores the converted usernames with their IDs to your Documents folder in a text file named "TwitterIDs.txt". If you would rather edit the directory it's saved in just edit the variable "d" to the new directory.

You can also edit the username-ID list file by editing the f variable.

I would also recommend adding it as an alias for faster use. You can do this by the following:

1. Using your prefered editor, add ***alias twitid='bash ~/Documents/twitid.sh'*** to ~/.bashrc

2. For instant use without having to restart your terminal session type ***source ~/.bashrc***

 

Now you can run it. Example:

twitid felention
1014584390989557760

twitid 1014584390989557760
felention.
