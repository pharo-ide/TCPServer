tests
testClosingListenerSocketAndThenNewConnection

	server listeningTimeout: 10 milliSeconds.
	server start.

	2 milliSeconds wait.
	
	server listenerSocket close.
	10 milliSeconds wait.
	self newConnectionToServer.

	self assert: server lastIncomingConnection notNil