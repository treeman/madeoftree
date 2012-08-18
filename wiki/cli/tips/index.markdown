---
layout: wiki
---

# Remote control MPlayer

There are two types of people in this world: those who think MPlayer is the best media player in the history of existence, and those who are wrong. One of MPlayer's lesser-known features is the ability to control it from a console, a shell script or even over the network. The secret to this trick is in MPlayer's -slave option, which tells the program to accept commands from the stdin stream instead of keystrokes. Combine this with the -input option, and commands are read from a file, or a FIFO. For instance, try this in one terminal:

    mkfifo ~/mplayer-control
    mplayer -slave -input file=/home/user/mplayercontrol
    filetoplay

Then, in another terminal or from a script, enter:

    echo "pause" >~/mplayer-control


# Share files the easy way

File sharing with Samba or NFS is easy once you've got it set up on both computers, but what if you just want to transfer a file to another computer on the network without the hassle of setting up software? If the file is small, you may be able to email it. If the computers are in the same room, and USB devices are permitted on both, you can use a USB flash drive, but there is also another option.

Woof is a Python script that will run on any Linux (or similar) computer. The name is an acronym for Web Offer One File, which sums it up fairly well, as it is a one-hit web server. There's nothing to install; just download the script from the homepage at www.home.unix-ag.org/ simon/woof.html and make it executable, then share the file by entering

    ./woof /path/to/myfile

It will respond with a URL that can be typed into a web browser on another computer on the network - no software beyond a browser is needed. Woof will serve the file to that computer and then exit (you can use the -c option to have it served more times). Woof can also serve a directory, like so:

    ./woof -z /some/dir

This will send a gzipped tarball of the directory, and you can replace -z with -j or -u to get a bzipped or uncompressed tarball. If others like Woof and want to use it, you can even let them have a copy with

    ./woof -s


# Find lost files

Have you ever saved a file, maybe a download, then been unable to find it? Maybe you saved it in a different directory or with an unusual name.

The find command comes in handy here:

    find ~ -type f -mtime 0

will show all files in your home directory modified or created today. By default, find counts days from midnight, so an age of zero means today.

You may have used the -name option with find before, but it can do lots more. These options can be combined, so if that elusive download was an MP3 file, you could narrow the search with:

    find ~ -type f -mtime 0 -iname '*.mp3'

The quotation marks are needed to stop the shell trying to expand the wildcard, and -iname makes the match case-insensitive.

Incorrect permissions can cause obscure errors sometimes. You may, for example, have created a file in your home directory while working as root. To find files and directories that are not owned by you, use:

    find ~ ! -user ${USER}

The shell sets the environment variable USER to the current username, and a ! reverses the result of the next test, so this command finds anything in the current user's directory that is not owned by that user. You can even have find fix the permissions

    find ~ ! -user $USER -exec sudo chown ${USER}:"{}" \;

The find man page explains the use of -exec and many other possibilities.


# Reverse SSH

SSH is one of the most versatile tools for Linux, but most people only ever use it one way - to use the server to send data to the client. What you might not know is that it's also possible to switch the usual logic SSH and use the client to send data to the server. It seems counterintuitive, but this approach can save you having to reconfigure routers and firewalls, and is also handy for accessing your business network from home without VPN.

You'll need the OpenSSH server installed on your work machine, and from there you need to type the following to tunnel the SSH server port to your home machine:

    ssh -R 1234:localhost:22 home_machine

You'll need to replace `home_machine` with the IP address of your home machine. We've used port number 1234 on the home machine for the forwarded SSH session, and this port needs to be both free to use and not blocked by a local firewall. Once you've made the connection from work, you can then type the following at home to access your work machine:

    ssh workusername@localhost -p 1234

This will open a session on your work machine, and you will be able to work as if you were at the office. It's not difficult to modify the same procedure to access file servers or even a remote desktop using VNC. The only problem you might find is that the first SSH session may time out. To solve this, open /etc/ssh/sshd.conf on your work machine and make sure it contains 'KeepAlive yes' and 'ServerAliveInterval 60' so that the connection doesn't automatically drop.


# Old favourites in Bash

It's always worth revisiting forgotten bash commands. Three of the most useful that seem to have fallen from common use are cut, paste and the translate command, tr. cut and paste do exactly what you'd expect, and though they sound mundane it's surprising how powerful they can be when used either in the command line or within a script.

cut is generally a little more useful than the paste command. Running cut takes part of a line and redirects it to the standard output. By default, it uses tab as the field separator, but this can be changed using -d, and fields are selected using the -f flag.

