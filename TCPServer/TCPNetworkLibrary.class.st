"
I am simple facade for specific socket implementations.
TCPPharoNetworkLibrary  is standard sockets from Squeak.
TCPOceanNetworkLibrary can be implemented  for Ocean
"
Class {
	#name : #TCPNetworkLibrary,
	#superclass : #Object,
	#category : 'TCPServer'
}

{ #category : #operations }
TCPNetworkLibrary class >> inputStreamOn: aSocket [
	self subclassResponsibility 
]

{ #category : #operations }
TCPNetworkLibrary class >> newListenerSocketOn: port [

	self subclassResponsibility 
]

{ #category : #operations }
TCPNetworkLibrary class >> openConnectionTo: aTCPAddress timeout: timeoutDuration [

	self subclassResponsibility 
]

{ #category : #operations }
TCPNetworkLibrary class >> outputStreamOn: aSocket [
	self subclassResponsibility 
]

{ #category : #operations }
TCPNetworkLibrary class >> waitNewConnectionFrom: aListenerSocket during: aDuration [
	self subclassResponsibility 
]
