"
binance := PharocksBinance new apiKey: 'abc123'; apiSecretKey: 'abc123'.
exchange := PharocksCryptocurrencyExchange exchangePlugin: binance.
exchange cryptoPairPrice: 'BNBUSDT'.
exchange walletAmount. 
exchange systemStatus.
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
	broker setStrategy

]

{ #category : #accessing }
PharocksOperator >> start [ 

	"exchange ifNil: [ (Object new) error: 'Set the Exchange before start the aplication' ]"
	

]

{ #category : #accessing }
PharocksOperator >> walletSync [
	broker walletSync
]
