tests
testStoppingServerShouldRemoveItFromRunningList

	server start.
	
	server stop.
	
	self deny: (TCPServer runningServers includes: server)