Assignment 2 - incident alarm
Matt Long

1. I have correctly implemented detection of NULL, FIN, and XMAS scans when
   analyzing the network, and I am able to pull out every kind of incident
   for the web log.

   I don't know if I correctly implemented the other NMAP, Nikto, or Credit
   card detectors correctly, because I couldn't get a proper test. I tested by 
   scanning my VM from my own machine (running Ubuntu), but couldn't get the
   payload to display anything from those scans. I looked through Piazza and
   saw other people with that issue, but since it's 2.5 days late I didn't want
   to push it off longer to find you and ask in person. Based on what I read
   on Piazza, I think I did it right (regex check against the packet for binary
   'nmap' or 'nikto', and for CC a not-binary credit card number in the packet).
   I also couldn't get my quote-finding regex expression to recognize the quotes
   in the packet containing what I think is actually the payload in the server
   log - right now it only shows the HTTP request.


2. Skyler Tom and Walton Lee helped me out when I got stuck a couple times.
   I also found the quote-finding regex expression on stack overflow.


3. I spent approximately 7-8 hours on this assignment (although most of
   them came in the past couple days)


4. The heuristics may be good for super basic attacks, but I definitely
   wouldn't feel comfortable unleashing this on a company network. The
   methods for detecting the incidents aren't specific to that particular
   incident, and as somebody on Piazza said, "lead to a lot of false
   positives". A lot of the attacks have to be run in a specific way
   (like the nmap command to make a payload) in order for our tool to recognize
   them.


5. I would probably have the program do some system checks to report
   anything different that happened - like if shell code or shellshock
   was detected, try and access the last few bash commands ran to see
   if anything suspicious was run. If it was off log files, we could pull
   out the timestamp from the packet and compare it to timestamps in the
   log, then analyze anything that may have happened within the system
   around that time.
