Class {
	#name : #PharocksBinanceOperations,
	#superclass : #PharocksBinanceQueries,
	#category : #'Pharocks-Cryptobot-Binance'
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
PharocksBinanceOperations >> orderBook: aString lastOrders: aNumber [
	| answer result msg |
	answer := self queryOrderBook: aString lastOrders: aNumber.
	(answer includesKey: 'code') ifTrue: [ ((answer at: 'code') = -1100)
		ifTrue: [ msg := answer at: 'msg'.
			Object new error: msg ] ]
		ifFalse: [ ^ answer ]
]

{ #category : #initialization }
PharocksBinanceOperations >> orderCreateBuy: aString atPrice: aNumber [
	^ true "hardcoded"
]

{ #category : #initialization }
PharocksBinanceOperations >> orderCreateSell: aString atPrice: aNumber [
	^ true "hardcoded"
]

{ #category : #initialization }
PharocksBinanceOperations >> ordersCancelAll [
	^ true "hardcoded"
]

{ #category : #initialization }
PharocksBinanceOperations >> symbolAvaregePrice: aString [
	"Average of price of a cryptocoin in the last 5 minutes"
	| price | 
	price := self querySymbolAveragePrice: aString.
	^ (price at: 'price') asNumber
]
