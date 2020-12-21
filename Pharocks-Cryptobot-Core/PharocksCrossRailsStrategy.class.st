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
		'stopLossRatio',
		'stopGain1Ratio',
		'stopGain2Ratio',
		'stopGain3Ratio',
		'stopGain4Ratio',
		'stopLossMinRatio',
		'leverage',
		'limitRatio',
		'railsRatio',
		'quantityTotal',
		'numberOfOrders',
		'processMonitor',
		'buyOrdersOpen',
		'sellOrdersOpen',
		'quantityGlobal',
		'amountTrading',
		'quantityWeightShort',
		'quantityWeightLong',
		'quantityWeightShortNextJump',
		'quantityWeightLongNextJump',
		'coinRules',
		'latestPrice',
		'balance',
		'position',
		'quantity',
		'entryPrice',
		'quantityToStopLoss'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> cancellAllOrders [

	exchange futuresOrderCancelAll: 'BTCUSDT'
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> checkBalanceToTransfer [

	balance > (amountTrading * 10.1)
		ifTrue: [ 
			exchange	futuresAccountTransferFromFuturesToSpot: 'USDT' amount: (balance - (amountTrading * 10) round: 2)
		]
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

	| ordersRatio ordersOpen |
	self getPositions.
	self getOrders.
	
	ordersRatio := self checkOrdersRatio.
	ordersOpen := self  checkOrdersOpen.
	
	"1st = There is more orders Short or Long with or without opened position
	2nd = There is no orders opened"
	^ (ordersRatio = 1 or: ordersRatio= -1) or: (ordersOpen = 0).
	
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
	[orders do: [ :i | side := i at: 'side'. (side = 'BUY') ifTrue: [  buyOrdersOpen add: i ] ]] on: Error do: [:ignore | ^ nil ].
	[orders do: [ :i | side := i at: 'side'. (side = 'SELL') ifTrue: [  sellOrdersOpen add: i ] ]] on: Error do: [:ignore | ^ nil ]

]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> getPositions [

	position := [(exchange futuresPositions) at:coinIndex] on: Error do: [:ignore | ^ nil ].
	quantity := ((position at: 'positionAmt') asNumber).
	entryPrice := (position at: 'entryPrice') asNumber
	
]

{ #category : #initialization }
PharocksCrossRailsStrategy >> initialize [
	super initialize. 
	market := 'BTCUSDT'.
	coinIndex := 54.

	leverage := 25.
	railsRatio := 0.002.
	
	quantityGlobal := 0.002.
	
	amountTrading := 10.
	
	quantityToStopLoss := 0.006.
	
	coinRules := PharocksCoins rules: 'BTCUSDT'.
	

]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openLong: anInteger [
	self openLong: anInteger weight: 1 entryPriceOrCurrentPrice: 'current' jumps: 1
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openLong: anInteger weight: anInteger2 entryPriceOrCurrentPrice: aString jumps: anInteger3 [
	| orderPrice stopLossActivated |
		
	numberOfOrders := anInteger.
	quantityTotal := ((((balance / latestPrice) * leverage)/2) roundDownTo: 0.001) round:3.
	((aString = 'entry') and: [(entryPrice > 0)]) ifTrue: [ latestPrice := entryPrice ] .
	anInteger3 > 1 ifTrue: [ latestPrice := (((latestPrice - (latestPrice * railsRatio * anInteger3)) ) roundDownTo: 0.01) round:2 ].
	orderPrice := (((latestPrice - (latestPrice * railsRatio)) ) roundDownTo: 0.01) round:2.
	stopLossActivated := quantity > quantityToStopLoss.
	
	stopLossActivated ifTrue: [
	
	exchange futuresPrivateOrderCreateSell: market 
		type: 'STOP_MARKET' 
		quantity: (((quantityGlobal * anInteger2 / 2 )roundDownTo: 0.001) round:3) 
		atPrice: nil 
		stopPrice: orderPrice. 
	
	] ifFalse: [ 
	
	1 to: numberOfOrders do: [  :i |		
		exchange futuresPrivateOrderCreateBuy: market 
			type: 'LIMIT' 
			quantity: (((quantityGlobal * anInteger2)roundDownTo: 0.001) round:3) 
			atPrice: (orderPrice * i) 
			stopPrice: nil ].
	
	]

]

{ #category : #accessing }
PharocksCrossRailsStrategy >> openOrdersAsLongPosition [

	| weightLongPosition |
	weightLongPosition := ((( quantity / quantityGlobal )roundDownTo: 1) round:3 ).
	self openShort: 1 weight: weightLongPosition entryPriceOrCurrentPrice: 'entry' jumps: 1. 
	self openLong: 1 weight: (2 * weightLongPosition) entryPriceOrCurrentPrice: 'entry' jumps: 2.
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
	self openLong: 1 weight: weightShortPosition entryPriceOrCurrentPrice: 'entry' jumps: 1.
	self openShort: 1 weight: (2 * weightShortPosition) entryPriceOrCurrentPrice: 'entry' jumps: 2.
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openShort: anInteger [
	self openShort: anInteger weight: 1 entryPriceOrCurrentPrice: 'current' jumps: 1
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openShort: anInteger weight: anInteger2 entryPriceOrCurrentPrice: aString jumps: anInteger3 [
	| orderPrice stopLossActivated |
		
	numberOfOrders := anInteger.
	quantityTotal := ((((balance / latestPrice) * leverage)/2) roundDownTo: 0.001) round:3.
	((aString = 'entry') and: [(entryPrice > 0)]) ifTrue: [ latestPrice := entryPrice ] .
	anInteger3 > 1 ifTrue: [ latestPrice := (((latestPrice + (latestPrice * railsRatio * anInteger3)) ) roundDownTo: 0.01) round:2 ].
	orderPrice := (((latestPrice + (latestPrice * railsRatio )) ) roundDownTo: 0.01) round:2.
	stopLossActivated := quantity < (quantityToStopLoss * -1).
	
	stopLossActivated ifTrue: [

	exchange futuresPrivateOrderCreateBuy: market 
		type: 'STOP_MARKET' 
		quantity: (((quantityGlobal * anInteger2 / 2)roundDownTo: 0.001) round:3) 
		atPrice: nil 
		stopPrice: orderPrice.

	] ifFalse: [ 
		
		1 to: numberOfOrders do: [  :i | 
		exchange futuresPrivateOrderCreateSell: market 
			type: 'LIMIT' 
			quantity: (((quantityGlobal * anInteger2)roundDownTo: 0.001) round:3) 
			atPrice:( orderPrice * i) 
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
		self checkBalanceToTransfer.
		
		isLongPosition := quantity > 0.
		isShortPosition := quantity < 0.
		isNoPosition := quantity = 0.
			
		isLongPosition ifTrue: [ self openOrdersAsLongPosition ].
		isShortPosition ifTrue: [ self openOrdersAsShortPosition ] .
		isNoPosition ifTrue: [ self openOrdersAsNoPosition ].
		
	].
	
	1 second wait ] on: Error do: [:ignore | ^ nil ] ; repeat 
]

{ #category : #accessing }
PharocksCrossRailsStrategy >> startMonitor [
	
	processMonitor := [ self singleTrack  ] forkNamed: 'Pharocks processMonitor'  
]

{ #category : #accessing }
PharocksCrossRailsStrategy >> stopMonitor [

	processMonitor terminate
]
