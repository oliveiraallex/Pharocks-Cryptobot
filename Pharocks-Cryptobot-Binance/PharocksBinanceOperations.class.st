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
	^ 14 "hardcoded"
]

{ #category : #initialization }
PharocksBinanceOperations >> systemStatus [
	| status |
	status := self querySystemStatus.
	
	^ status
]

{ #category : #initialization }
PharocksBinanceOperations >> walletAmount [
	
	"runQuery to take the data from Binance"
	^ 106.2 "hardcoded"
]
