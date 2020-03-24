Class {
	#name : #PharocksCommunicator,
	#superclass : #Object,
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #accessing }
PharocksCommunicator >> get: query [
	| webClient | 
	webClient := ZnClient new. 
	webClient url: query.
	^ NeoJSONReader fromString: webClient get. 
]
