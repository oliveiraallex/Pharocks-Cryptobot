"
binance := PharocksBinance new apiKey: 'abc123'; apiSecretKey: 'abc123'.
exchange := PharocksCryptocurrencyExchange exchangePlugin: binance.
exchange exchangeInfo. ""anObject""
exchange exchangePing. ""true""
exchange exchangeStatus. ""true""
exchange exchangeTime. ""1585330938078""
exchange orderBook: 'BNBUSDT' lastOrders: 5. ""anObject""
exchange symbolAvaregePrice: 'BNBUSDT'. ""12.90751442""
exchange symbolPrice: 'BNBUSDT' lastOrders: 5 type: 'bids'. ""12.89462""
exchange symbolPriceBuy: 'BNBUSDT' lastOrders: 5. ""12.89074""
exchange symbolPriceSell: 'BNBUSDT' lastOrders: 5. ""12.89724""
exchange privateOrders: 'BNBUSDT' last: 5 ""anObject""
exchange privateAccountInformation. 
exchange symbolsInAccount.
exchange symbolsAmountFree.
exchange symbolsAmountLocked.
exchange symbolsAmountTotal.
exchange privateOrderCreateBuy: 'BNBUSDT' quantity: 1 atPrice: (exchange symbolBestPriceBuy: 'BNBUSDT').
exchange privateOrderCreateSell: 'BNBUSDT' quantity: 1 atPrice: (exchange symbolBestPriceSell: 'BNBUSDT').

cryptoRobot := PharocksOperator setExchange: exchange.
cryptoRobot setStrategy: PharocksStrategy simpleWinLossPercentage.
cryptoRobot walletSync.
cryptoRobot createAssets. 


assets := PharocksAssets new.
wallet := PharocksWallet new.
strategy := PharocksStrategy simpleWinLossPercentage.
broker := PharocksBroker new.
broker strategy: PharocksStrategy simpleWinLossPercentage.


"
Class {
	#name : #PharocksOperator,
	#superclass : #Object,
	#instVars : [
		'broker'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #accessing }
PharocksOperator class >> setExchange: anObject [
	| broker |
	broker := PharocksBroker new.
	broker setExchange: anObject.
	^ self new broker: broker
]

{ #category : #accessing }
PharocksOperator >> broker [
	^ broker
]

{ #category : #accessing }
PharocksOperator >> broker: anObject [
	broker := anObject
]

{ #category : #accessing }
PharocksOperator >> createAssets [
	broker createAssets
]

{ #category : #accessing }
PharocksOperator >> initialize [
	
	
]

{ #category : #accessing }
PharocksOperator >> setStrategy:  anObject [  
	broker strategy: anObject.
	"broker setStrategy"

]

{ #category : #accessing }
PharocksOperator >> start [ 

	"exchange ifNil: [ (Object new) error: 'Set the Exchange before start the aplication' ]"
	

]

{ #category : #accessing }
PharocksOperator >> startMonitor [
	broker startMonitor
]

{ #category : #accessing }
PharocksOperator >> walletSync [
	broker walletSync
]
