Received(Vector V[], link l) { # received vector from link l
   for destination=d in V[] {
	if (d isin R[]) {
		if ( (V[d].cost+l.cost < R[d].cost )
			or (R[d].link == l) ) {
			# better route or change to current route
			R[d].cost = V[d].cost+l.cost;
			R[d].link = l;
			R[d].time = now;
		}
	}
	else { # new route
		R[d].cost = V[d].cost+l.cost;
		R[d].link = l;
		R[d].time = now;
	}
}
