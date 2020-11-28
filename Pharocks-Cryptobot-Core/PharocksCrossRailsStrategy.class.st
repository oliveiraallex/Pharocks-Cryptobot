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
		'railsRatio'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> cancellAll [
	| balance |	
		
	exchange futuresOrderCancelAll: 'BTCUSDT'.
	balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString.
]

{ #category : #initialization }
PharocksCrossRailsStrategy >> initialize [
	super initialize. 
	market := 'BTCUSDT'.
	coinIndex := 54.

	leverage := 25.
	railsRatio := 0.001.
	stopLossRatio := 0.0005.
	stopLossMinRatio := 0.001.
	stopGain1Ratio := 0.0018.
	stopGain2Ratio := 0.0036.
	stopGain3Ratio := 0.0054.
	stopGain4Ratio := 0.0072.
	
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
	|  latestPrice balance quantity orderPrice quantityTotal quantityToStopLimit  priceToStopLimit |
		
	latestPrice := exchange futuresSymbolLatestPrice: market.
	quantityToStopLimit := 0. 
	balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString.
	quantityTotal := ((((balance / latestPrice) * leverage)/2) roundDownTo: 0.001) round:3.
	
	1 to: anInterger do: [  :i | 
		orderPrice := (((latestPrice - (latestPrice * railsRatio * i)) ) roundDownTo: 0.01) round:2.
		quantity := (((quantityTotal / anInterger) roundDownTo: 0.001) round:3).
		quantityToStopLimit := (((quantityToStopLimit + quantity) roundDownTo: 0.001)round:3). 
		priceToStopLimit := (((latestPrice - (latestPrice * railsRatio * (i + 1))) ) roundDownTo: 0.01) round:2.
		exchange futuresPrivateOrderCreateBuy: market type: 'LIMIT' quantity: quantity atPrice: orderPrice stopPrice: nil ].
	
	exchange futuresPrivateOrderCreateSell: market type: 'STOP_MARKET' quantity: ((quantityToStopLimit roundDownTo: 0.001)round:3) atPrice: nil stopPrice: priceToStopLimit. 
]

{ #category : #'as yet unclassified' }
PharocksCrossRailsStrategy >> openShort: anInterger [
	|  latestPrice balance quantity orderPrice quantityTotal quantityToStopLimit  priceToStopLimit |
		
	latestPrice := exchange futuresSymbolLatestPrice: market.
	quantityToStopLimit := 0. 
	balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString.
	quantityTotal := ((((balance / latestPrice) * leverage)/2) roundDownTo: 0.001) round:3.
	
	1 to: anInterger do: [  :i | 
		orderPrice := (((latestPrice + (latestPrice * railsRatio * i)) ) roundDownTo: 0.01) round:2.
		quantity := (((quantityTotal / anInterger) roundDownTo: 0.001) round:3).
		quantityToStopLimit := (((quantityToStopLimit + quantity) roundDownTo: 0.001)round:3). 
		priceToStopLimit := (((latestPrice + (latestPrice * railsRatio * (i + 1))) ) roundDownTo: 0.01) round:2.
		exchange futuresPrivateOrderCreateSell: market type: 'LIMIT' quantity: quantity atPrice: orderPrice stopPrice: nil ].

	exchange futuresPrivateOrderCreateBuy: market type: 'STOP_MARKET' quantity: ((quantityToStopLimit roundDownTo: 0.001)round:3) atPrice: nil stopPrice: priceToStopLimit. 
]
