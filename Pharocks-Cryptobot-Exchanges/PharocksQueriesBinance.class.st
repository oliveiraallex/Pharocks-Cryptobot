Class {
	#name : #PharocksQueriesBinance,
	#superclass : #PharocksExchange,
	#category : #'Pharocks-Cryptobot-Exchanges'
}

{ #category : #controling }
PharocksQueriesBinance >> exchangeTime [
	self subclassResponsibility 
]

{ #category : #controling }
PharocksQueriesBinance >> initialize [
	super initialize.
]

{ #category : #controling }
PharocksQueriesBinance >> queryExchangeInfo [
	^ self get: self apiUrl,'/api/v3/exchangeInfo'
]

{ #category : #controling }
PharocksQueriesBinance >> queryExchangePing [
	^ self get: self apiUrl,'/api/v3/ping'
]

{ #category : #controling }
PharocksQueriesBinance >> queryExchangeTime [
	^ self get: self apiUrl,'/api/v3/time'
]

{ #category : #controling }
PharocksQueriesBinance >> queryOrderBook: aString lastOrders: aNumber [
	^ self
		get: self apiUrl , '/api/v3/depth'
		parameters:
			{('symbol' -> aString asString).
			('limit' -> aNumber asString)} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryOrderCancel: aString orderId: aString2 [
	^ self
		deletePrivate: self apiUrl , '/api/v3/order'
		parameters:
			{('symbol' -> aString asString).
			('orderId' -> aString2 asString)} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryOrderCancelOCO: aString orderListId: aString2 [
	^ self
		deletePrivate: self apiUrl , '/api/v3/orderList'
		parameters:
			{('symbol' -> aString asString).
			('orderListId' -> aString2 asString)} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryPrivateAccountInformation [
	^ self getPrivate: self apiUrl , '/api/v3/account'
]

{ #category : #controling }
PharocksQueriesBinance >> queryPrivateOrderCreate: aString1 side: aString2 quantity: aNumber1 atPrice: aNumber2 [
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
PharocksQueriesBinance >> queryPrivateOrderOCOCreate: aString1 side: aString2 quantity: aNumber1 atPrice: aNumber2 stopPrice: aNumber3 stopLimitPrice: aNumber4 [
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
PharocksQueriesBinance >> queryPrivateOrderOpenGet: aString1 [ 
	^ self
		getPrivate: self apiUrl , '/api/v3/openOrders'
		parameters:
			{('symbol' -> aString1 asString)} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryPrivateOrders: aString last: aNumber [
	^ self
		getPrivate: self apiUrl , '/api/v3/allOrders'
		parameters:
			{('symbol' -> aString asString).
			('limit' -> aNumber asString)} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryPrivateOrdersOpenGet [ 
	^ self
		getPrivate: self apiUrl , '/api/v3/openOrders'
		parameters:
			{} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> querySymbolAveragePrice: aString [ 
	^ self
		get: self apiUrl , '/api/v3/avgPrice'
		parameters:
			{('symbol' -> aString asString)} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> querySymbolBestPrice: aString [ 
	^ self
		get: self apiUrl , '/api/v3/ticker/bookTicker'
		parameters:
			{('symbol' -> aString asString)} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> querySymbolLatestPrice: aString [ 
	^ self
		get: self apiUrl , '/api/v3/ticker/price'
		parameters:
			{('symbol' -> aString asString)} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> querySystemStatus [
	^ self get: self website,'/wapi/v3/systemStatus.html'
]

{ #category : #controling }
PharocksQueriesBinance >> queryTrades: aString lastTrades: aNumber [
	^ self
		get: self apiUrl , '/api/v3/trades'
		parameters:
			{('symbol' -> aString asString).
			('limit' -> aNumber asString).
			('timestamp' -> self timeStamp)} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> timestamp [
	| timestamp | 
	^ timestamp := self exchangeTime asString.
	
]
