tests
testStartingServerTwiceShouldNotCorruptServer

	server start.
	server start.
	Smalltalk garbageCollect.
	
	self newConnectionToServer.

	self assert: server lastIncomingConnection notNil