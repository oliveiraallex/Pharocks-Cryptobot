Class {
	#name : #PharocksBinanceOperations,
	#superclass : #PharocksQueriesBinance,
	#category : #'Pharocks-Cryptobot-Exchanges'
}

{ #category : #initialization }
PharocksBinanceOperations >> exchangeInfo [
	^ self queryExchangeInfo
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
	| answerSystemStatus status |
	answerSystemStatus := self queryExchangeTime.
	status := answerSystemStatus isEmpty 
		ifTrue: [ false ]
		ifFalse: [ answerSystemStatus at: #serverTime ].
	^ status
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

	^ ((self queryFuturesBalance at: 1) at: 'availableBalance') asNumber.
]

{ #category : #initialization }
PharocksBinanceOperations >> futuresOrderCancelAll: aString [

	^ self queryFuturesOrderCancelAll: aString
]

{ #category : #initialization }
PharocksBinanceOperations >> futuresPositions [

	^ self queryFuturesPositions
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

	^ self queryFuturesPrivateOrderOpen:  aString
]

{ #category : #initialization }
PharocksBinanceOperations >> futuresSymbolLatestPrice: aString [

	^ ((self queryFuturesSymbolLatestPrice: aString) at: 'price') asNumber
]

{ #category : #initialization }
PharocksBinanceOperations >> futuresSymbolPrivateOrderOpen: aString [

	^ ((self queryFuturesPrivateOrderOpen:  aString) at: 'price') asNumber
]

{ #category : #initialization }
PharocksBinanceOperations >> orderBook: aString lastOrders: aNumber [
	| answer result msg |
	answer := self queryOrderBook: aString lastOrders: aNumber.
	(answer includesKey: 'code') ifTrue: [ ((answer at: 'code') = -1100)
		ifTrue: [ msg := answer at: 'msg'.
			Object new error: msg ] ]
		ifFalse: [ ^ answer ]
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
	^ self queryPrivateAccountInformation
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
	| price | 
	price := self querySymbolAveragePrice: aString.
	^ (price at: 'price') asNumber
]

{ #category : #initialization }
PharocksBinanceOperations >> symbolBestPrice: aString [
	"Average of price of a cryptocoin in the last 5 minutes"
	^ self querySymbolBestPrice: aString.
]

{ #category : #initialization }
PharocksBinanceOperations >> symbolLatestPrice: aString [
	"Average of price of a cryptocoin in the last 5 minutes"
	| price | 
	price := self querySymbolLatestPrice: aString.
	^ (price at: 'price') asNumber
]

{ #category : #initialization }
PharocksBinanceOperations >> universalTransfer: aString1 amount: aInteger fromAccountType: aString2 toAccountType: aString3 [

	^ self queryUniversalTransfer: aString1 amount: aInteger fromAccountType: aString2 toAccountType: aString3
]

{ #category : #initialization }
PharocksBinanceOperations >> universalTransferHistory [
	^ self queryUniversalTransferHistory
]
