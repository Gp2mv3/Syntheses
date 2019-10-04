# Initialisation
cwin = 1 # congestion window measured in segments

# Ack arrival
if newack :	# new ack, no congestion
	# increase cwin by one every rtt
	cwin = cwin + ( 1/cwin )
else:
	# no increase
	Congestion detected:
		cwnd = cwin/2	# only once per rtt
