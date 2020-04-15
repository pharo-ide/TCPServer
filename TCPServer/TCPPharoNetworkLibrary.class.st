"
I am facade for standard sockets implementation from Squeak
"
Class {
	#name : #TCPPharoNetworkLibrary,
	#superclass : #TCPNetworkLibrary,
	#category : 'TCPServer'
}

{ #category : #operations }
TCPPharoNetworkLibrary class >> inputStreamOn: aSocket [

	^SocketStream on: aSocket 
]

{ #category : #operations }
TCPPharoNetworkLibrary class >> newListenerSocketOn: port [

	| socket |
	(socket  := Socket newTCP)
		setOption: 'TCP_NODELAY' value: 1;
		setOption: 'SO_SNDBUF' value: 4096;
		setOption: 'SO_RCVBUF' value: 4096.

	socket listenOn: port backlogSize: 32.

	socket isValid
		ifFalse: [ self error: 'Cannot create socket on port ' , port asString ].
	port ~= 0 & (socket localPort ~= port) ifTrue: [ 
		socket close; destroy.
		self error: 'Port ' , port asString, ' is busy. Try use another port'].	
	
	^socket
]

{ #category : #operations }
TCPPharoNetworkLibrary class >> openConnectionTo: aTCPAddress timeout: timeoutDuration [

	| socket secondsTimeout |
	" standart socket accept timeout in seconds as float number "
	secondsTimeout := timeoutDuration asMilliSeconds / 1000.0.

	socket  := Socket newTCP.
	socket connectTo: aTCPAddress ip port: aTCPAddress port waitForConnectionFor: secondsTimeout.

	socket isConnected
		ifFalse: [ self error: 'Cannot connect to ', aTCPAddress printString ].

	^socket
]

{ #category : #operations }
TCPPharoNetworkLibrary class >> outputStreamOn: aSocket [

	^SocketStream on: aSocket 
]

{ #category : #operations }
TCPPharoNetworkLibrary class >> waitNewConnectionFrom: aListenerSocket during: aDuration [

	^aListenerSocket waitForAcceptFor: aDuration asMilliSeconds / 1000.0
]
