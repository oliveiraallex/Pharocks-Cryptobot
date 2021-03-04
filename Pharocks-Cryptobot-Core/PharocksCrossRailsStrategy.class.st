"
Open Short and Long positions automaticaly in Futures Market with controled Stop Loss and retarget Stop Loss/Gain orders.

Some parameters can be set in #initialize

binance := PharocksBinance new apiKey: 'text'; apiSecretKey: 'text'.
exchange := PharocksCryptocurrencyExchange exchangePlugin: binance.

crossRails := PharocksCrossRailsStrategy new.
crossRails setExchange: exchange.

crossRails startMonitorSingleTrack. 
crossRails stopMonitor.

crossRails cancellAll.
"
Class {
	#name : #PharocksCrossRailsStrategy,
	#superclass : #PharocksBroker,
	#instVars : [
		'market',
		'coinIndex',
		'leverage',
		'railsRatio',
		'quantityTotal',
		'numberOfOrders',
		'processMonitor',
		'buyOrdersOpen',
		'sellOrdersOpen',
		'quantityGlobal',
		'amountTrading',
		'coinRules',
		'latestPrice',
		'balance',
		'position',
		'quantity',
		'entryPrice',
		'quantityToStopLoss',
		'log',
		'waitTime',
		'priceRatio',
		'quantityRatio',
		'processCleaner'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #accessing }
PharocksCrossRailsStrategy >> calculateOrderPriceWithJump: jumpsInteger shortOrLong: aString [
	(aString = 'short') ifTrue: [ ^ (latestPrice + (latestPrice * priceRatio * jumpsInteger)	roundDownTo: 0.01) round: 2 ].
	(aString = 'long') ifTrue: [ ^ (latestPrice - (latestPrice * priceRatio * jumpsInteger)	roundDownTo: 0.01) round: 2 ]
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> cancellAllOrders [

	exchange futuresOrderCancelAll: market
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> checkBalanceToTransfer [

	balance > (amountTrading * 1.05)
		ifTrue: [ 
			exchange	futuresAccountTransferFromFuturesToSpot: 'USDT' amount: (balance - (amountTrading ) round: 2)
		]
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> checkIfPositionIsLessThanMinimum [

	quantity > 0 ifTrue: [ quantity < quantityGlobal ifTrue: [ 
			exchange futuresPrivateOrderCreateSell: market type: 'MARKET' quantity: ((((quantityGlobal * 2 ) - quantity) roundDownTo: 0.001) round:3) atPrice: nil stopPrice: nil. ] ].
	quantity < 0 ifTrue: [ quantity > (quantityGlobal * -1) ifTrue: [ 
			exchange futuresPrivateOrderCreateBuy: market type: 'MARKET' quantity: ((((quantityGlobal * 2 ) - quantity) roundDownTo: 0.001) round:3)  atPrice: nil stopPrice: nil.  ] ]
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> checkOrdersOpen [
	"Return 0 if there is no order opened or 1 if there is some order opened"
	(buyOrdersOpen size = 0 and: [ sellOrdersOpen size = 0 ]) ifTrue: [ ^ 0]. 
	(buyOrdersOpen size ~= 0 or: [ sellOrdersOpen size ~= 0 ]) ifTrue: [ ^ 1]

]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> checkOrdersRatio [
	"Return the difference between the quantity of Long and Short orders opended.
	0 = There is no order or there is the same number of Long and Short orders
	1 = There is one more Longs than Short
	2 = There is two more Longs than Short.
	-1 = There is one more Shorts than Long" 
	^ (buyOrdersOpen size) - (sellOrdersOpen size)
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> checkOrdersToRun [

	| ordersRatio ordersOpen result|
	self getPositions.
	self getOrders.

	ordersRatio := self checkOrdersRatio.
	ordersOpen := self  checkOrdersOpen.

	"1st = There is more orders Short or Long with or without opened position
	2nd = There is no orders opened"
	result := (ordersRatio = 1 or: ordersRatio= -1) or: (ordersOpen = 0).
	log = true ifTrue: [Transcript show: 'Run: ', result asString ; cr;cr].
	^ result
	
]

{ #category : #initialization }
PharocksCrossRailsStrategy >> cleanCache [ 
	exchange exchangePlugin cleanChache
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> closeAllPositions [
	
	"draft"
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> closePosition: aString1 side: aString2 [
	"Not working, need some work"

	exchange futuresPrivateOrderCreate: aString1 side: aString2 type: 'MARKET' closePosition: true
	
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> getBalances [

	latestPrice := exchange futuresSymbolLatestPrice: market.
	balance := exchange futuresBalance
	
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> getOrders [

	| orders side |
	buyOrdersOpen := OrderedCollection  new.
	sellOrdersOpen := OrderedCollection  new.
	orders := exchange futuresPrivateOrderOpen: market.
	log = true ifTrue: [Transcript show: 'Orders: ', orders asString ; cr].
	[orders do: [ :i | side := i at: 'side'. (side = 'BUY') ifTrue: [  buyOrdersOpen add: i ] ]] on: Error do: [:ignore | ^ nil ].
	[orders do: [ :i | side := i at: 'side'. (side = 'SELL') ifTrue: [  sellOrdersOpen add: i ] ]] on: Error do: [:ignore | ^ nil ].
	log = true ifTrue: [Transcript show: 'buyOrdersOpen: ', buyOrdersOpen asString ; cr].
	log = true ifTrue: [Transcript show: 'sellOrdersOpen ', sellOrdersOpen asString ; cr].
	
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> getPositions [
	|coinList|
	coinList := (exchange futuresPositions).
	position := [ coinList detect: [ :a | (a at: 'symbol') = market ] ] on: Error do: [:ignore | ^ nil ].
	quantity := ((position at: 'positionAmt') asNumber).
	entryPrice := (position at: 'entryPrice') asNumber.
	log = true ifTrue: [Transcript show: 'Position: ', position asString ; cr].
	^ coinList.
]

{ #category : #initialization }
PharocksCrossRailsStrategy >> initialize [
	super initialize. 
	log := false.
	market := 'BCHUSDT'.
	leverage := 75.
	priceRatio := 0.004.
	quantityRatio := 1.8.
	quantityGlobal := 0.05.
	amountTrading := 56.
	quantityToStopLoss := 4.
	waitTime := 1.
	coinRules := PharocksCoins rules: market
]

{ #category : #'logging-Deprecated' }
PharocksCrossRailsStrategy >> log: boolean [
	log := boolean
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openLong: anInteger [
	self openLong: anInteger weight: 1 entryPriceOrCurrentPrice: 'current' jumps: 1
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openLong: numberOfOrdersInteger weight: weightInteger entryPriceOrCurrentPrice: aString jumps: jumpsInteger [
	
	self openLong: numberOfOrdersInteger weight: weightInteger entryPriceOrCurrentPrice: aString jumps: jumpsInteger addQuantity: 0
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openLong: numberOfOrdersInteger weight: weightInteger entryPriceOrCurrentPrice: aString jumps: jumpsInteger addQuantity: quantityNumber [
	| orderPrice stopLossActivated isEntryPrice quantityOrder |

	isEntryPrice := (aString = 'entry') and: [entryPrice > 0].
	isEntryPrice ifTrue: [ latestPrice := entryPrice ].
	stopLossActivated := quantity > quantityToStopLoss.

	orderPrice := self calculateOrderPriceWithJump: jumpsInteger shortOrLong: 'long'.
	
	quantity > 0 ifTrue: [quantityOrder := quantity ].
	quantity < 0 ifTrue: [quantityOrder := quantity * -1 ].
	
	stopLossActivated ifTrue: [
	exchange futuresPrivateOrderCreateSell: market 
		type: 'STOP_MARKET' 
		quantity: (((quantityOrder )roundDownTo: 0.001) round:3) 
		atPrice: nil 
		stopPrice: orderPrice. 
	] ifFalse: [ 
	1 to: numberOfOrdersInteger do: [  :i | 
		exchange futuresPrivateOrderCreateBuy: market 
			type: 'LIMIT' 
			quantity: ((((quantityOrder * weightInteger) + quantityNumber )roundDownTo: 0.001) round:3) 
			atPrice: (orderPrice * i) 
			stopPrice: nil ].
	]
]

{ #category : #accessing }
PharocksCrossRailsStrategy >> openOrdersAsLongPosition [

	| weightLongPosition |
	weightLongPosition := ((( quantity / quantityGlobal )roundDownTo: 1) round:3 ).
	self openShort: 1 weight: "weightLongPosition" 1 entryPriceOrCurrentPrice: 'entry' jumps: 1 addQuantity: quantityGlobal "0".
	self openLong: 1 weight: "2* weightLongPosition" 2  entryPriceOrCurrentPrice: 'entry' jumps: 3.
]

{ #category : #accessing }
PharocksCrossRailsStrategy >> openOrdersAsNoPosition [

	PharocksLog logAdd: 'USD: ',  balance asString.
	self openLong: 1 weight: 1 entryPriceOrCurrentPrice: 'current' jumps: 1.
	self openShort: 1 weight: 1 entryPriceOrCurrentPrice: 'current' jumps: 1.
]

{ #category : #accessing }
PharocksCrossRailsStrategy >> openOrdersAsShortPosition [

	| weightShortPosition |
	weightShortPosition := ((( quantity / quantityGlobal * -1)roundDownTo: 1) round:3 ). 
	self openLong: 1 weight: "weightShortPosition" 1 entryPriceOrCurrentPrice: 'entry' jumps: 1  addQuantity: quantityGlobal "0".
	self openShort: 1 weight: "2 * weightShortPosition" 2 entryPriceOrCurrentPrice: 'entry' jumps: 3.
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openShort: anInteger [
	self openShort: anInteger weight: 1 entryPriceOrCurrentPrice: 'current' jumps: 1
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openShort: numberOfOrdersInteger weight: weightInteger entryPriceOrCurrentPrice: aString jumps: jumpsInteger [
	
	self openShort: numberOfOrdersInteger weight: weightInteger entryPriceOrCurrentPrice: aString jumps: jumpsInteger  addQuantity: 0	
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openShort: numberOfOrdersInteger weight: weightInteger entryPriceOrCurrentPrice: aString jumps: jumpsInteger  addQuantity: quantityNumber [
	| orderPrice stopLossActivated isEntryPrice quantityOrder |
	
	isEntryPrice := (aString = 'entry') and: [entryPrice > 0].
	isEntryPrice ifTrue: [ latestPrice := entryPrice ] .
	stopLossActivated := quantity < (quantityToStopLoss * -1).
	
	orderPrice := self calculateOrderPriceWithJump: jumpsInteger shortOrLong: 'short'.
	
	quantity > 0 ifTrue: [quantityOrder := quantity ].
	quantity < 0 ifTrue: [quantityOrder := quantity * -1 ].

	stopLossActivated ifTrue: [
	exchange futuresPrivateOrderCreateBuy: market 
		type: 'STOP_MARKET' 
		quantity: (((quantityOrder )roundDownTo: 0.001) round:3) 
		atPrice: nil 
		stopPrice: orderPrice.
	] ifFalse: [ 
		1 to: numberOfOrdersInteger do: [  :i | 
		exchange futuresPrivateOrderCreateSell: market 
			type: 'LIMIT' 
			quantity: ((((quantityOrder * weightInteger) + quantityNumber )roundDownTo: 0.001) round:3)
			atPrice:( orderPrice ) 
			stopPrice: nil ].
	]	
]

{ #category : #accessing }
PharocksCrossRailsStrategy >> singleTrack [
	| isShortPosition isLongPosition isNoPosition |
	
	^ [ self checkOrdersToRun ifTrue:  [ 	
		
		self cancellAllOrders.
		self getPositions.
		self getBalances.
		self checkIfPositionIsLessThanMinimum.
		self checkBalanceToTransfer.
		
		isLongPosition := quantity > 0.
		isShortPosition := quantity < 0.
		isNoPosition := quantity = 0.

		isLongPosition ifTrue: [ self openOrdersAsLongPosition ].
		isShortPosition ifTrue: [ self openOrdersAsShortPosition ] .
		isNoPosition ifTrue: [ self openOrdersAsNoPosition ].
		
	].
	
	waitTime second wait ] on: Error do: [:ignore | ^ nil ] ; repeat 
]

{ #category : #accessing }
PharocksCrossRailsStrategy >> startMonitor [
	
	processMonitor := [ self singleTrack  ] forkNamed: 'Pharocks processMonitor' .
	processCleaner := [ PharocksCrossRailsStrategy allInstances do: [ :instance | instance cleanCache]. 20 minutes wait  ] forkNamed: 'CacheCleaner processMonitor'
]

{ #category : #accessing }
PharocksCrossRailsStrategy >> stopMonitor [

	processMonitor terminate.
	processCleaner terminate
]
