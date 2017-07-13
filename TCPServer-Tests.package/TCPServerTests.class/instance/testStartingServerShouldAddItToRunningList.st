tests
testStartingServerShouldAddItToRunningList

	server start.
	
	self assert: (TCPServer runningServers includes: server)