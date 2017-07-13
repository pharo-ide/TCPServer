tests
testAcceptingIncomingConnection

	server start.
	
	self newConnectionToServer.

	self assert: server lastIncomingConnection notNil