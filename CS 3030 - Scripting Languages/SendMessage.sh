#!/bin/bash
#Whenever I log in it shows the number of users on the server.  I thought this was cool, and wanted to know if any of my friends/classmates were on the server as well.  After brushing up on some linux commands I came across two that were kind of cool
# 'w' this shows a list of the usernames, active time, and what they're doing
# 'list USERNAME' this show a given user names latest logins and their total time on the server
#
# the list commmand was great to see how much time I was actually working on my assignments.  For a few weeks I was happy with
# using these two commands until after using the 'w' I saw similar initals to a friend editing an assignment for cs3030 after double 
# checking the canvas roster I decided to use the command 'sudo wall -n hi FRIENDSNAME this is mick' it said permission was denied 
# so after looking online if there were any other ways I could say hi to a friend I stumbled on this script file and decided to try it
# After manueling typing it in I gave it a shot and BOOM my buddy texted me asking how I did that lol.  I LOVE THIS CLASS! 
# here is the URL of where I found the script.    
# http://unix.stackexchange.com/questions/99460/sending-messages-to-another-user

SendMessage()

{	com=`tty`
	set `who am i`
	who | grep -v "$1" >filef.txt

	exec < filef.txt
	array=""

	while read line
	do
		set $line
		echo $1
		array+=($1)
	done

	rm filef.txt
	exec <$com

	echo "===============> Select User Number <================="
	echo

	select userName in ${array[@]}
	do
		name=$userName
		if [ -n $name ]; then
			break
		fi
	done

	unset array

	echo
	echo

	echo "========= Message Body ================"

	mesg y
	read -p "Your message here ==> " messagel

	echo $messagel | write $name

	if [ $? -eq 0 ]; then
		echo "Message sent"
	else
		echo "Message not sent"
		return 1
	fi
}


SendMessage
