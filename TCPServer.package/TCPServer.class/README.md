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
