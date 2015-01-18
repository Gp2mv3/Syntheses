# Initialisation
cwnd = MSS;
ssthresh= swin;

# Ack arrival 
if tcp.ack > snd.una : # new ack, no congestion
	if cwnd < ssthresh :
		# slow-start : increase quickly cwnd
		# double cwnd every rtt 
		cwnd = cwnd + MSS
	else:
		# congestion avoidance : increase slowly cwnd
		# increase cwnd by one mss every rtt 
		cwnd = cwnd+ mss*(mss/cwnd)
else: 
	# duplicate or old ack 
	if tcp.ack==snd.una: # duplicate acknowledgement 
		dupacks++ 
		if dupacks==3: 
			retransmitsegment(snd.una) 
			ssthresh=max(cwnd/2,2*MSS) 
			cwnd=ssthresh 
		else:
			dupacks=0 
			# ack for old segment, ignored

Expiration of the retransmission timer: 
	send(snd.una) # retransmit first lost segment 
	sshtresh=max(cwnd/2,2*MSS) 
	cwnd=MSS 
