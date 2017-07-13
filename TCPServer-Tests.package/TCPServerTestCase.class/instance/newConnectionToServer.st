helpers
newConnectionToServer

	| socket |
	socket := server networkLibrary 
		openConnectionTo: self serverAddress
		timeout: 100 milliSeconds.
	
	clientSockets add: socket.

	5 milliSeconds wait.
	
	^socket