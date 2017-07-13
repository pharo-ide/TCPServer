private
ensureNoRunningServersOnSamePort

	(self class runningServers anySatisfy: [ :each |
		each ~~ self and: [each port = port] ])
			ifTrue: [ self error: 'There is running server on same port ', port asString ]