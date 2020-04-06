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
PharocksBinanceQueries >> queryOrderCancel: aString orderId: aString2 [
	^ self
		deletePrivate: self apiUrl , '/api/v3/order'
		parameters:
			{('symbol' -> aString asString).
			('orderId' -> aString2 asString)} asDictionary
]

{ #category : #controling }
PharocksBinanceQueries >> queryOrderCancelOCO: aString orderListId: aString2 [
	^ self
		deletePrivate: self apiUrl , '/api/v3/orderList'
		parameters:
			{('symbol' -> aString asString).
			('orderListId' -> aString2 asString)} asDictionary
]

{ #category : #controling }
PharocksBinanceQueries >> queryPrivateAccountInformation [
	^ self getPrivate: self apiUrl , '/api/v3/account'
]

{ #category : #controling }
PharocksBinanceQueries >> queryPrivateOrderCreate: aString1 side: aString2 quantity: aNumber1 atPrice: aNumber2 [
	^ self
		postPrivate: self apiUrl , '/api/v3/order'
		parameters:
			{('symbol' -> aString1 asString).
			('side' -> aString2 asString).
			('type' -> 'LIMIT').
			('timeInForce' -> 'GTC').
			('quantity' -> aNumber1).
			('price' -> aNumber2)} asDictionary
]

{ #category : #controling }
PharocksBinanceQueries >> queryPrivateOrderOCOCreate: aString1 side: aString2 quantity: aNumber1 atPrice: aNumber2 stopPrice: aNumber3 stopLimitPrice: aNumber4 [
	^ self
		postPrivate: self apiUrl , '/api/v3/order/oco'
		parameters:
			{('symbol' -> aString1 asString).
			('side' -> aString2 asString).
			('quantity' -> aNumber1).
			('price' -> aNumber2).
			('stopPrice' -> aNumber3).
			('stopLimitPrice' -> aNumber4).
			('stopLimitTimeInForce' -> 'GTC')} asDictionary
]

{ #category : #controling }
PharocksBinanceQueries >> queryPrivateOrderOpenGet: aString1 [ 
	^ self
		getPrivate: self apiUrl , '/api/v3/openOrders'
		parameters:
			{('symbol' -> aString1 asString)} asDictionary
]

{ #category : #controling }
PharocksBinanceQueries >> queryPrivateOrders: aString last: aNumber [
	^ self
		getPrivate: self apiUrl , '/api/v3/allOrders'
		parameters:
			{('symbol' -> aString asString).
			('limit' -> aNumber asString)} asDictionary
]

{ #category : #controling }
PharocksBinanceQueries >> queryPrivateOrdersOpenGet [ 
	^ self
		getPrivate: self apiUrl , '/api/v3/openOrders'
		parameters:
			{} asDictionary
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
PharocksBinanceQueries >> timestamp [
	| timestamp | 
	^ timestamp := self exchangeTime asString.
	
]
