Class {
	#name : #PharocksDelegate,
	#superclass : #Object,
	#instVars : [
		'pharocksController'
	],
	#category : #'Pharocks-Cryptobot-Server'
}

{ #category : #'as yet unclassified' }
PharocksDelegate >> handleRequest: aRequest [
	PharocksLog logAdd: 'SIGNAL RECEIVED: ',aRequest asString.
	self perform: aRequest uri lastPathSegment asSymbol.
	^ ZnResponse ok: aRequest uri
]

{ #category : #'as yet unclassified' }
PharocksDelegate >> pharocks: aPharocks [
	pharocksController := aPharocks
]

{ #category : #'as yet unclassified' }
PharocksDelegate >> setStochRSIDown20 [ 
	PharocksOperator setIndicator: 'stochRSI' value: 'down20'
]

{ #category : #'as yet unclassified' }
PharocksDelegate >> setStochRSIDown80 [
	PharocksOperator setIndicator: 'stochRSI' value: 'down80'
]

{ #category : #'as yet unclassified' }
PharocksDelegate >> setStochRSIUp20 [
	PharocksOperator setIndicator: 'stochRSI' value: 'up20'
]

{ #category : #'as yet unclassified' }
PharocksDelegate >> setStochRSIUp80 [
	PharocksOperator setIndicator: 'stochRSI' value: 'up80'
]
