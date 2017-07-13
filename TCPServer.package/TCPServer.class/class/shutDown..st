system startup
shutDown: quiting
	"Our system shutDown hook: stop all servers we manage"
	
	(quiting or: [ self alwaysRestart ])
		ifTrue: [
			self runningServers do: [ :each | each closeConnections ] ]