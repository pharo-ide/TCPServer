operations
openConnectionTo: aTCPAddress timeout: timeoutDuration

	| socket secondsTimeout |
	" standart socket accept timeout in seconds as float number "
	secondsTimeout := timeoutDuration asMilliSeconds / 1000.0.

	socket  := Socket newTCP.
	socket connectTo: aTCPAddress ip port: aTCPAddress port waitForConnectionFor: secondsTimeout.

	socket isConnected
		ifFalse: [ self error: 'Cannot connect to ', aTCPAddress printString ].

	^socket