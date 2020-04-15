Class {
	#name : #TCPServerTestCase,
	#superclass : #TestCase,
	#instVars : [
		'server',
		'clientSockets'
	],
	#category : 'TCPServer-Tests'
}

{ #category : #testing }
TCPServerTestCase class >> isAbstract [
	^self == TCPServerTestCase 
]

{ #category : #helpers }
TCPServerTestCase >> newConnectionToServer [

	| socket |
	socket := server networkLibrary 
		openConnectionTo: self serverAddress
		timeout: 100 milliSeconds.
	
	clientSockets add: socket.

	5 milliSeconds wait.
	
	^socket
]

{ #category : #helpers }
TCPServerTestCase >> serverAddress [

	^TCPAddress localAt: server port. 
]

{ #category : #running }
TCPServerTestCase >> serverClass [
	self subclassResponsibility 
]

{ #category : #running }
TCPServerTestCase >> setUp [ 
	super setUp.
	
	clientSockets := OrderedCollection new.
	
	server := self serverClass new
]

{ #category : #running }
TCPServerTestCase >> tearDown [ 
		
	clientSockets do: [ :each | each close ].
	
	server stop.
	
	super tearDown.
]
