Class {
	#name : #PharocksCryptocurrencyExchange,
	#superclass : #Object,
	#instVars : [
		'exchangePlugin'
	],
	#category : #'Pharocks-Cryptobot-Core'
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
PharocksCryptocurrencyExchange >> orderCancel: aString orderId: aString2 [
	
	^ exchangePlugin orderCancel: aString orderId: aString2
	
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> orderCancelOCO: aString orderListId: aString2 [
	
	^ exchangePlugin orderCancelOCO: aString orderListId: aString2
	
]

{ #category : #controlling }
PharocksCryptocurrencyExchange >> privateAccountInformation [
	^ exchangePlugin privateAccountInformation
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> privateOrderCreate: aString1 side: aString2 quantity: aNumber1 atPrice: aNumber2 [
	^ exchangePlugin privateOrderCreate: aString1 side: aString2 quantity: aNumber1 atPrice: aNumber2
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> privateOrderCreateBuy: aString quantity: aNumber1 atPrice: aNumber2 [
	^ self privateOrderCreate: aString side: 'BUY' quantity: aNumber1 atPrice: aNumber2
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> privateOrderCreateSell: aString quantity: aNumber1 atPrice: aNumber2 [
	^ self privateOrderCreate: aString side: 'SELL' quantity: aNumber1 atPrice: aNumber2
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> privateOrderOCOCreate: aString1 side: aString2 quantity: aNumber1 atPrice: aNumber2 stopPrice: aNumber3 stopLimitPrice: aNumber4 [
	^ exchangePlugin privateOrderOCOCreate: aString1 side: aString2 quantity: aNumber1 atPrice: aNumber2 stopPrice: aNumber3 stopLimitPrice: aNumber4
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> privateOrderOCOCreateBuy: aString1 quantity: aNumber1 atPrice: aNumber2 stopPrice: aNumber3 stopLimitPrice: aNumber4 [
	^ self privateOrderOCOCreate: aString1 side: 'BUY' quantity: aNumber1 atPrice: aNumber2 stopPrice: aNumber3 stopLimitPrice: aNumber4
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> privateOrderOCOCreateSell: aString1 quantity: aNumber1 atPrice: aNumber2 stopPrice: aNumber3 stopLimitPrice: aNumber4 [
	^ self privateOrderOCOCreate: aString1 side: 'SELL' quantity: aNumber1 atPrice: aNumber2 stopPrice: aNumber3 stopLimitPrice: aNumber4
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> privateOrderOpenGet: aString1 [ 
	^ exchangePlugin privateOrderOpenGet: aString1 
]

{ #category : #controling }
PharocksCryptocurrencyExchange >> privateOrders: aString last: anInteger [ 
	^ exchangePlugin privateOrders: aString last: anInteger 
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> privateOrdersCancelAll [
	| result |
	result := OrderedCollection new.
	result add: self privateOrdersCancelLimitAll.
	result add: self privateOrdersCancelOCOAll.
	^ result
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> privateOrdersCancelLimitAll [
	| allOrders result |
	result := OrderedCollection new.
	allOrders := self privateOrderOpenGet: ''.
	allOrders
		do: [ :order | 
			(order at: 'orderListId') = -1
				ifTrue: [ result
						add:
							(self 
								orderCancel: (order at: 'symbol') 
								orderId: (order at: 'orderId')) ] ].
	^ result
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> privateOrdersCancelOCOAll [
	| allOrders result |
	result := OrderedCollection new.
	allOrders := self privateOrderOpenGet: ''.
	allOrders
		do: [ :order | 
			(order at: 'orderListId') ~= -1
				ifTrue: [ result
						add:
							(self
								orderCancelOCO: (order at: 'symbol')
								orderListId: (order at: 'orderListId')) ] ].
	^ result
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> privatePanicButton [
	| return |
	return := OrderedCollection new.
	return add: self privateOrdersCancelAll.
	return add: self privateSellEverything.
	^ return
]

{ #category : #operation }
PharocksCryptocurrencyExchange >> privateSellEverything [
	| symbolsAmountFree return |
	return := OrderedCollection new.
	symbolsAmountFree := self symbolsAmountFree.
	symbolsAmountFree keys
		do: [ :a |
			a = 'USDT'
				ifFalse: [ return add:( self
						privateOrderCreateSell: a, 'USDT'
						quantity: ((symbolsAmountFree at: a) asNumber roundDownTo: 0.01) 
						atPrice: ((self symbolPriceSell: a , 'USDT' lastOrders: 5) round: 4) )] ].
	^ return
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

{ #category : #accessing }
PharocksCryptocurrencyExchange >> symbolGetPriceUSD: aString [
	aString = 'JEX' | (aString = 'BCHSV')
		ifTrue: [ ^ 0 ]
		ifFalse: [ aString = 'USDT'
				ifTrue: [ ^ 1 ]
				ifFalse: [ ^ self symbolLatestPrice: aString , 'USDT'	"usdt market hardcoded" ] ]
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
		do: [ :i | 
			(((i at: 'asset') = 'JEX') | ((i at: 'asset') = 'BCHSV'))
				ifFalse: [ symbolsAmount at: (i at: 'asset') put: (i at: aString) ] ].
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
	accountSymbols do: [ :i | 
		(((i at: 'asset') = 'JEX') | ((i at: 'asset') = 'BCHSV'))
		ifFalse: [symbolsAmount at:  (i at: 'asset' ) put: ((i at: 'free' )asNumber + (i at: 'locked' )asNumber round:8) ]].
	^ symbolsAmount.
]

{ #category : #accessing }
PharocksCryptocurrencyExchange >> symbolsAmountTotalInUSD [
	| symbols total |
	total := 0.
	symbols := self symbolsAmountTotal.
	symbols keys
		do: [ :i | 
			symbols
				at: i
				put: ((symbols at: i) * (self symbolGetPriceUSD: i) round: 8) ].
	symbols do: [ :value | total := total + value ].
	^ total round:2
]

{ #category : #accessing }
PharocksCryptocurrencyExchange >> symbolsAmountTotalInUSDFree [
	^ (self symbolsAmountFree at: 'USDT') asNumber round: 2
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
