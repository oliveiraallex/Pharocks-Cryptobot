Class {
	#name : #PharocksBinanceQueries,
	#superclass : #PharocksBinanceExchange,
	#instVars : [
		'query'
	],
	#category : #'Pharocks-Cryptobot-Binance'
}

{ #category : #controling }
PharocksBinanceQueries >> exchangeTime [
	self subclassResponsibility 
]

{ #category : #controling }
PharocksBinanceQueries >> initialize [
	super initialize.
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
PharocksBinanceQueries >> queryPrivateAccountInformation [
	| timestamp |
	timestamp := self exchangeTime. 
	^ self
		getPrivate: self apiUrl , '/api/v3/account'
		parameters:
			{('timestamp' -> timestamp asString)} asDictionary
]

{ #category : #controling }
PharocksBinanceQueries >> queryPrivateOrders: aString last: aNumber [
	^ self
		getPrivate: self apiUrl , '/api/v3/allOrders'
		parameters:
			{('symbol' -> aString asString).
			('limit' -> aNumber asString).
			('timestamp' -> self timeStamp)} asDictionary
]

{ #category : #controling }
PharocksBinanceQueries >> querySymbolAveragePrice: aString [ 
	^ self
		get: self apiUrl , '/api/v3/avgPrice'
		parameters:
			{('symbol' -> aString asString)} asDictionary
]

{ #category : #controling }
PharocksBinanceQueries >> querySymbolBestPrice: aString [ 
	^ self
		get: self apiUrl , '/api/v3/ticker/bookTicker'
		parameters:
			{('symbol' -> aString asString)} asDictionary
]

{ #category : #controling }
PharocksBinanceQueries >> querySymbolLatestPrice: aString [ 
	^ self
		get: self apiUrl , '/api/v3/ticker/price'
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
			('limit' -> aNumber asString).
			('timestamp' -> self timeStamp)} asDictionary
]

{ #category : #controling }
PharocksBinanceQueries >> timeStamp [
	| timestamp | 
	^ timestamp := self exchangeTime asString.
	
]
