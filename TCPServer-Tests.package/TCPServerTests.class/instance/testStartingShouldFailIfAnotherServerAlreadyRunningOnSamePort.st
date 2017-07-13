tests
testStartingShouldFailIfAnotherServerAlreadyRunningOnSamePort

	| newServer |
	server start.

	newServer := server class on: server port.
	[newServer start.
	self assert: false description: 'should fail'] ifError: [  ]