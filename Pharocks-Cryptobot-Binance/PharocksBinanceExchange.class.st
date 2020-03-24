Class {
	#name : #PharocksBinanceExchange,
	#superclass : #Object,
	#instVars : [
		'apiKey',
		'secretKey',
		'website',
		'apiUrl',
		'runQuery'
	],
	#category : #'Pharocks-Cryptobot-Binance'
}

{ #category : #accessing }
PharocksBinanceExchange >> apiKey [
	^ apiKey
]

{ #category : #accessing }
PharocksBinanceExchange >> apiKey: aString [
	apiKey := aString
]

{ #category : #accessing }
PharocksBinanceExchange >> configuration [
	website := 'https://www.binance.com'.
	apiUrl := 'https://www.binance.com/api/'
]

{ #category : #initialization }
PharocksBinanceExchange >> cryptoPairPrice [
	
	"runQuery to take the data from Binance"
	^ 12.21 "hardcoded"
]

{ #category : #initialization }
PharocksBinanceExchange >> initialize [
	self configuration .
	
	runQuery := PharocksBinanceOperations new.
]

{ #category : #accessing }
PharocksBinanceExchange >> secretKey [
	^ secretKey
]

{ #category : #accessing }
PharocksBinanceExchange >> secretKey: aString [
	secretKey := aString
]
