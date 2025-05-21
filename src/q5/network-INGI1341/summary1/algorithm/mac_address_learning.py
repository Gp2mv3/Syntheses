# Arrival of frame F on port P
# Table : MAC address table dictionary : addr->port
# Ports : list of all ports on the switch
src=F.SourceAddress
dst=F.DestinationAddress
Table[src]=P #src heard on port P
if isUnicast(dst) :
  if dst in Table:
    ForwardFrame(F,Table[dst])
  else:
    for o in Ports :
      if o!= P : ForwardFrame(F,o)
else:
  # multicast or broadcast destination
  for o in Ports :
     if o != P : ForwardFrame(F,o)
