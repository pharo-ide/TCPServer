operations
newListenerSocketOn: port

	| socket |
	(socket  := Socket newTCP)
		setOption: 'TCP_NODELAY' value: 1;
		setOption: 'SO_SNDBUF' value: 4096;
		setOption: 'SO_RCVBUF' value: 4096.

	socket listenOn: port backlogSize: 32.

	socket isValid
		ifFalse: [ self error: 'Cannot create socket on port ' , port asString ].
	socket localPort = port ifFalse: [ 
		socket close; destroy.
		self error: 'Port ' , port asString, ' is busy. Try use another port'].	
	
	^socket