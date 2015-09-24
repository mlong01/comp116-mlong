Matt Long
Assignment 1
9/23/2015


~~ set1.pcap ~~
1. How many packets are there in this set?

	There are 861 packets in this set	


2. What protocol was used to transfer files from the PC to the server?

	FTP-DATA, which is FTP or File Transfer Protocol into the
	specific port specified for data (20 I believe)


3. Briefly describe why the protocol to transfer the files is insecure.

	FTP transfers in plaintext, meaning I can pull the data
	transferred and it becomes a functional file of whatever
	type it was.


4. What is the secure alternative to the protocol used to transfer files?

	SFTP


5. What is the IP Address of the server?

	192.168.1.8	


6. What was the username and password used to access the server?

	username = 'defcon'
	password = 'm1ngisablowhard'	


7. How many files were transferred to PC from server?

	Six


8. What are the names of files transferred to PC from server?

	CDkv69qUsAAq8zN.jpg
	CJoWmoOUkAAAYpx.jpg
	CKBXgmOWcAAtc4u.jpg
	CLu-m0MWoAAgjkr.jpg
	CNsAEaYUYAARuaj.jpg
	COaqQWnU8AAwX3K.jpg


9. Extract all the files that were transferred from PC to server

	Kay


~~ set2.pcap ~~
10. How many packets are there in this set?

	77,982 packets

11. How many plaintext username-password pairs are there in this packet set?
    Please count any anonymous or generic accounts.

	Just one - account 'larry@rasdot.com'


12. Briefly descripbe how you found the username-password pairs.

	Use ettercap to parse the pcap file, then grep for "PASS"
	in the results (ettercap -T -r set2.pcap | grep "PASS")
	Note - I also ran with grep -i "PASS" but I got a lot of
	HTML with forms/elements named 'password' and I didn't
	find any other password-looking things.


13. For each of the plaintext username-password pair that you found, identify
    the protocol used, server IP, the corresponding domain name
    (e.g. google.com), and port number

	protocol: IMAP
	server:   87.120.13.118
	domain:	  neterra.net
	port:     143 


14. Of all the plaintext username-password pairs that you found, how
    many of them are legitimate? That is, the username-password was valid,
    access successfully granted?

	The 'larry@rasdot.com' account was legitimate - I could see
	some of Larry's emails.


~~ set3.pcap ~~
15. How many plaintext username-password pairs are there in this packet set?
    Please count any anonymous or generic accounts.

	THERE ARE THREE - hidden inside the Seymore Butts accounts, I found
	one with a username nab01620@nifty.com and one with a username jeff.
	I search/replace'd all 580 of the 'USER: seymore' strings with something
	else, then searched USER: and found those other two.

16. For each of the plaintext username-password pair that you found, identify
    the protocol used, server IP, the corresponding domain name
    (e.g. google.com), and port number

	seymore:
		protocol: HTTP
		server:   162.222.171.208
		domain:	  forum.defcon.org
		port:     80

	nifty:
		protocol: IMAP
		server:   210.131.4.155
		domain:	  nifty.ad.jp
		port:     143

	jeff:
		protocol: HTTP
		server:   54.191.109.23
		domain:	  intelctf.com
		port:     80


17. Of all the plaintext username-password pairs that you found, how
    many of them are legitimate? That is, the username-password was valid,
    access successfully granted?

	seymore was not legitimate - they kept getting 403 forbidden.
	nab01620 was legitimate - they hit email
	jeff was legitimate - they got 200 in response


18. Provide a listing of all IP addresses with corresponding hosts
    (hostname + domain name) that are in this PCAP set. Describe
    your methodology.


~~ General Questions ~~
19. How did you verify the successful username-password pairs?

	I logged into the accounts just kidding I followed their TCP 
	streams in Wireshark to see what kind of responses they were
	getting from the servers. Granted, I know that positive responses
	don't always mean legitimate accounts (I heard your goatse story)
	but that's as far as I was willing to dig. 


20. What advice would you give to the owners of the username-password
    pairs that you found so their account information would not be revealed
    "in-the-clear" in the future?

	Make sure whatever site you're using is using HTTPS instead of
	HTTP, and also using a VPN through a network that isn't being
	sniffed (or is less likely to be sniffed) could make you safer.


