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
		'entryPrice'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> cancellAll [
	| balance |	
		
	exchange futuresOrderCancelAll: 'BTCUSDT'.
	"balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString."
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> checkBalanceToTransfer [

	balance > (amountTrading * 10.1)
		ifTrue: [ 
			PharocksLog logAdd: 'USD: ' , balance asString.
			exchange	futuresAccountTransferFromFuturesToSpot: 'USDT' amount: (balance - (amountTrading * 10) round: 2)
		]
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> checkOrdersOpen [

	(buyOrdersOpen size = 0 and: [ sellOrdersOpen size = 0 ]) ifTrue: [ ^ 0]. 
	(buyOrdersOpen size ~= 0 or: [ sellOrdersOpen size ~= 0 ]) ifTrue: [ ^ 1]

]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> checkOrdersRatio [

	^ (buyOrdersOpen size) - (sellOrdersOpen size) 

]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> checkOrdersToRun [

	position := exchange futuresPositions at: coinIndex.
	[quantity := (position at: 'positionAmt') asNumber] on: Error do: [:ignore | ^ nil ].
	self getOrders.
	^ ((self checkOrdersRatio ~= 0 and: [ quantity ~= 0 ]) or: [ self checkOrdersOpen = 0 and: [ quantity = 0 ] ]) or: [ self checkOrdersRatio ~= 0 and: [ quantity = 0 ]]
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

	latestPrice := exchange futuresSymbolLatestPrice: market.
	balance := exchange futuresBalance.
	position := (exchange futuresPositions) at:coinIndex.
	quantity := ((position at: 'positionAmt') asNumber).
	entryPrice := (position at: 'entryPrice') asNumber.
	PharocksLog logAdd: 'USD: ',  balance asString.
	
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
	quantityWeightShort := -0.004.
	quantityWeightLong := 0.004.
	quantityWeightShortNextJump := -0.005.
	quantityWeightLongNextJump := 0.005.
	
	coinRules := PharocksCoins rules: 'BTCUSDT'.
	

]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openLong: anInteger [
	self openLong: anInteger weight: 1 entryPriceOrCurrentPrice: 'current' jumps: 1
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openLong: anInteger weight: anInteger2 entryPriceOrCurrentPrice: aString jumps: anInteger3 [
	|  quantityLong orderPrice quantityToStopLimit  priceToStopLimit |
		
	numberOfOrders := anInteger.
	quantityToStopLimit := 0. 
	PharocksLog logAdd: 'USD: ',  balance asString.
	quantityTotal := ((((balance / latestPrice) * leverage)/2) roundDownTo: 0.001) round:3.
	((aString = 'entry') and: [(entryPrice > 0)]) ifTrue: [ latestPrice := entryPrice ] .
	anInteger3 > 1 ifTrue: [ latestPrice := (((latestPrice - (latestPrice * railsRatio * anInteger3)) ) roundDownTo: 0.01) round:2 ].
	
	1 to: numberOfOrders do: [  :i |
		orderPrice := (((latestPrice - (latestPrice * railsRatio * i)) ) roundDownTo: 0.01) round:2.
		quantityLong := (((quantityTotal / numberOfOrders) roundDownTo: 0.001) round:3).
		quantityToStopLimit := (((quantityToStopLimit + quantityLong) roundDownTo: 0.001)round:3). 
		priceToStopLimit := (((latestPrice - (latestPrice * railsRatio * (i + 1))) ) roundDownTo: 0.01) round:2.
		exchange futuresPrivateOrderCreateBuy: market type: 'LIMIT' quantity: (((quantityGlobal * anInteger2)roundDownTo: 0.001) round:3) atPrice: orderPrice stopPrice: nil ].
	
	"exchange futuresPrivateOrderCreateSell: market type: 'STOP_MARKET' quantity: ((quantityToStopLimit roundDownTo: 0.001)round:3) atPrice: nil stopPrice: priceToStopLimit. "
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openShort: anInteger [
	self openShort: anInteger weight: 1 entryPriceOrCurrentPrice: 'current' jumps: 1
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openShort: anInteger weight: anInteger2 entryPriceOrCurrentPrice: aString jumps: anInteger3 [
	| quantityShort orderPrice quantityToStopLimit  priceToStopLimit |
		
	numberOfOrders := anInteger.
	quantityToStopLimit := 0. 
	PharocksLog logAdd: 'USD: ',  balance asString.
	quantityTotal := ((((balance / latestPrice) * leverage)/2) roundDownTo: 0.001) round:3.
	((aString = 'entry') and: [(entryPrice > 0)]) ifTrue: [ latestPrice := entryPrice ] .
	anInteger3 > 1 ifTrue: [ latestPrice := (((latestPrice + (latestPrice * railsRatio * anInteger3)) ) roundDownTo: 0.01) round:2 ].
	
	1 to: numberOfOrders do: [  :i | 
		orderPrice := (((latestPrice + (latestPrice * railsRatio * i)) ) roundDownTo: 0.01) round:2.
		quantityShort := (((quantityTotal / numberOfOrders) roundDownTo: 0.001) round:3).
		quantityToStopLimit := (((quantityToStopLimit + quantityShort) roundDownTo: 0.001)round:3). 
		priceToStopLimit := (((latestPrice + (latestPrice * railsRatio * (i + 1))) ) roundDownTo: 0.01) round:2.
		exchange futuresPrivateOrderCreateSell: market type: 'LIMIT' quantity: (((quantityGlobal * anInteger2)roundDownTo: 0.001) round:3) atPrice: orderPrice stopPrice: nil ].

	"exchange futuresPrivateOrderCreateBuy: market type: 'STOP_MARKET' quantity: ((quantityToStopLimit roundDownTo: 0.001)round:3) atPrice: nil stopPrice: priceToStopLimit. "
]

{ #category : #accessing }
PharocksCrossRailsStrategy >> singleTrack [
	|  weightLongPosition weightShortPosition isShortPosition isLongPosition isNoPosition |
	
	^ [  
		self checkOrdersToRun ifTrue:  [ 	
		
		self cancellAll.
		self getPositions.
		self checkBalanceToTransfer.
		
		isLongPosition := quantity > 0.
		isShortPosition := quantity < 0.
		isNoPosition := quantity = 0.

		weightLongPosition := ((( quantity / quantityGlobal )roundDownTo: 1) round:3 ).
		weightShortPosition := ((( quantity / quantityGlobal * -1)roundDownTo: 1) round:3 ).	

			
		isLongPosition ifTrue: [ 
			self openShort: 1 weight: weightLongPosition entryPriceOrCurrentPrice: 'entry' jumps: 1. 
			self openLong: 1 weight: (2 * weightLongPosition) entryPriceOrCurrentPrice: 'entry' jumps: 2.
		].

		isShortPosition ifTrue: [ 
			self openLong: 1 weight: weightShortPosition entryPriceOrCurrentPrice: 'entry' jumps: 1.
			self openShort: 1 weight: (2 * weightShortPosition) entryPriceOrCurrentPrice: 'entry' jumps: 2.
		] .
				
				
		isNoPosition ifTrue: [ 
			self openLong: 1 weight: 1 entryPriceOrCurrentPrice: 'current' jumps: 1.
			self openShort: 1 weight: 1 entryPriceOrCurrentPrice: 'current' jumps: 1.
		].
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
