running
setUp 
	super setUp.
	
	clientSockets := OrderedCollection new.
	
	server := self serverClass on: 40422