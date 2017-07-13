# TCPServer
It is a most primitive TCP server. 

It implement classic incoming connections loop which running in background process. 

Users should subclass TCPServer and implement method #processNewConnection:. 

It maintains list of all running servers on TCPServer class side:
```Smalltalk
TCPServer runningServers
```

## Installation
```Smalltalk
Metacello new
  baseline: 'Calypso';
  repository: 'github://dionisiydk/Calypso';
  load
```
