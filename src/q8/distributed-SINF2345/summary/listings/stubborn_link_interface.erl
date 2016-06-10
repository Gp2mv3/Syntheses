upon event <Init> do
    sent := $\emptyset$
    startTimer(delay)

upon event <Timeout> do
    forall (dest, m) $\in$ sent do
        trigger <flp2pSend | dest, m>
    startTimer(delay)

// Request
upon event <sp2pSend | dest, m> do
    send := sent $\cup$ { (dest, m) }

// Indication
upon event <flp2pDeliver | src, m> do
    trigger <sp2pDeliver src, m>
