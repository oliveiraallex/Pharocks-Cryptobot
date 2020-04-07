Class {
	#name : #BaselineOfPharocks,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharocks
}

{ #category : #baselines }
BaselineOfPharocks >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'Pharocks-Cryptobot-Core';
				package: 'Pharocks-Cryptobot-Binance';
				package: 'Pharocks-Cryptobot-Server' ].
	spec
		baseline: 'OpenSSL'
		with: [ spec repository: 'github://PierceNg/OpenSSL-Pharo/src-st' ].
	spec
		baseline: 'NeoJSON'
		with: [ spec repository: 'github://svenvc/NeoJSON/repository' ]
]

{ #category : #baselines }
BaselineOfPharocks >> projectClass [
	^ MetacelloCypressBaselineProject
]
