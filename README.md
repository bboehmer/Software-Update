This is a script that checks to see what applications are out of date on our Macintosh machines.

First, I get the most recent version that has been released to the public by checking the JAMF Nation website. 
JAMF Nation is the largest Apple IT management community in the world and they are constantly updating information about the most recent releases of software.

I then check to see if the most recent version released to the public is the same as the one we are currently using on our JAMF Software Server.
We use this software server as a way for the computers on campus to easily access the packages they need.

Once I make a list of all the applications that are out of date I then create a webpage using Ruby on Rails to display this information.
In theory I could have the script runnning every so often on another server and would allow me to access a webpage and immediately know what applications need updated.
As of right now I just run the script and open the web page when I am interested in knowing that information.
