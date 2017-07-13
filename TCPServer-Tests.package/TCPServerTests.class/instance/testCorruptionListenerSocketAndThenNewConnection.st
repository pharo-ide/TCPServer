tests
testCorruptionListenerSocketAndThenNewConnection

	server listeningTimeout: 10 milliSeconds.
	server start.

	2 milliSeconds wait.
	
	server listenerSocket destroy.
	10 milliSeconds wait.
	self newConnectionToServer.

	self assert: server lastIncomingConnection notNil