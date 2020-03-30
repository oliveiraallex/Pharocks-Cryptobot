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
PharocksCryptocurrencyExchange >> exchangeInfo [ 
	^ exchangePlugin exchangeInfo
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> exchangePing [ 
	^ exchangePlugin exchangePing
]

{ #category : #accessing }
PharocksCryptocurrencyExchange >> exchangePlugin [
	^ exchangePlugin
]

{ #category : #accessing }
PharocksCryptocurrencyExchange >> exchangePlugin: anObject [
	exchangePlugin := anObject
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> exchangeStatus [ 
	^ exchangePlugin exchangeStatus
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> exchangeTime [ 
	^ exchangePlugin exchangeTime
]

{ #category : #initialization }
PharocksCryptocurrencyExchange >> initialize [ 
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> orderBook: aString lastOrders: aNumber [
	"LastOrders limit default 100; max 5000. Valid limits:[5, 10, 20, 50, 100, 500, 1000, 5000]"
	^ exchangePlugin orderBook: aString lastOrders: aNumber 
	
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> orderCreateBuy: aString atPrice: aNumber [
	^ exchangePlugin orderCreateBuy: aString atPrice: aNumber
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> orderCreateSell: aString atPrice: aNumber [
	^ exchangePlugin orderCreateSell: aString atPrice: aNumber
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> ordersCancelAll [ 
	^ exchangePlugin ordersCancelAll
]

{ #category : #controlling }
PharocksCryptocurrencyExchange >> privateAccountInformation [
	^ exchangePlugin privateAccountInformation
]

{ #category : #controling }
PharocksCryptocurrencyExchange >> privateOrders: aString last: anInteger [ 
	^ exchangePlugin privateOrders: aString last: anInteger 
]

{ #category : #controlling }
PharocksCryptocurrencyExchange >> queryPrivateAccountInformation [
	^ exchangePlugin queryPrivateAccountInformation
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> symbolAvaregePrice: aString [ 
	"Average of price of a cryptocoin in the last 5 minutes"
	^ exchangePlugin symbolAvaregePrice: aString.
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> symbolBestPrice: aString [ 
	"Best price/qty on the order book for a symbol or symbols."
	^ exchangePlugin symbolBestPrice: aString.
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> symbolBestPriceBuy: aString [ 
	"Best price/qty on the order book for a symbol or symbols."
	| price | 
	price := exchangePlugin symbolBestPrice: aString.
	^ (price at: 'bidPrice') asNumber
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> symbolBestPriceSell: aString [ 
	"Best price/qty on the order book for a symbol or symbols."
	| price | 
	price := exchangePlugin symbolBestPrice: aString.
	^ (price at: 'askPrice') asNumber
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> symbolLatestPrice: aString [ 
	"Latest price for a symbol or symbols"
	^ exchangePlugin symbolLatestPrice: aString.
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> symbolPrice: aString lastOrders: aNumber type: aStringBidsOrAsks [
	| answer lastPrices|
	lastPrices := 0.
	answer := exchangePlugin orderBook: aString lastOrders: aNumber.
	((answer at: aStringBidsOrAsks) do: [ :i | lastPrices := lastPrices + (i at: 1) asNumber]). .
	^ lastPrices / aNumber
	
	
	
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> symbolPriceBuy: aString lastOrders: aNumber [
	"lastOrders limit default 100; max 5000. Valid limits:[5, 10, 20, 50, 100, 500, 1000, 5000]"
	^ self symbolPrice: aString lastOrders: aNumber type: 'bids'
	
	
	
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> symbolPriceSell: aString lastOrders: aNumber [
	"lastOrders limit default 100; max 5000. Valid limits:[5, 10, 20, 50, 100, 500, 1000, 5000]"
	^ self symbolPrice: aString lastOrders: aNumber type: 'asks'
	
	
	
]

{ #category : #accessing }
PharocksCryptocurrencyExchange >> symbolsAmount: aString [
	| symbolsAmount accountSymbols |
	accountSymbols := self symbolsInAccount.
	symbolsAmount := Dictionary new.
	accountSymbols
		do: [ :i | symbolsAmount at: (i at: 'asset') put: (i at: aString) ].
	^ symbolsAmount
]

{ #category : #accessing }
PharocksCryptocurrencyExchange >> symbolsAmountFree [
	^ self symbolsAmount: 'free'
]

{ #category : #accessing }
PharocksCryptocurrencyExchange >> symbolsAmountLocked [
	^ self symbolsAmount: 'locked'
]

{ #category : #accessing }
PharocksCryptocurrencyExchange >> symbolsAmountTotal [
	| symbolsAmount accountSymbols |
	accountSymbols := self symbolsInAccount.
	symbolsAmount := Dictionary new. 
	accountSymbols do: [ :i | symbolsAmount at:  (i at: 'asset' ) put: ((i at: 'free' )asNumber + (i at: 'locked' )asNumber) ].
	^ symbolsAmount.
]

{ #category : #accessing }
PharocksCryptocurrencyExchange >> symbolsInAccount [
	| accountInformation accountSymbols j |
	accountInformation := self privateAccountInformation.
	accountSymbols := OrderedCollection new.
	j := 1.
	(accountInformation at: 'balances')
		do: [ :i | 
			(i at: 'free') asNumber > 0
				ifTrue: [ accountSymbols add: (accountInformation at: 'balances' at: j) ].
			j := j + 1 ].
	^ accountSymbols
]