paste effectively allows you to merge contents in columns, like a vertical cat. The best way to see how this works is to create two text files, each with three separate lines of data. The output of paste will be the contents of the first file in a column to the left of the second.

The tr command is used for deleting extraneous output, such as spaces or tabs. The most useful option is -s, which removes repeated sequences of a single character. Take the output ls -al, which generates a long directory listing including the size of files padded with spaces for better-looking output. The tr command can be used to remove these, and provide a single space character for field separation.

Here's an example of how these commands can work together:

    ls -al --sort=size /usr/bin | tr -s ' ' | cut -d ' ' -f 5,8

The long output of ls is sorted and then piped to the translate command. This removes the padding, leaving each field separated by a single space. cut then uses the space character as a field delimiter, and takes fields 5 and 8 from the output. What you get is a list of files, sorted by size, displaying only the size and the filename.


# Nice, nice baby

Most Linux users know of the nice command but few actually use it. Nice is one of those commands that sound really good, but you can never think of a reason to use. Occasionally though, it can be incredibly useful. Nice can change the priority of a running process, giving it a greater or smaller share of the processor. Usually this is handled by the Linux scheduler. The scheduler guarantees that processes with a higher priority (like those that involve user input) get their share of the resources. This should ensure that even when your system is at 100% CPU, you will still be able to move the windows and click on the mouse.

The scheduler doesn't always work smoothly, however; certain tasks can take over your computer. This could be a wayward find command that's triggered by a distro's housekeeping scripts; or encoding a group of video files that makes your computer grind to a halt.

You'd typically hunt these processes out with the top comand before killing them. Nice presents another, more subtle and more useful option. It reduces the offending task's priority so that your system remains usable while still serving the offending process. Running a command with a different priority is as easy as entering

    nice --10 updatedb

This runs the updatedb with a reduced priority of -10. If you run top you can see the nice value under the column labelled 'NI'.

If you wish to reduce the priority of a program that's already running, you need to use the renice command with the process ID:

    # renice -10 -p 1708217082: old
    priority 0, new priority -10

This will also reduce the process's priority by 10, and depending on the nice value of the other processes, will lessen the amount of CPU time it will share with the other tasks.


# No one can hear you screen

Virtual terminals are like children: having one, two or even three brings joy to your life, but more than that puts a strain on your resources. When working remotely, some people miss having the ability to open mutliple terminals, so they simply open many SSH connections to the same machine. Not only is this a waste of bandwidth, it's also a sign you're a newbie - which you're not, right? Veterans know there's a much better way to open multiple terminals, and it comes in the form of the GNU screen program. To get started, open up a terminal, type screen, then hit Enter. Your terminal will be replaced with an empty prompt and you may think nothing has changed, but actually it has - as you'll see.

Type any command you like, eg uptime, and hit Enter. Now press Ctrl+a then c, and you should see another blank terminal. Don't worry, your old terminal is still there, and still active; this one is new. Type another command, eg ls.

Now, press Ctrl+a then 0 (zero) - you should see your original terminal again. As you can see, Ctrl+a is the combination that signals a command is coming - Ctrl+a then c creates a new terminal, and Ctrl+c then a number changes to that terminal. You can use Ctrl+a then Ctrl+a to switch to the previously selected window, Ctrl+a then Ctrl+n to switch to the next window, or Ctrl+a then Ctrl+p to switch to the previous window. To close windows, just type exit.

When your last window is closing, you also exit screen and it will print 'screen is terminating' to remind you. Alternatively - and this is the coolest thing about screen - you can press Ctrl+a then d to detach your screen session. Then, from another computer later on, use screen -r to pick up where you left off, with all the programs and output intact just as you left it - magic!


# Safe keys

We rely on encryption to keep our data safe, but this means we have various keys and passphrases we need to look after. A GPG key has a passphrase to protect it, but what about filesystem keys or SSH authentication keys. Keeping copies of them on a USB stick may seem like a good idea, until you lose the stick and all your keys enter the public domain. Even the GPG key is not safe, as it is obvious what it is and the passphrase could be cracked with a dictionary attack.

