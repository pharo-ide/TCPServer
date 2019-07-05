"
I am most primitive TCP server. I implement classic incoming connections loop. My subclasses should implement #processNewConnection: .

I am created by #on: message with port number as argument.  Then you should call #start  to run listener socket and incoming connections loop.
I have list of running servers on class side.
#stop message will close listener socket and terminate incoming connections process. 

I delegate sockets creation to TCPNetworkLibrary implementation. It provides simple hook to set up different socket libraries (like Ocean).

Public API and Key Messages

- start  
- stop
- processNewConnection:  aSocket
 
Internal Representation and Key Implementation Points.

    Instance Variables
	incomingConnectionsProcess:		<Process>
	listenerSocket:		<Socket>
	networkLibrary:		<TCPNetworkLibrary>
	port:		<Number>
	processingPriority:		<Number>

"
Class {
	#name : #TCPServer,
	#superclass : #Object,
	#instVars : [
		'networkLibrary',
		'port',
		'listenerSocket',
		'incomingConnectionsProcess',
		'processingPriority',
		'listeningTimeout'
	],
	#classVars : [
		'AlwaysRestart',
		'RunningServers'
	],
	#category : 'TCPServer'
}

{ #category : #accessing }
TCPServer class >> alwaysRestart [
	^ AlwaysRestart ifNil: [ AlwaysRestart := true ]
]

{ #category : #accessing }
TCPServer class >> alwaysRestart: boolean [
	"Set if managed servers should always restart on image save, as opposed to only when quiting."

	^ AlwaysRestart := boolean
]

{ #category : #initialization }
TCPServer class >> initialize [
	
	SessionManager default registerNetworkClassNamed: TCPServer name
]

{ #category : #'instance creation' }
TCPServer class >> on: portNumber [ 
	^self new 
		port: portNumber
]

{ #category : #accessing }
TCPServer class >> register: aTCPServer [
	self runningServers add: aTCPServer 
]

{ #category : #accessing }
TCPServer class >> runningServers [
	^ RunningServers ifNil: [ RunningServers := IdentitySet new ]
]

{ #category : #'system startup' }
TCPServer class >> shutDown: quiting [
	"Our system shutDown hook: stop all servers we manage"
	
	(quiting or: [ self alwaysRestart ])
		ifTrue: [
			self runningServers do: [ :each | each closeConnections ] ]
]

{ #category : #'system startup' }
TCPServer class >> startUp: resuming [
	"Our system startUp hook: start all servers we manage.
	We do this using deferred startup actions to allow normal error handling."

	(resuming or: [ self alwaysRestart ])
		ifTrue: [
			SessionManager default addDeferredStartupAction: [ 
				self runningServers do: [ :each | each start ] ] ]
]

{ #category : #accessing }
TCPServer class >> unregister: aTCPServer [
	self runningServers remove: aTCPServer ifAbsent: [  ]
]

{ #category : #controlling }
TCPServer >> closeConnections [
	
	listenerSocket ifNil: [ ^self ].
	
	incomingConnectionsProcess terminate.
	incomingConnectionsProcess := nil.
	
	[listenerSocket close; destroy] ifError: [].
	listenerSocket := nil.
]

{ #category : #private }
TCPServer >> ensureNoRunningServersOnSamePort [

	(self class runningServers anySatisfy: [ :each |
		each ~~ self and: [each port = port] ])
			ifTrue: [ self error: 'There is running server on same port ', port asString ]
]

{ #category : #private }
TCPServer >> incomingConnectionsLoop [

	|clientSocket|
	
	[
		listenerSocket isUnconnectedOrInvalid ifTrue: [ self initializeListenerSocket].
		
		clientSocket := networkLibrary waitNewConnectionFrom: listenerSocket during: listeningTimeout.
		clientSocket ifNotNil: [ 
				self processNewConnection: clientSocket. 
		]
	
	] repeat 
]

{ #category : #accessing }
TCPServer >> incomingConnectionsProcess [
	^ incomingConnectionsProcess
]

{ #category : #accessing }
TCPServer >> incomingConnectionsProcess: anObject [
	incomingConnectionsProcess := anObject
]

{ #category : #initialize }
TCPServer >> initialize [ 
	super initialize.
	
	networkLibrary := TCPPharoNetworkLibrary.
	processingPriority := Processor highIOPriority.
	listeningTimeout := 10 seconds
]

{ #category : #private }
TCPServer >> initializeListenerSocket [

	listenerSocket := networkLibrary newListenerSocketOn: port
]

{ #category : #testing }
TCPServer >> isListenConnections [
	^listenerSocket notNil and: [ listenerSocket isUnconnectedOrInvalid not ]
]

{ #category : #accessing }
TCPServer >> listenerSocket [
	^ listenerSocket
]

{ #category : #accessing }
TCPServer >> listenerSocket: anObject [
	^ listenerSocket := anObject
]

{ #category : #accessing }
TCPServer >> listeningTimeout [
	^ listeningTimeout
]

{ #category : #accessing }
TCPServer >> listeningTimeout: anObject [
	listeningTimeout := anObject
]

{ #category : #accessing }
TCPServer >> networkLibrary [
	^ networkLibrary
]

{ #category : #accessing }
TCPServer >> networkLibrary: anObject [
	networkLibrary := anObject
]

{ #category : #accessing }
TCPServer >> port [
	^ port
]

{ #category : #accessing }
TCPServer >> port: anObject [
	port := anObject
]

{ #category : #printing }
TCPServer >> printOn: aStream [

	super printOn: aStream.
	
	aStream nextPut: $(; print: port; nextPut: $).
]

{ #category : #controlling }
TCPServer >> processNewConnection: clientSocket [

	self subclassResponsibility 
]

{ #category : #accessing }
TCPServer >> processingPriority [
	^ processingPriority
]

{ #category : #accessing }
TCPServer >> processingPriority: anObject [
	processingPriority := anObject
]

{ #category : #private }
TCPServer >> register [
	self class register: self.
]

{ #category : #private }
TCPServer >> runIncomingConnectionsLoop [

	incomingConnectionsProcess := [ self incomingConnectionsLoop  ] forkAt: processingPriority named: self printString  
]

{ #category : #controlling }
TCPServer >> start [
	self isListenConnections ifTrue: [^self].
	self ensureNoRunningServersOnSamePort.
	
	self initializeListenerSocket.
				
	self runIncomingConnectionsLoop.
	
	self register
]

{ #category : #controlling }
TCPServer >> stop [
	
	self closeConnections.
	self unregister
]

{ #category : #private }
TCPServer >> unregister [
	self class unregister: self
]
