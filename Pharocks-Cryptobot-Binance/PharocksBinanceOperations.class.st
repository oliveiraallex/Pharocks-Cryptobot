Class {
	#name : #PharocksBinanceOperations,
	#superclass : #PharocksBinanceQueries,
	#category : #'Pharocks-Cryptobot-Binance'
}

{ #category : #initialization }
PharocksBinanceOperations >> cancelAllOrders [
	
	"runQuery to take the data from Binance"
	^ true "hardcoded"
]

{ #category : #initialization }
PharocksBinanceOperations >> createBuyOrderCryptoPair: aString atPrice: aNumber [
	^ true
]

{ #category : #initialization }
PharocksBinanceOperations >> createSellOrderCryptoPair: aString atPrice: aNumber [
	^ true
]

{ #category : #initialization }
PharocksBinanceOperations >> cryptoPairPrice: aString [
	
	"runQuery to take the data from Binance"
	^ 9684.29 "hardcoded"
]

{ #category : #initialization }
PharocksBinanceOperations >> exchangeInfo [
	^ self queryExchangeInfo
]

{ #category : #initialization }
PharocksBinanceOperations >> orderBookcryptoPair: aString limit: aNumber [
	^ self queryOrderBookcryptoPair: aString limit: aNumber
]

{ #category : #initialization }
PharocksBinanceOperations >> pingServer [
	| answerSystemStatus status |
	answerSystemStatus := self queryPingServer.
	status := answerSystemStatus isEmpty
		ifTrue: [ true ]
		ifFalse: [ false ].
	^ status
]

{ #category : #initialization }
PharocksBinanceOperations >> serverTime [
	| answerSystemStatus status |
	answerSystemStatus := self queryServerTime.
	status := answerSystemStatus isEmpty 
		ifTrue: [ false ]
		ifFalse: [ answerSystemStatus at: 'serverTime' ].
	^ status
]

{ #category : #initialization }
PharocksBinanceOperations >> systemStatus [
	| answerSystemStatus status |
	answerSystemStatus := self querySystemStatus.
	status := (answerSystemStatus at: 'status') = 0
		ifTrue: [ true ]
		ifFalse: [ false ].
	^ status
]

{ #category : #initialization }
PharocksBinanceOperations >> walletAmount [
	
	"runQuery to take the data from Binance"
	^ 1000 "hardcoded"
]
