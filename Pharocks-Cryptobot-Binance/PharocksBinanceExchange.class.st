Class {
	#name : #PharocksBinanceExchange,
	#superclass : #Object,
	#instVars : [
		'apiKey',
		'apiSecretKey',
		'website',
		'apiUrl'
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
PharocksBinanceExchange >> apiSecretKey [
	^ apiSecretKey
]

{ #category : #accessing }
PharocksBinanceExchange >> apiSecretKey: aString [
	apiSecretKey := aString
]

{ #category : #accessing }
PharocksBinanceExchange >> apiUrl [
	^ apiUrl
]

{ #category : #accessing }
PharocksBinanceExchange >> apiUrl: anObject [
	apiUrl := anObject
]

{ #category : #accessing }
PharocksBinanceExchange >> configuration [
	website := 'https://www.binance.com'.
	apiUrl := 'https://www.binance.com/api/'
]

{ #category : #initialization }
PharocksBinanceExchange >> initialize [
	self configuration .
	
	"runQuery := PharocksBinanceOperations new."
]

{ #category : #accessing }
PharocksBinanceExchange >> website [
	^ website
]

{ #category : #accessing }
PharocksBinanceExchange >> website: anObject [
	website := anObject
]
