Class {
	#name : #PharocksBinanceQueries,
	#superclass : #PharocksBinanceExchange,
	#instVars : [
		'query'
	],
	#category : #'Pharocks-Cryptobot-Binance'
}

{ #category : #controling }
PharocksBinanceQueries >> get: aUri [
	^ query get: aUri
]

{ #category : #controling }
PharocksBinanceQueries >> get: aPathString parameters: aDictionary [
	^ query get: aPathString parameters: aDictionary
]

{ #category : #controling }
PharocksBinanceQueries >> initialize [
	super initialize.
	query := PharocksCommunicator new
]

{ #category : #controling }
PharocksBinanceQueries >> queryExchangeInfo [
	^ self get: self apiUrl,'/api/v3/exchangeInfo'
]

{ #category : #controling }
PharocksBinanceQueries >> queryExchangePing [
	^ self get: self apiUrl,'/api/v3/ping'
]

{ #category : #controling }
PharocksBinanceQueries >> queryExchangeTime [
	^ self get: self apiUrl,'/api/v3/time'
]

{ #category : #controling }
PharocksBinanceQueries >> queryOrderBook: aString lastOrders: aNumber [
	^ self
		get: self apiUrl , '/api/v3/depth'
		parameters:
			{('symbol' -> aString asString).
			('limit' -> aNumber asString)} asDictionary
]

{ #category : #controling }
PharocksBinanceQueries >> querySymbolAveragePrice: aString [ 
	^ self
		get: self apiUrl , '/api/v3/avgPrice'
		parameters:
			{('symbol' -> aString asString)} asDictionary
]

{ #category : #controling }
PharocksBinanceQueries >> querySystemStatus [
	^ self get: self website,'/wapi/v3/systemStatus.html'
]

{ #category : #controling }
PharocksBinanceQueries >> queryTrades: aString lastTrades: aNumber [
	^ self
		get: self apiUrl , '/api/v3/trades'
		parameters:
			{('symbol' -> aString asString).
			('limit' -> aNumber asString)} asDictionary
]
