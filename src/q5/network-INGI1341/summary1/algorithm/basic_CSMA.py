# Persistent CSMA
N=1;
while ( N <= max ) do
	wait until channel becomes free;
	send frame immediatly;
	wait for ack or timeout:
	if ack received
		exit while;
	else
		# timeout
		# retransmission is needed
		N = N+1;
end do
# too many attempts
