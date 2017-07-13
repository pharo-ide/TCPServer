system startup
startUp: resuming
	"Our system startUp hook: start all servers we manage.
	We do this using deferred startup actions to allow normal error handling."

	(resuming or: [ self alwaysRestart ])
		ifTrue: [
			SessionManager default addDeferredStartupAction: [ 
				self runningServers do: [ :each | each start ] ] ]