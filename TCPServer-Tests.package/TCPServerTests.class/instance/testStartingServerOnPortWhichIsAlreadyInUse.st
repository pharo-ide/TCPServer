tests
testStartingServerOnPortWhichIsAlreadyInUse

	| newServer |
	server start.
	server unregister. "to remove it from known running servers"
	
	newServer := self serverClass on: server port.
	[
		[newServer start.
		self assert: false description: 'should fail'] ifError: [  ]
	
	] ensure: [ newServer stop ]