operations
waitNewConnectionFrom: aListenerSocket during: aDuration

	^aListenerSocket waitForAcceptFor: aDuration asMilliSeconds / 1000.0