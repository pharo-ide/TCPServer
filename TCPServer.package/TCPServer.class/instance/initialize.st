initialize
initialize 
	super initialize.
	
	networkLibrary := TCPPharoNetworkLibrary.
	processingPriority := Processor highIOPriority.
	listeningTimeout := 10 seconds