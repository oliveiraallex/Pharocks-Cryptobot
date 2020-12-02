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
		'quantityGlobal'
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
PharocksCrossRailsStrategy >> checkOrdersOpen [

	| orders side |
	buyOrdersOpen := OrderedCollection  new.
	sellOrdersOpen := OrderedCollection  new.
	orders := exchange futuresPrivateOrderOpen: market.
	orders do: [ :i | side := i at: 'side'. (side = 'BUY') ifTrue: [  buyOrdersOpen add: i ] ].
	orders do: [ :i | side := i at: 'side'. (side = 'SELL') ifTrue: [  sellOrdersOpen add: i ] ].
	"((buyOrdersOpen size) = (sellOrdersOpen size) = numberOfOrders) ifTrue: [ ^ 0]. 
	(buyOrdersOpen size) > (sellOrdersOpen size)  ifTrue: [ ^ 1 ].
	(buyOrdersOpen size) < (sellOrdersOpen size)  ifTrue: [ ^ 2 ]." 

	Transcript show: ((buyOrdersOpen size) - (sellOrdersOpen size) ) asString. 
	^ (buyOrdersOpen size) - (sellOrdersOpen size) 

]

{ #category : #initialization }
PharocksCrossRailsStrategy >> initialize [
	super initialize. 
	market := 'BTCUSDT'.
	coinIndex := 54.

	leverage := 25.
	railsRatio := 0.001.
	
	quantityGlobal := 0.002.
	
	"leverage := 125.
	limitRatio := 0.0001.
	stopLossRatio := 0.0005.
	stopLossMinRatio := 0.001.
	stopGain1Ratio := 0.0015.
	stopGain2Ratio := 0.002.
	stopGain3Ratio := 0.003.
	stopGain4Ratio := 0.004"
	

]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openLong: anInterger [
	|  latestPrice balance quantity orderPrice quantityToStopLimit  priceToStopLimit position entryPrice |
		
	latestPrice := exchange futuresSymbolLatestPrice: market.
	quantityToStopLimit := 0. 
	balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString.
	quantityTotal := ((((balance / latestPrice) * leverage)/2) roundDownTo: 0.001) round:3.
	position := (exchange futuresPositions) at:coinIndex.
	entryPrice := (position at: 'entryPrice') asNumber. 
	(entryPrice > 0) ifTrue: [ latestPrice := entryPrice ].
	
	1 to: anInterger do: [  :i | 
		orderPrice := (((latestPrice - (latestPrice * railsRatio * i)) ) roundDownTo: 0.01) round:2.
		quantity := (((quantityTotal / anInterger) roundDownTo: 0.001) round:3).
		quantityToStopLimit := (((quantityToStopLimit + quantity) roundDownTo: 0.001)round:3). 
		priceToStopLimit := (((latestPrice - (latestPrice * railsRatio * (i + 1))) ) roundDownTo: 0.01) round:2.
		exchange futuresPrivateOrderCreateBuy: market type: 'LIMIT' quantity: 0.02 atPrice: orderPrice stopPrice: nil ].
	
	"exchange futuresPrivateOrderCreateSell: market type: 'STOP_MARKET' quantity: ((quantityToStopLimit roundDownTo: 0.001)round:3) atPrice: nil stopPrice: priceToStopLimit. "
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openLong: anInterger weight: anInteger2 entryPriceOrCurrentPrice: aString jumps: anInteger3 [
	|  latestPrice balance quantity orderPrice quantityToStopLimit  priceToStopLimit position entryPrice |
		
	numberOfOrders := anInterger.
	latestPrice := exchange futuresSymbolLatestPrice: market.
	quantityToStopLimit := 0. 
	balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString.
	quantityTotal := ((((balance / latestPrice) * leverage)/2) roundDownTo: 0.001) round:3.
	(aString = 'entry') ifTrue: [ position := (exchange futuresPositions) at:coinIndex.
	entryPrice := (position at: 'entryPrice') asNumber. 
	(entryPrice > 0) ifTrue: [ latestPrice := entryPrice ] ].
	anInteger3 > 1 ifTrue: [ latestPrice := (((latestPrice - (latestPrice * railsRatio * anInteger3)) ) roundDownTo: 0.01) round:2 ].
	
	1 to: numberOfOrders do: [  :i |
		orderPrice := (((latestPrice - (latestPrice * railsRatio * i)) ) roundDownTo: 0.01) round:2.
		quantity := (((quantityTotal / numberOfOrders) roundDownTo: 0.001) round:3).
		quantityToStopLimit := (((quantityToStopLimit + quantity) roundDownTo: 0.001)round:3). 
		priceToStopLimit := (((latestPrice - (latestPrice * railsRatio * (i + 1))) ) roundDownTo: 0.01) round:2. 
		exchange futuresPrivateOrderCreateBuy: market type: 'LIMIT' quantity: (quantityGlobal * anInteger2) atPrice: orderPrice stopPrice: nil ].
	
	"exchange futuresPrivateOrderCreateSell: market type: 'STOP_MARKET' quantity: ((quantityToStopLimit roundDownTo: 0.001)round:3) atPrice: nil stopPrice: priceToStopLimit. "
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openShort: anInterger [
	|  latestPrice balance quantity orderPrice quantityToStopLimit  priceToStopLimit position entryPrice |
		
	latestPrice := exchange futuresSymbolLatestPrice: market.
	quantityToStopLimit := 0. 
	balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString.
	quantityTotal := ((((balance / latestPrice) * leverage)/2) roundDownTo: 0.001) round:3.
	"position := (exchange futuresPositions) at:coinIndex.
	entryPrice := (position at: 'entryPrice') asNumber. 
	(entryPrice > 0) ifTrue: [ latestPrice := entryPrice ]."
	
	1 to: anInterger do: [  :i | 
		orderPrice := (((latestPrice + (latestPrice * railsRatio * i)) ) roundDownTo: 0.01) round:2.
		quantity := (((quantityTotal / anInterger) roundDownTo: 0.001) round:3).
		quantityToStopLimit := (((quantityToStopLimit + quantity) roundDownTo: 0.001)round:3). 
		priceToStopLimit := (((latestPrice + (latestPrice * railsRatio * (i + 1))) ) roundDownTo: 0.01) round:2.
		exchange futuresPrivateOrderCreateSell: market type: 'LIMIT' quantity: 0.02 atPrice: orderPrice stopPrice: nil ].

	"exchange futuresPrivateOrderCreateBuy: market type: 'STOP_MARKET' quantity: ((quantityToStopLimit roundDownTo: 0.001)round:3) atPrice: nil stopPrice: priceToStopLimit. "
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openShort: anInterger weight: anInteger2 entryPriceOrCurrentPrice: aString jumps: anInteger3 [
	|  latestPrice balance quantity orderPrice quantityToStopLimit  priceToStopLimit position entryPrice |
		
	numberOfOrders := anInterger.
	latestPrice := exchange futuresSymbolLatestPrice: market.
	quantityToStopLimit := 0. 
	balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString.
	quantityTotal := ((((balance / latestPrice) * leverage)/2) roundDownTo: 0.001) round:3.
	(aString = 'entry') ifTrue: [ position := (exchange futuresPositions) at:coinIndex.
	entryPrice := (position at: 'entryPrice') asNumber. 
	(entryPrice > 0) ifTrue: [ latestPrice := entryPrice ] ].
	anInteger3 > 1 ifTrue: [ latestPrice := (((latestPrice + (latestPrice * railsRatio * anInteger3)) ) roundDownTo: 0.01) round:2 ].
	
	1 to: numberOfOrders do: [  :i | 
		orderPrice := (((latestPrice + (latestPrice * railsRatio * i)) ) roundDownTo: 0.01) round:2.
		quantity := (((quantityTotal / numberOfOrders) roundDownTo: 0.001) round:3).
		quantityToStopLimit := (((quantityToStopLimit + quantity) roundDownTo: 0.001)round:3). 
		priceToStopLimit := (((latestPrice + (latestPrice * railsRatio * (i + 1))) ) roundDownTo: 0.01) round:2.
		exchange futuresPrivateOrderCreateSell: market type: 'LIMIT' quantity: (quantityGlobal * anInteger2) atPrice: orderPrice stopPrice: nil ].

	"exchange futuresPrivateOrderCreateBuy: market type: 'STOP_MARKET' quantity: ((quantityToStopLimit roundDownTo: 0.001)round:3) atPrice: nil stopPrice: priceToStopLimit. "
]

{ #category : #accessing }
PharocksCrossRailsStrategy >> startMonitor [
	|  ordersOpen position quantity profit weightBuy weightSell balance |
	
	self cancellAll.
	self openLong: 2 weight: 1 entryPriceOrCurrentPrice: 'current' jumps: 1.
	self openShort: 2 weight: 1 entryPriceOrCurrentPrice: 'current' jumps: 1.
	weightBuy := 1. weightSell := 1.
	processMonitor := [ [ 
	ordersOpen := self checkOrdersOpen.

	
	( ordersOpen ~= 0 )ifTrue:  [ self cancellAll.
	
	balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString.
		
	position := (exchange futuresPositions) at:coinIndex.
	quantity := ((position at: 'positionAmt') asNumber).	
	profit := ((position at: 'unRealizedProfit') asNumber).	

	
	(quantity between: -0.004 and: 0.004) ifTrue: [ weightBuy := 1. weightSell := 1 ].
	
	quantity > 0.004 ifTrue: [ 
		 profit < 0 ifTrue: [ weightBuy := ((quantity / quantityGlobal / 2)roundDownTo: 1) round:3. ] 
			ifFalse: [ weightSell := ((quantity / quantityGlobal / 2)roundDownTo: 1) round:3 ].].
	
	quantity < -0.004 ifTrue: [ 
		profit < 0 ifTrue: [ weightSell := (((quantity * -1) / quantityGlobal / 2)roundDownTo: 1) round:1. ]
			ifFalse: [ weightBuy := (((quantity * -1) / quantityGlobal / 2)roundDownTo: 1) round:3 ].].
	
"	self halt."
			
	quantity > 0 ifTrue: [ 
		profit > 0 ifTrue: [ quantity > 0.005 ifTrue: [ 
			self openLong: 2 weight: weightBuy entryPriceOrCurrentPrice: 'entry' jumps: 1.
			self openShort: 2 weight: 1 entryPriceOrCurrentPrice: 'entry' jumps: 1.  ] 
				ifFalse: [ 
					self openLong: 3 weight: weightBuy entryPriceOrCurrentPrice: 'entry' jumps: 1.
					self openShort: 3 weight: weightSell entryPriceOrCurrentPrice: 'entry' jumps: 1. ].
			 ] 	ifFalse: [ quantity > 0.005 ifTrue: [ 
			self openLong: 2 weight: weightSell entryPriceOrCurrentPrice: 'current' jumps: 1.
			self openShort: 1 weight: weightBuy entryPriceOrCurrentPrice: 'entry' jumps: 1.	 
			self openShort: 1 weight: 1 entryPriceOrCurrentPrice: 'current' jumps: 1.]
				ifFalse: [ 
					self openLong: 2 weight: weightBuy entryPriceOrCurrentPrice: 'current' jumps: 1.
					self openShort: 2 weight: weightSell entryPriceOrCurrentPrice: 'entry' jumps: 1.
					]
				]. 
			]. 
	
	 quantity < 0 ifTrue: [ 
		profit > 0 ifTrue: [ quantity > 0.005 ifTrue: [ 
			self openLong: 2 weight: weightBuy entryPriceOrCurrentPrice: 'entry' jumps: 1.
			self openShort: 2 weight: 1 entryPriceOrCurrentPrice: 'entry' jumps: 1.  
				] ifFalse: [ 		
					self openShort: 3 weight: weightBuy entryPriceOrCurrentPrice: 'entry' jumps: 1.
					self openLong: 3 weight: weightSell entryPriceOrCurrentPrice: 'current' jumps: 1.
					].
			 	 ] 	ifFalse: [ quantity > 0.005 ifTrue: [ 
						self openShort: 2 weight: weightSell entryPriceOrCurrentPrice: 'current' jumps: 1.
						self openLong: 1 weight: weightBuy entryPriceOrCurrentPrice: 'entry' jumps: 1.	 
						self openLong: 1 weight: 1 entryPriceOrCurrentPrice: 'current' jumps: 1.
						] ifFalse: [ 
							self openLong: 2 weight: weightBuy entryPriceOrCurrentPrice: 'entry' jumps: 1.
							self openShort: 2 weight: weightSell entryPriceOrCurrentPrice: 'current' jumps: 1.	 
							]. 
						] .
					].
				].
	
	(Delay forSeconds: 1) wait ] repeat ] forkNamed: 'Pharocks processMonitor'  
]

{ #category : #accessing }
PharocksCrossRailsStrategy >> stopMonitor [
	processMonitor terminate
]
