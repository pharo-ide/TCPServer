running
tearDown 
		
	clientSockets do: [ :each | each close ].
	
	server stop.
	
	super tearDown.