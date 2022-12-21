Class {
	#name : #TCPServerTests,
	#superclass : #TCPServerTestCase,
	#category : #'TCPServer-Tests'
}

{ #category : #running }
TCPServerTests >> serverClass [
	^TCPServerStub
]

{ #category : #tests }
TCPServerTests >> testAcceptingIncomingConnection [

	server start.
	
	self newConnectionToServer.

	self assert: server lastIncomingConnection notNil
]

{ #category : #tests }
TCPServerTests >> testClosingListenerSocketAndThenNewConnection [

	server listeningTimeout: 10 milliSeconds.
	server start.

	2 milliSeconds wait.
	
	server listenerSocket close.
	10 milliSeconds wait.
	self newConnectionToServer.

	self assert: server lastIncomingConnection notNil
]

{ #category : #tests }
TCPServerTests >> testCorruptionListenerSocketAndThenNewConnection [

	server listeningTimeout: 10 milliSeconds.
	server start.

	2 milliSeconds wait.
	
	server listenerSocket destroy.
	10 milliSeconds wait.
	self newConnectionToServer.

	self assert: server lastIncomingConnection notNil
]

{ #category : #tests }
TCPServerTests >> testHasNetworkLibraryByDefault [

	self assert: server networkLibrary equals: TCPPharoNetworkLibrary 
]

{ #category : #tests }
TCPServerTests >> testHasProcessingPriorityByDefault [

	| baseServer |
	baseServer := TCPServer new.
	
	self assert: baseServer processingPriority equals: Processor highIOPriority
]

{ #category : #tests }
TCPServerTests >> testHasSelfAssignedZeroPortByDefault [

	self assert: server port equals: 0
]

{ #category : #tests }
TCPServerTests >> testStartingServerOnGivenPortShouldUseIt [

	| requiredPort |
	requiredPort := 40522 + 32 atRandom.
	server port: requiredPort.
	server start.

	self assert: server port equals: requiredPort
]

{ #category : #tests }
TCPServerTests >> testStartingServerOnPortWhichIsAlreadyInUse [

	| newServer |
	server start.
	server unregister. "to remove it from known running servers"
	
	newServer := self serverClass on: server port.
	[
		[newServer start.
		self assert: false description: 'should fail'] on: Error do: [:err | ].
	] ensure: [ newServer stop ]
]

{ #category : #tests }
TCPServerTests >> testStartingServerShouldAddItToRunningList [

	server start.
	
	self assert: (TCPServer runningServers includes: server)
]

{ #category : #tests }
TCPServerTests >> testStartingServerShouldAssignRetrievedPort [

	self assert: server port equals: 0.
	
	server start.

	self assert: server port > 0
]

{ #category : #tests }
TCPServerTests >> testStartingServerTwiceShouldNotCorruptServer [

	server start.
	server start.
	Smalltalk garbageCollect.
	
	self newConnectionToServer.

	self assert: server lastIncomingConnection notNil
]

{ #category : #tests }
TCPServerTests >> testStartingShouldFailIfAnotherServerAlreadyRunningOnSamePort [

	| newServer |
	server start.

	newServer := server class on: server port.
	[newServer start.
	self assert: false description: 'should fail'] on: Error do: [:err | ].
]

{ #category : #tests }
TCPServerTests >> testStoppingServerShouldRemoveItFromRunningList [

	server start.
	
	server stop.
	
	self deny: (TCPServer runningServers includes: server)
]
