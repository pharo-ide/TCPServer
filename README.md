# TCPServer
[![Build Status](https://travis-ci.org/pharo-ide/TCPServer.svg?branch=master)](https://travis-ci.org/pharo-ide/TCPServer)

It is a most primitive TCP server. 

It implements classic incoming connections loop running in background process. 

Users should subclass TCPServer and implement method #processNewConnection:. 

To start a server simply create an instance and ask it to #start:

```Smalltalk
server := TCPServerSubclass new.
server start.
```

It will run a listener socket and an incoming connections loop.

By default it allows OS to assign free port for the server (using zero port number):

```Smalltalk
server := TCPServerSubclass new.
server port. "==> 0"
server start.
server port > 0 "==> true"
```

But users can specify concrete port using #on: message: 

```Smalltalk
server := TCPServerSubclass on: 40422
```

If given port is busy the #start message will signal an error.
		
To stop the server use #stop message: 

```Smalltalk
server stop.
```

It will close listener socket and terminate incoming connections loop. 

I maintain the list of all running servers on my class side variable #RunningServers:

```Smalltalk
TCPServer runningServers
```

## Installation
```Smalltalk
Metacello new
  baseline: 'TCPServer';
  repository: 'github://pharo-ide/TCPServer';
  load
```
Use following snippet for stable dependency in your project baseline:
```Smalltalk
spec
    baseline: 'TCPServer'
    with: [ spec repository: 'github://pharo-ide/TCPServer:v1.0.1' ]
```
