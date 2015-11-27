# UDP-CheckSum-Calculator
Written in ARM Assembly. 
Open a file named "udp.dat" and perform an 8-bit one's complement checksum on the data in it. print out the checksum as a DECIMAL number.

UDP network packets (COMP429 subject matter) uses a 16-bit wide one's complement checksum but for our purposes we will use 8-bit.

A one's complement checksum is simply the addition of the bytes with the result having all of its bits complemented.
