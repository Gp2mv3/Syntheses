N=1;
while ( N <= max ) do
	send frame;
	wait for ack on return channel or timeout:
	if ack on return channel
		exit while;
	else
		# timeout
		# retransmission is needed
		wait for random time;
		N = N+1;
end do
# too many attempts
