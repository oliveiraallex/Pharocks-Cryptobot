Class {
	#name : #PharocksExchangeQueries,
	#superclass : #PharocksCryptocurrencyExchange,
	#instVars : [
		'exchange'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #initialization }
PharocksExchangeQueries >> createExchange: anObject [
	exchange := anObject
]

{ #category : #initialization }
PharocksExchangeQueries >> cryptoPairPrice [
	"return the crypto pair price"
]

{ #category : #initialization }
PharocksExchangeQueries >> initialize [ 
]
