testing
isListenConnections
	^listenerSocket notNil and: [ listenerSocket isUnconnectedOrInvalid not ]