N=1;
while ( N <= max ) do
	if (previous frame corrupted) :
		wait until channel free during t >= EIFS;
	else
		wait until end of frame;
		wait until channel free during t >= DIFS;
	backoff_time = int(random[0, min(255, 7*2^(N-1))]) * T;
	wait (channel free during backoff_time)
	send date frame;
	wait for ack or timeout:
		if ack received
			exit while;
		else
			# timeout retransmission is needed
			N = N+1;
end do
# too many attempts
