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

{ #category : #accessing }
PharocksCommunicator >> get: path parameters: aDictionary [
	| webClient | 
	webClient := ZnClient new. 
	webClient url: path.
	webClient formAddAll: aDictionary.
	"self halt."
	^ NeoJSONReader fromString: webClient get. 
]
