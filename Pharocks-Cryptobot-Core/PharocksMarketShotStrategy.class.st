"
Open Short and Long positions manualy in Futures Market with controled Stop Loss and retarget Stop Loss/Gain orders. 

binance := PharocksBinance new apiKey: 'text'; apiSecretKey: 'text'.
exchange := PharocksCryptocurrencyExchange exchangePlugin: binance.

manual := PharocksMarketShotStrategy new. 
manual setExchange: exchange.

manual openShort. 
manual retargetShortFirst.
manual retargetShortSecond.
manual retargetShortThird.
 
manual openLong.
manual retargetLongFirst. 
manual retargetShortSecond.
manual retargetShortThird.
 
manual cancellAll.
"
Class {
	#name : #PharocksMarketShotStrategy,
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
		'limitRatio'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #'as yet unclassified' }
PharocksMarketShotStrategy >> cancellAll [
	| balance |	
		
	exchange futuresOrderCancelAll: 'BTCUSDT'.
	balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString.
]

{ #category : #initialization }
PharocksMarketShotStrategy >> initialize [
	super initialize. 
	market := 'BTCUSDT'.
	coinIndex := 54.

	leverage := 25.
	limitRatio := 0.0001.
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
PharocksMarketShotStrategy >> openLong [
	|  latestPrice balance quantity entryPrice stopLoss stopGain1 stopGain2 |
	
	latestPrice := exchange futuresSymbolLatestPrice: market.
	balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString.
	"exchange futures: market leverage: leverage."
	quantity := ((((balance / latestPrice) * leverage)/2) roundDownTo: 0.001) round:3.
	exchange futuresPrivateOrderCreateBuy: market type: 'MARKET' quantity: quantity atPrice: nil stopPrice: nil. 
	entryPrice := ((exchange futuresPositions at:coinIndex) at: 'entryPrice')asNumber.  
	stopLoss := ((entryPrice - (entryPrice * stopLossRatio)) roundDownTo: 0.01) round:2.
	stopGain1 := ((entryPrice + (entryPrice * stopGain2Ratio)) roundDownTo: 0.01) round:2.
	stopGain2 := ((entryPrice + (entryPrice * stopGain3Ratio)) roundDownTo: 0.01) round:2.
	PharocksLog logAdd: 'PRICE: ' ,  latestPrice asString.
	PharocksLog logAdd: 'ENTRY: ' ,  entryPrice asString.
	PharocksLog logAdd: 'LOSS: ' ,  stopLoss asString.
	PharocksLog logAdd: 'GAIN1: ',  stopGain1 asString.
	PharocksLog logAdd: 'GAIN2: ',  stopGain1 asString.
	exchange futuresPrivateOrderCreateSell: market type: 'STOP_MARKET' quantity: (((quantity)roundDownTo: 0.001)round:3) atPrice: nil stopPrice: stopLoss. 
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: (((quantity/2)roundDownTo: 0.001)round:3) atPrice: nil stopPrice: stopGain1. 
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: (((quantity/2)roundDownTo: 0.001)round:3) atPrice: nil stopPrice: stopGain2
]

{ #category : #'as yet unclassified' }
PharocksMarketShotStrategy >> openShort [
	|  latestPrice balance quantity entryPrice stopLoss stopGain1 stopGain2 |
	
	latestPrice := exchange futuresSymbolLatestPrice: market.
	balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString.
	"exchange futures: market leverage: leverage."
	quantity := ((((balance / latestPrice) * leverage)/2) roundDownTo: 0.001) round:3.
	exchange futuresPrivateOrderCreateSell: market type: 'MARKET' quantity: quantity atPrice: nil stopPrice: nil. 
	entryPrice := ((exchange futuresPositions at:coinIndex) at: 'entryPrice')asNumber.  
	stopLoss := ((entryPrice + (entryPrice * stopLossRatio)) roundDownTo: 0.01) round:2.
	stopGain1 := ((entryPrice - (entryPrice * stopGain2Ratio)) roundDownTo: 0.01) round:2.
	stopGain2 := ((entryPrice - (entryPrice * stopGain3Ratio)) roundDownTo: 0.01) round:2.
	PharocksLog logAdd: 'PRICE: ' ,  latestPrice asString.
	PharocksLog logAdd: 'ENTRY: ' ,  entryPrice asString.
	PharocksLog logAdd: 'LOSS: ' ,  stopLoss asString.
	PharocksLog logAdd: 'GAIN1: ',  stopGain1 asString.
	PharocksLog logAdd: 'GAIN2: ',  stopGain1 asString.
	exchange futuresPrivateOrderCreateBuy: market type: 'STOP_MARKET' quantity: ((quantity)roundDownTo: 0.001) atPrice: nil stopPrice: stopLoss. 
	exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/2)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain1. 
	exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/2)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain2
]

{ #category : #'as yet unclassified' }
PharocksMarketShotStrategy >> retargetLongFirst [
	| quantity entryPrice position stopLoss stopGain1 stopGain2 stopGain3 |
	
	exchange futuresOrderCancelAll: market.
	position := (exchange futuresPositions) at:coinIndex.
	entryPrice := (position at: 'entryPrice') asNumber. 
	quantity := ((position at: 'positionAmt') asNumber).
	quantity positive ifFalse: [ quantity := quantity * -1 ].
	
	stopLoss := entryPrice. 
	stopGain1 := ((entryPrice + (entryPrice * stopGain2Ratio)) roundDownTo: 0.01) round:2.
	stopGain2 := ((entryPrice + (entryPrice * stopGain3Ratio)) roundDownTo: 0.01) round:2.
	stopGain3 := ((entryPrice + (entryPrice * stopGain4Ratio)) roundDownTo: 0.01) round:2.

	exchange futuresPrivateOrderCreateSell: market type: 'STOP_MARKET' quantity: quantity atPrice: nil stopPrice: stopLoss. 
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: (((quantity/2)roundDownTo: 0.001) round:3) atPrice: nil stopPrice: stopGain1.
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: (((quantity/2)roundDownTo: 0.001) round:3) atPrice: nil stopPrice: stopGain2.
	"exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/3)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain3"
]

{ #category : #'as yet unclassified' }
PharocksMarketShotStrategy >> retargetLongSecond [
	| quantity entryPrice stopLoss position stopGain1 stopGain2 stopGain3 |
	
	exchange futuresOrderCancelAll: market.
	position := (exchange futuresPositions) at:coinIndex.
	entryPrice := (position at: 'entryPrice') asNumber. 
	quantity := ((position at: 'positionAmt') asNumber).
	quantity positive ifFalse: [ quantity := quantity * -1 ].
	
	stopLoss := ((entryPrice + (entryPrice * stopLossMinRatio)) roundDownTo: 0.01) round:2.
	stopGain1 := ((entryPrice + (entryPrice * stopGain2Ratio)) roundDownTo: 0.01) round:2.
	stopGain2 := ((entryPrice + (entryPrice * stopGain3Ratio)) roundDownTo: 0.01) round:2.
	stopGain3 := ((entryPrice + (entryPrice * stopGain4Ratio)) roundDownTo: 0.01) round:2.
	
	exchange futuresPrivateOrderCreateSell: market type: 'STOP_MARKET' quantity: quantity atPrice: nil stopPrice: stopLoss. 
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: (((quantity/2)roundDownTo: 0.001) round:3) atPrice: nil stopPrice: stopGain1.
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: (((quantity/2)roundDownTo: 0.001) round:3) atPrice: nil stopPrice: stopGain2.
	"exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/3)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain3"
]

{ #category : #'as yet unclassified' }
PharocksMarketShotStrategy >> retargetLongThird [
	| quantity entryPrice position stopLoss stopGain1 stopGain2 stopGain3 |
	
	exchange futuresOrderCancelAll: market.
	position := (exchange futuresPositions) at:coinIndex.
	entryPrice := (position at: 'entryPrice') asNumber. 
	quantity := ((position at: 'positionAmt') asNumber).
	quantity positive ifFalse: [ quantity := quantity * -1 ].
	
	stopLoss := ((entryPrice + (entryPrice * stopGain1Ratio)) roundDownTo: 0.01) round:2.
	"stopGain1 := ((entryPrice + (entryPrice * stopGain2Ratio)) roundDownTo: 0.01) round:2.
	stopGain2 := ((entryPrice + (entryPrice * stopGain3Ratio)) roundDownTo: 0.01) round:2."
	stopGain3 := ((entryPrice + (entryPrice * stopGain4Ratio)) roundDownTo: 0.01) round:2.

	exchange futuresPrivateOrderCreateSell: market type: 'STOP_MARKET' quantity: quantity atPrice: nil stopPrice: stopLoss. 
	"exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/3)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain1.
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/3)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain2."
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: (((quantity/1)roundDownTo: 0.001) round:3) atPrice: nil stopPrice: stopGain3
]

{ #category : #'as yet unclassified' }
PharocksMarketShotStrategy >> retargetShortFirst [
	| quantity entryPrice position stopLoss stopGain1 stopGain2 stopGain3 |
	 
	exchange futuresOrderCancelAll: market.
	position := (exchange futuresPositions) at:coinIndex.
	entryPrice := (position at: 'entryPrice') asNumber. 
	quantity := ((position at: 'positionAmt') asNumber).
	quantity positive ifFalse: [ quantity := quantity * -1 ].
	
	stopLoss := entryPrice. 
	stopGain1 := ((entryPrice - (entryPrice * stopGain2Ratio)) roundDownTo: 0.01) round:2.
	stopGain2 := ((entryPrice - (entryPrice * stopGain3Ratio)) roundDownTo: 0.01) round:2.
	stopGain3 := ((entryPrice - (entryPrice * stopGain4Ratio)) roundDownTo: 0.01) round:2.

	exchange futuresPrivateOrderCreateBuy: market type: 'STOP_MARKET' quantity: quantity atPrice: nil stopPrice: stopLoss. 
	exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: (((quantity/2)roundDownTo: 0.001) round:3) atPrice: nil stopPrice: stopGain1.
	exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: (((quantity/2)roundDownTo: 0.001) round:3) atPrice: nil stopPrice: stopGain2.
	"exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/3)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain3"
]

{ #category : #'as yet unclassified' }
PharocksMarketShotStrategy >> retargetShortSecond [
	| quantity entryPrice position stopLoss "stopGain1" stopGain2 stopGain3 |
	
	exchange futuresOrderCancelAll: market.
	position := (exchange futuresPositions) at:coinIndex.
	entryPrice := (position at: 'entryPrice') asNumber. 
	quantity := ((position at: 'positionAmt') asNumber).
	quantity positive ifFalse: [ quantity := quantity * -1 ].
	
	stopLoss := ((entryPrice - (entryPrice * stopLossMinRatio)) roundDownTo: 0.01) round:2.
	"stopGain1 := ((entryPrice - (entryPrice * stopGain2Ratio)) roundDownTo: 0.01) round:2."
	stopGain2 := ((entryPrice - (entryPrice * stopGain3Ratio)) roundDownTo: 0.01) round:2.
	stopGain3 := ((entryPrice - (entryPrice * stopGain4Ratio)) roundDownTo: 0.01) round:2.
	
	exchange futuresPrivateOrderCreateBuy: market type: 'STOP_MARKET' quantity: quantity atPrice: nil stopPrice: stopLoss. 
	"exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/3)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain1."
	exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: (((quantity/2)roundDownTo: 0.001) round:3) atPrice: nil stopPrice: stopGain2.
	exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: (((quantity/2)roundDownTo: 0.001) round:3) atPrice: nil stopPrice: stopGain3
]

{ #category : #'as yet unclassified' }
PharocksMarketShotStrategy >> retargetShortThird [
	| quantity entryPrice position stopLoss "stopGain1 stopGain2" stopGain3 |
	
	exchange futuresOrderCancelAll: market.
	position := (exchange futuresPositions) at:coinIndex.
	entryPrice := (position at: 'entryPrice') asNumber. 
	quantity := ((position at: 'positionAmt') asNumber).
	quantity positive ifFalse: [ quantity := quantity * -1 ].
	
	stopLoss := ((entryPrice - (entryPrice * stopGain1Ratio)) roundDownTo: 0.01) round:2.
	"stopGain1 := ((entryPrice - (entryPrice * stopGain2Ratio)) roundDownTo: 0.01) round:2.
	stopGain2 := ((entryPrice - (entryPrice * stopGain3Ratio)) roundDownTo: 0.01) round:2."
	stopGain3 := ((entryPrice - (entryPrice * stopGain4Ratio)) roundDownTo: 0.01) round:2.

	exchange futuresPrivateOrderCreateBuy: market type: 'STOP_MARKET' quantity: quantity atPrice: nil stopPrice: stopLoss. 
	"exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/3)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain1.
	exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/3)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain2."
	exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/1)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain3
]