An encrypted archive of your sensitive data has a couple of advantages: it protects everything with a password (adding a second layer of encryption in the case of a GPG key) and it disguises the contents of the file. Someone finding your USB key would see a data file with no indication of its contents. Ccrypt (http://ccrypt.sourceforge.net) is a good choice for this, as it give strong encryption and can be used to encrypt tar streams, such as

    tar -c file1 file2... | ccencrypt >stuff

and extract with

    ccdecrypt <stuff | tar x

If you really want to hide your data, use Steghide (http://steghide.sourceforge.net) to hide the data within another file, such as a photo or music file

    steghide embed --embedfile stuff --coverfile img_1416.jpg

and extract it with

    steghide extract --stegofile img_1416.jpg


# A history lesson

While command completion is one of the most used and lauded aspects of Bash, an equally powerful feature often gets ignored. The history buffer, commonly used for skipping backwards and forwards through the previous commands list, offers plenty more possibilities than might otherwise be imagined. While it's easy enough to cursor up through the list, sometimes the command can be so far back in the history as to make this approach unfeasible. The history command can print the whole buffer to the screen. The most obvious use for this is to redirect the command's output into grep to find a partially remembered command.

    history | grep "command"

If the command is still in the buffer it will be displayed along with the numeric position it occupies. This command can then be re-executed simply by taking this number and prefixing an exclamation mark to the position. For example, !1016 would execute the command at point 1016 in Bash's history. Another trick is to follow the exclamation mark with part of a previous command. The history will then be searched and when a match occurs, this will be executed.

!cd would execute the last cd command in the buffer. Sadly, these commands don't add themselves to the history buffer, so recursive execution isn't possible. Another way of accessing the command history is through the search function accessed by pressing Ctrl-R from the prompt. After pressing this control sequence, you will be presented with a search prompt. Typing in the search term brings up the first command that matches the criteria, and pressing return will execute the command. Cursor left or right will insert the command on to the prompt, while up and down takes you to the previous and next commands as usual.


# Winning arguments

We can't teach you how to be the victor in every debate, but we can show you how to master another type of argument: those of the command-line. You probably already know about supplying multiple arguments to a program, for instance:

    someprog file1 file2 file3

That's all good and well when you're entering commands by hand, but what if you want to use a list generated by another program? Say, for example, you want Gimp to open the ten largest images in a directory. You could do an ls -l to find out what's biggest, and then laboriously enter each filename as in gimp file1 file2... Or you could use the magic that is xargs (included in every distro).

    ls -S --color=never | head -n10 | xargs gimp

xargs assembles complicated command-line operations using lists of files, so you don't have to type them manually. You pass xargs a list of files, and it arranges them into file1 file2 file3... as we saw before. Makes sense? Consider the above example. First we use ls to generate a list of files in the current directory (making sure we disable the colour codes as they produce unwanted characters). Then, using the good old pipe (|), we send the results to the head utility, which grabs the first ten entries.

So now we have a list of ten files. How do we tell Gimp that we want it to open them? We can't just directly pipe the results of head through, because Gimp would think it was raw graphics data. This is where the addition of xargs saves the day: it ensures that the following program name uses the data as a filename list, rather than trying to work with it directly. In our example above, it says "Take the top ten list as generated by head, and then pass it to Gimp in the traditional file1 file2 file3... format. You can do lots of things with xargs, all it expects is a list of files, separated by newline characters or spaces. As another example, this line deletes all files older than ten days (use with caution!):

    find . -mtime +10 | xargs rm


# Convert and mogrify

ImageMagick is as perennial as the grass. Found in everything from PHP scripts to KDE applications, it's a featureful bitmap editing and image processing library with a battalion of small tools. There are well over 100 of these tools, and two of the most useful are convert and mogrify - commands that rival Gimp for features. Using either, you can resize, blur, crop, sharpen and transform an image without ever needing to look at it. The difference between convert and mogrify is that with the latter you can overwrite the original images, rather than create a new file for your modified images.

Despite all this complicated functionality, one of the best reasons for using convert is its most obvious function - and that is to change the format of an image. At its simplest, you just need to include a source and destination filename, and convert will work out all the details. The following example will convert a JPEG file to a PNG:

    convert pic.jpg pic.png

ImageMagick is perfect for batches of images, but it doesn't use wildcards in quite the way you expect. convert *.jpg *.png won't work, for example. The answer is to use a slightly different syntax, and replace the convert command with mogrify. Rather than use a wildcard for the destination format, we define the type we want with the format extension. To convert a group of JPEG images into the PNG format, we would just type the following:

    mogrify -format png *.jpg

This approach can be used with any of the convert and mogrify parameters. You could use replace format with crop or scale on a batch of images, for example, if you needed to scale or crop a whole directory of images.


