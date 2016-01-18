# UDP-CheckSum-Calculator
Written in ARM Assembly. 

Goal: Open a file named "udp.dat" and perform an 8-bit one's complement checksum on the data in it. print out the checksum as a DECIMAL number.

UDP network packets use a 16-bit wide one's complement checksum but for our purposes we will use 8-bit. Please visit http://bit.ly/1nedGry for further information on UDP checksum calculation. 

A one's complement checksum is simply the addition of the bytes with the result having all of its bits complemented.

For further information on 
