printing
printSimpleStringOn: aStream

	aStream 
		print: ip;
		nextPut: $:;
		print: port