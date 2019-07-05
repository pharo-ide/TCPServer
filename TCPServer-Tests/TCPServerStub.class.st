Class {
	#name : #TCPServerStub,
	#superclass : #TCPServer,
	#instVars : [
		'lastIncomingConnection'
	],
	#category : 'TCPServer-Tests'
}

{ #category : #initialization }
TCPServerStub >> initialize [ 
	super initialize.
	
	processingPriority := Processor userBackgroundPriority 
]

{ #category : #accessing }
TCPServerStub >> lastIncomingConnection [
	^ lastIncomingConnection
]

{ #category : #starting }
TCPServerStub >> processNewConnection: clientSocket [

	lastIncomingConnection := clientSocket 
]
