controlling
closeConnections
	
	listenerSocket ifNil: [ ^self ].
	
	incomingConnectionsProcess terminate.
	incomingConnectionsProcess := nil.
	
	[listenerSocket close; destroy] ifError: [].
	listenerSocket := nil.