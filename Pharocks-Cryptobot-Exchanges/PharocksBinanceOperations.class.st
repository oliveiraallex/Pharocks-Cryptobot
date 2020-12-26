Class {
	#name : #PharocksBinanceOperations,
	#superclass : #PharocksQueriesBinance,
	#instVars : [
		'exchangeInfoCache',
		'futuresBalanceCache',
		'futuresPositionsCache',
		'futuresSymbolLatestPriceCache',
		'futuresSymbolPrivateOrderOpenCache',
		'privateAccountInformationCache',
		'symbolAvaregePriceCache',
		'symbolBestPriceCache',
		'symbolLatestPriceCache',
		'futuresPrivateOrderOpenCache',
		'exchangeTimeCache',
		'orderBookLastOrdersCache'
	],
	#category : #'Pharocks-Cryptobot-Exchanges'
}

{ #category : #initialization }
PharocksBinanceOperations >> exchangeInfo [
	| get |
	get := [ self queryExchangeInfo.
	] on: Error do: [ :error | PharocksLog logAdd: error asString,'. Loading CACHE ',exchangeInfoCache asString. ^ exchangeInfoCache ].
	exchangeInfoCache := get.
	^ exchangeInfoCache
]

{ #category : #initialization }
PharocksBinanceOperations >> exchangePing [
	| answerSystemStatus status |
	answerSystemStatus := self queryExchangePing.
	status := answerSystemStatus isEmpty
		ifTrue: [ true ]
		ifFalse: [ false ].
	^ status
]

{ #category : #initialization }
PharocksBinanceOperations >> exchangeStatus [
	| answerSystemStatus status |
	answerSystemStatus := self querySystemStatus.
	status := (answerSystemStatus at: 'status') = 0
		ifTrue: [ true ]
		ifFalse: [ false ].
	^ status
]

{ #category : #initialization }
PharocksBinanceOperations >> exchangeTime [
	| get |
	get := [ self queryExchangeTime.
		] on: Error do: [ :error | PharocksLog logAdd: error asString,'. Loading CACHE ', exchangeTimeCache asString. ^ exchangeTimeCache ].
	exchangeTimeCache := get at: #serverTime.
	^ exchangeTimeCache
]

{ #category : #initialization }
PharocksBinanceOperations >> futures: aString1 leverage: aInteger [

	^ self queryFutures: aString1 leverage: aInteger
]

{ #category : #initialization }
PharocksBinanceOperations >> futuresAccountTransfer: aString1 amount: aInteger type: aString2 [
	^ self queryFuturesAccountTransfer: aString1 amount: aInteger type: aString2
]

{ #category : #initialization }
PharocksBinanceOperations >> futuresBalance [
	| get |
	get := [ ((self queryFuturesBalance at: 1) at: 'availableBalance') asNumber 
		] on: Error do: [ :error | PharocksLog logAdd: error asString,'. Loading CACHE ',futuresBalanceCache asString. ^ futuresBalanceCache ].
	futuresBalanceCache := get.
	^ futuresBalanceCache
]

{ #category : #initialization }
PharocksBinanceOperations >> futuresCandleStick: aString contractType: aString2 interval: intervalInteger limit: limitInteger [
	^ self queryFuturesCandleStick: aString contractType: aString2 interval: intervalInteger limit: limitInteger
]

{ #category : #initialization }
PharocksBinanceOperations >> futuresOrderCancelAll: aString [

	^ self queryFuturesOrderCancelAll: aString
]

{ #category : #initialization }
PharocksBinanceOperations >> futuresPositions [

	| get |
	get := [self queryFuturesPositions.
		] on: Error do: [ :error | PharocksLog logAdd: error asString,'. Loading CACHE ',futuresPositionsCache asString. ^ futuresPositionsCache ].
	futuresPositionsCache := get.
	^ futuresPositionsCache
]

{ #category : #initialization }
PharocksBinanceOperations >> futuresPrivateOrderCreate: aString1 side: aString2 type: aString3 quantity: aNumber1 atPrice: aNumber2 stopPrice: aNumber3 [
	aNumber2 
		ifNil: [  
			aNumber3	ifNotNil: [ ^ self queryFuturesPrivateOrderCreate: aString1 side: aString2 type: aString3 quantity: aNumber1 stopPrice: aNumber3 ]
						ifNil: [ ^ self queryFuturesPrivateOrderCreate: aString1 side: aString2 type: aString3 quantity: aNumber1 ] ] 
		ifNotNil: [ ^self queryFuturesPrivateOrderCreate: aString1 side: aString2 type: aString3 quantity: aNumber1 atPrice: aNumber2 stopPrice: aNumber3  ]
	
]

{ #category : #initialization }
PharocksBinanceOperations >> futuresPrivateOrderOpen: aString [

	| get |
	get := [ self queryFuturesPrivateOrderOpen:  aString.
	] on: Error do: [ :error | PharocksLog logAdd: error asString,'. Loading CACHE ',futuresPrivateOrderOpenCache asString. ^ futuresPrivateOrderOpenCache ].
	futuresPrivateOrderOpenCache := get.
	^ futuresPrivateOrderOpenCache
]

{ #category : #initialization }
PharocksBinanceOperations >> futuresSymbolLatestPrice: aString [

	| get |
	get := [((self queryFuturesSymbolLatestPrice: aString) at: 'price') asNumber.
	] on: Error do: [ :error | PharocksLog logAdd: error asString,'. Loading CACHE ',futuresSymbolLatestPriceCache asString. ^ futuresSymbolLatestPriceCache ].
	futuresSymbolLatestPriceCache := get.
	^ futuresSymbolLatestPriceCache
]

{ #category : #initialization }
PharocksBinanceOperations >> futuresSymbolPrivateOrderOpen: aString [

	| get |
	get := [((self queryFuturesPrivateOrderOpen:  aString) at: 'price') asNumber.
	] on: Error do: [ :error | PharocksLog logAdd: error asString,'. Loading CACHE ',futuresSymbolPrivateOrderOpenCache asString. ^ futuresSymbolPrivateOrderOpenCache ].
	futuresSymbolPrivateOrderOpenCache := get.
	^ futuresSymbolPrivateOrderOpenCache
]

{ #category : #initialization }
PharocksBinanceOperations >> orderBook: aString lastOrders: aNumber [
	| get |
	get := [self queryOrderBook: aString lastOrders: aNumber.
		] on: Error do: [ :error | PharocksLog logAdd: error asString,'. Loading CACHE ', orderBookLastOrdersCache asString. ^ orderBookLastOrdersCache ].
	orderBookLastOrdersCache := get.
	^ orderBookLastOrdersCache
]

{ #category : #initialization }
PharocksBinanceOperations >> orderCancel: aString orderId: aString2 [
	^ self queryOrderCancel: aString orderId: aString2
]

{ #category : #initialization }
PharocksBinanceOperations >> orderCancelOCO: aString orderListId: aString2 [
	^ self queryOrderCancelOCO: aString orderListId: aString2
]

{ #category : #initialization }
PharocksBinanceOperations >> orderCreateBuy: aString atPrice: aNumber [
	^ true "hardcoded"
]

{ #category : #initialization }
PharocksBinanceOperations >> orderCreateSell: aString atPrice: aNumber [
	^ true "hardcoded"
]

{ #category : #operations }
PharocksBinanceOperations >> privateAccountInformation [
	| get |
	get := [self queryPrivateAccountInformation.
	] on: Error do: [ :error | PharocksLog logAdd: error asString,'. Loading CACHE ',privateAccountInformationCache asString. ^ privateAccountInformationCache ].
	privateAccountInformationCache := get.
	^ privateAccountInformationCache
]

{ #category : #initialization }
PharocksBinanceOperations >> privateOrderCreate: aString1 side: aString2 quantity: aNumber1 atPrice: aNumber2 [
	^ self queryPrivateOrderCreate: aString1 side: aString2 quantity: aNumber1 atPrice: aNumber2
]

{ #category : #initialization }
PharocksBinanceOperations >> privateOrderOCOCreate: aString1 side: aString2 quantity: aNumber1 atPrice: aNumber2 stopPrice: aNumber3 stopLimitPrice: aNumber4 [
	^ self queryPrivateOrderOCOCreate: aString1 side: aString2 quantity: aNumber1 atPrice: aNumber2 stopPrice: aNumber3 stopLimitPrice: aNumber4
]

{ #category : #initialization }
PharocksBinanceOperations >> privateOrderOpenGet: aString1 [
	aString1 = ''
		ifTrue: [ ^ self queryPrivateOrdersOpenGet ]
		ifFalse: [ ^ self queryPrivateOrderOpenGet: aString1 ]
]

{ #category : #operating }
PharocksBinanceOperations >> privateOrders: aString last: anInteger [ 
	^ self queryPrivateOrders: aString last: anInteger 
]

{ #category : #initialization }
PharocksBinanceOperations >> symbolAvaregePrice: aString [
	"Average of price of a cryptocoin in the last 5 minutes"
	| get | 
	get := [self querySymbolAveragePrice: aString.
	] on: Error do: [ :error | PharocksLog logAdd: error asString,'. Loading CACHE ',symbolAvaregePriceCache asString. ^ symbolAvaregePriceCache ].
	symbolAvaregePriceCache := (get at: 'price') asNumber.
	^ symbolAvaregePriceCache
]

{ #category : #initialization }
PharocksBinanceOperations >> symbolBestPrice: aString [
	"Average of price of a cryptocoin in the last 5 minutes"
	| get |
	get := [self querySymbolBestPrice: aString.
		] on: Error do: [ :error | PharocksLog logAdd: error asString,'. Loading CACHE ',symbolBestPriceCache asString. ^ symbolBestPriceCache ].
	symbolBestPriceCache := get.
	^ symbolBestPriceCache
]

{ #category : #initialization }
PharocksBinanceOperations >> symbolLatestPrice: aString [
	"Average of price of a cryptocoin in the last 5 minutes"
	| get | 
	get := [self querySymbolLatestPrice: aString.
		] on: Error do: [ :error | PharocksLog logAdd: error asString,'. Loading CACHE ',symbolBestPriceCache asString. ^ symbolBestPriceCache ].
	symbolBestPriceCache := (get at: 'price') asNumber.
	^ symbolBestPriceCache
]

{ #category : #initialization }
PharocksBinanceOperations >> universalTransfer: aString1 amount: aInteger fromAccountType: aString2 toAccountType: aString3 [

	^ self queryUniversalTransfer: aString1 amount: aInteger fromAccountType: aString2 toAccountType: aString3
]

{ #category : #initialization }
PharocksBinanceOperations >> universalTransferHistory [
	^ self queryUniversalTransferHistory
]
