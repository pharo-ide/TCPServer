private
incomingConnectionsLoop

	|clientSocket|
	
	[
		listenerSocket isUnconnectedOrInvalid ifTrue: [ self initializeListenerSocket].
		
		clientSocket := networkLibrary waitNewConnectionFrom: listenerSocket during: listeningTimeout.
		clientSocket ifNotNil: [ 
				self processNewConnection: clientSocket. 
		]
	
	] repeat 