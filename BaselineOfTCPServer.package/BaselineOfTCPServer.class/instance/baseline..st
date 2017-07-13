baselines
baseline: spec
   <baseline>

	spec for: #'common' do: [
		spec 
			package: #'TCPServer';
			package: #'TCPServer-Tests' with: [ spec requires: #(#TCPServer)].
		spec 
			group: 'Core' with: #(#'TCPServer');
			group: 'Tests' with: #(#'TCPServer-Tests')]