"
I am tcp address: IP and port number
"
Class {
	#name : #TCPAddress,
	#superclass : #Object,
	#instVars : [
		'ip',
		'port'
	],
	#category : 'TCPServer'
}

{ #category : #'instance creation' }
TCPAddress class >> ip: hostAddressIP4Bytes port: hostAddressPort [
	^self new 
		ip: hostAddressIP4Bytes;
		port: hostAddressPort
]

{ #category : #'instance creation' }
TCPAddress class >> localAt: hostAddressPort [
	^self ip: self localIP port: hostAddressPort
]

{ #category : #'instance creation' }
TCPAddress class >> localIP [
	^#[127 0 0 1]
]

{ #category : #comparing }
TCPAddress >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ ip = anObject ip and: [ port = anObject port ]
]

{ #category : #comparing }
TCPAddress >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ ip hash bitXor: port hash
]

{ #category : #accessing }
TCPAddress >> ip [
	^ ip
]

{ #category : #accessing }
TCPAddress >> ip: anObject [
	ip := anObject
]

{ #category : #accessing }
TCPAddress >> port [
	^ port
]

{ #category : #accessing }
TCPAddress >> port: anObject [
	port := anObject
]

{ #category : #printing }
TCPAddress >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.
	self printSimpleStringOn: aStream.
	aStream nextPut: $).
]

{ #category : #printing }
TCPAddress >> printSimpleStringOn: aStream [

	aStream 
		print: ip;
		nextPut: $:;
		print: port
]
