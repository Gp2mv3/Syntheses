# Persistent CSMA
N=1;
while ( N <= max ) do
	wait until channel becomes free;
	send frame and listen;
	wait until (end of frame) or (collision):
	if collision detected:
		stop transmitting;
		# after a special jam signal
		k = min(10, N);
		r = random(0, (2^k) - 1);
		wait for r time slots;
	else
		# no collision detected
		wait for interframe delay;
		exit while;
	N = N+1;
end do
# too many attempts
