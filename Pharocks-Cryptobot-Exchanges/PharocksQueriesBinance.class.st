Class {
	#name : #PharocksQueriesBinance,
	#superclass : #PharocksExchange,
	#category : #'Pharocks-Cryptobot-Exchanges'
}

{ #category : #accessing }
PharocksQueriesBinance >> configuration [
	website := 'https://www.binance.com'.
	apiUrl := 'https://api.binance.com'.
	apiUrlSecondary := 'https://fapi.binance.com'
]

{ #category : #controling }
PharocksQueriesBinance >> exchangeTime [
	self subclassResponsibility 
]

{ #category : #controling }
PharocksQueriesBinance >> initialize [
	super initialize.
	self configuration. 
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
PharocksQueriesBinance >> queryFutures: aString1 leverage: aInteger [
	^ self
		postPrivate: self apiUrlSecondary , '/fapi/v1/leverage'
		parameters:
			{('symbol' -> aString1 asString).
			('leverage' -> aInteger).
			('stopLimitTimeInForce' -> 'GTC')} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryFuturesAccountTransfer: aString1 amount: aInteger type: aString2 [
	^ self
		postPrivate: self apiUrl , '/sapi/v1/futures/transfer'
		parameters:
			{('asset' -> aString1 asString).
			('amount' -> aInteger).
			('type' -> aString2 asString).
			('recvWindow' -> 50000).
			} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryFuturesAccountTransfer: aString1 startTime: aDate [
	^ self
		postPrivate: self apiUrl , '/sapi/v1/futures/transfer'
		parameters:
			{('asset' -> aString1 asString).
			('startTime' -> aDate).
			} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryFuturesBalance [
	^ self
		getPrivate: self apiUrlSecondary , '/fapi/v2/balance'
]

{ #category : #controling }
PharocksQueriesBinance >> queryFuturesCandleStick: aString contractType: aString2 interval: intervalInteger limit: limitInteger [
	^ self
		getPrivate: self apiUrlSecondary , '/fapi/v1/continuousKlines'
		parameters:
			{('pair' -> aString asString).
			('contractType' -> aString2 asString).
			('interval' -> intervalInteger asString).
			"('startTime' -> aNumber asString).
			('endTime' -> aNumber asString)."
			('limit' -> limitInteger asNumber)} asDictionary
			
"Kline/Candlestick chart intervals:
m -> minutes; h -> hours; d -> days; w -> weeks; M -> months
1m
3m
5m
15m
30m
1h
2h
4h
6h
8h
12h
1d
3d
1w
1M"
]

{ #category : #controling }
PharocksQueriesBinance >> queryFuturesOrderCancelAll: aString [ 
	^ self
		deletePrivate: self apiUrlSecondary , '/fapi/v1/allOpenOrders'
		parameters:
			{('symbol' -> aString asString)} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryFuturesPositions [
	^ self
		getPrivate: self apiUrlSecondary , '/fapi/v2/positionRisk'
]

{ #category : #controling }
PharocksQueriesBinance >> queryFuturesPrivateOrderCreate: aString1 side: aString2 type: aString3 closePosition: aBoolean [
	^ self
		postPrivate: self apiUrlSecondary , '/fapi/v1/order'
		parameters:
			{('symbol' -> aString1 asString).
			('side' -> aString2 asString).
			('type' -> aString3 asString).
			('closePosition' -> aBoolean).
			('stopLimitTimeInForce' -> 'GTC')} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryFuturesPrivateOrderCreate: aString1 side: aString2 type: aString3 quantity: aNumber1 [
	^ self
		postPrivate: self apiUrlSecondary , '/fapi/v1/order'
		parameters:
			{('symbol' -> aString1 asString).
			('side' -> aString2 asString).
			('type' -> aString3 asString).
			('quantity' -> aNumber1).
			('stopLimitTimeInForce' -> 'GTC')} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryFuturesPrivateOrderCreate: aString1 side: aString2 type: aString3 quantity: aNumber1 atPrice: aNumber2 stopPrice: aNumber3 [ 
	^ self
		postPrivate: self apiUrlSecondary , '/fapi/v1/order'
		parameters:
			{('symbol' -> aString1 asString).
			('side' -> aString2 asString).
			('type' -> aString3 asString).
			('quantity' -> aNumber1).
			('price' -> aNumber2).
			"('stopPrice' -> aNumber3)".
			('timeInForce' -> 'GTC')} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryFuturesPrivateOrderCreate: aString1 side: aString2 type: aString3 quantity: aNumber1 stopPrice: aNumber3 [ 
	^ self
		postPrivate: self apiUrlSecondary , '/fapi/v1/order'
		parameters:
			{('symbol' -> aString1 asString).
			('side' -> aString2 asString).
			('type' -> aString3 asString).
			('quantity' -> aNumber1).
			('stopPrice' -> aNumber3).
			('stopLimitTimeInForce' -> 'GTC')} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryFuturesPrivateOrderOpen: aString1 [ 
	^ self
		getPrivate: self apiUrlSecondary , '/fapi/v1/openOrders'
		parameters:
			{('symbol' -> aString1 asString)} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryFuturesSymbolLatestPrice: aString [ 
	^ self
		get: self apiUrlSecondary , '/fapi/v1/ticker/price'
		parameters:
			{('symbol' -> aString asString)} asDictionary
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
PharocksQueriesBinance >> queryUniversalTransfer: aString1 amount: aInteger fromAccountType: aString2 toAccountType: aString3 [
	^ self
		postPrivate: self apiUrl , '/sapi/v1/sub-account/universalTransfer'
		parameters:
			{('asset' -> aString1 asString).
			('amount' -> aInteger).
			('fromAccountType' -> aString2 asString).
			('toAccountType' -> aString3 asString)} asDictionary
]

{ #category : #controling }
PharocksQueriesBinance >> queryUniversalTransferHistory [
	^ self
		getPrivate: self apiUrl , '/sapi/v1/sub-account/universalTransfer'
]

{ #category : #controling }
PharocksQueriesBinance >> timestamp [
	| timestamp | 
	^ timestamp := self exchangeTime asString.
	
]
