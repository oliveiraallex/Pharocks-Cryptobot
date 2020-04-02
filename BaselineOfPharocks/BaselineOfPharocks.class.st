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
				package: 'Pharocks-Cryptobot-Binance' ].
	spec
		baseline: 'OpenSSL'
		with: [ spec
				repository: 'github://PierceNg/OpenSSL-Pharo/blob/master/src-st' ]
]

{ #category : #baselines }
BaselineOfPharocks >> projectClass [
	^ MetacelloCypressBaselineProject
]
