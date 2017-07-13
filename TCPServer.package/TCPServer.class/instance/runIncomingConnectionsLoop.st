private
runIncomingConnectionsLoop

	incomingConnectionsProcess := [ self incomingConnectionsLoop  ] forkAt: processingPriority named: self printString  