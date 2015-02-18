VAR lolo init("lo");
lolo:="Je suis une phrase";

// a)
output LENGTH(lolo);

// b)
VAR pre init("je suis");
output REGION_MATCHES(lolo, true, 0, pre, 0, LENGTH(pre));

// c)
output SUBSTRING(lolo, 2, 5);
