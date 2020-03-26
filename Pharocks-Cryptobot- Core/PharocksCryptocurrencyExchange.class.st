Class {
	#name : #PharocksCryptocurrencyExchange,
	#superclass : #Object,
	#instVars : [
		'exchangePlugin'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #accessing }
PharocksCryptocurrencyExchange class >> exchangePlugin: anObject [
	| exchange | 
	exchange := self new.
	exchange	exchangePlugin: anObject.
	^ exchange
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> cancelAllOrders [ 
	^ exchangePlugin cancelAllOrders
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> createBuyOrderCryptoPair: aString atPrice: aNumber [
	^ exchangePlugin createBuyOrderCryptoPair: aString atPrice: aNumber
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> createSellOrderCryptoPair: aString atPrice: aNumber [
	^ exchangePlugin createSellOrderCryptoPair: aString atPrice: aNumber
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> cryptoPairPrice: aString [ 
	^ exchangePlugin cryptoPairPrice: aString.
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> exchangeInfo [ 
	^ exchangePlugin exchangeInfo
]

{ #category : #accessing }
PharocksCryptocurrencyExchange >> exchangePlugin [
	^ exchangePlugin
]

{ #category : #accessing }
PharocksCryptocurrencyExchange >> exchangePlugin: anObject [
	exchangePlugin := anObject
]

{ #category : #initialization }
PharocksCryptocurrencyExchange >> initialize [ 
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> orderBookcryptoPair: aString limit: aNumber [
	"Limit default 100; max 5000. Valid limits:[5, 10, 20, 50, 100, 500, 1000, 5000]"
	^ exchangePlugin orderBookcryptoPair: aString limit: aNumber 
	
	
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> pingServer [ 
	^ exchangePlugin pingServer
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> sellAllAssets [ 
	^ exchangePlugin sellAllAssets
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> serverTime [ 
	^ exchangePlugin serverTime
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> systemStatus [ 
	^ exchangePlugin systemStatus
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> walletAmount [
	^ exchangePlugin walletAmount
]
