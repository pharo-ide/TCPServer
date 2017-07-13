controlling
start
	self isListenConnections ifTrue: [^self].
	self ensureNoRunningServersOnSamePort.
	
	self initializeListenerSocket.
				
	self runIncomingConnectionsLoop.
	
	self register