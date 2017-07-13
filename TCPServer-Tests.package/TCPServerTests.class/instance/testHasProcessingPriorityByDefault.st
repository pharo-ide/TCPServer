tests
testHasProcessingPriorityByDefault

	| baseServer |
	baseServer := TCPServer new.
	
	self assert: baseServer processingPriority equals: Processor highIOPriority