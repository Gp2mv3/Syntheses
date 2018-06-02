TYPE CID2 POSSREP CID2 {
		C CHAR
		CONSTRAINT MATCHES(C, "LINGI[0-9]{4}")
	               };

TYPE SID POSSREP SID {
		C CHAR 
		CONSTRAINT MATCHES(C, "[0-9]{4}-[0-9]{2}-[0-9]{2}")
	               };
