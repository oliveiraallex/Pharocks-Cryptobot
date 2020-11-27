"
Open Short and Long positions manualy in Futures Market.

binance := PharocksBinance new apiKey: 'text'; apiSecretKey: 'text'.
exchange := PharocksCryptocurrencyExchange exchangePlugin: binance.

manual := PharocksManual new. 
manual setExchange: exchange.

manual openShort. 
manual retargetShortFirst.
manual retargetShort.
 
manual openLong.
manual retargetLongFirst. 
manual retargetShort.
 
manual cancellAll.
"
Class {
	#name : #PharocksManual,
	#superclass : #PharocksBroker,
	#instVars : [
		'market',
		'coinIndex'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #'as yet unclassified' }
PharocksManual >> cancellAll [
	| balance |	
		
	exchange futuresOrderCancelAll: 'BTCUSDT'.
	balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString.
]

{ #category : #initialization }
PharocksManual >> initialize [
	super initialize. 
	market := 'BTCUSDT'.
	coinIndex := 54
]

{ #category : #'as yet unclassified' }
PharocksManual >> openLong [
	|  latestPrice balance leverage quantity entryPrice stopLoss  stopGain1 stopGain2 |
	
	latestPrice := exchange futuresSymbolLatestPrice: market.
	balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString.
	leverage := 20.
	"exchange futures: market leverage: leverage."
	quantity := (((balance / latestPrice) * leverage)/2) roundDownTo: 0.001.
	exchange futuresPrivateOrderCreateBuy: market type: 'MARKET' quantity: quantity atPrice: nil stopPrice: nil. 
	entryPrice := ((exchange futuresPositions at:coinIndex) at: 'entryPrice')asNumber.  
	stopLoss := ((entryPrice - (entryPrice * 0.002)) roundDownTo: 0.01) round:2.
	stopGain1 := ((entryPrice + (entryPrice * 0.0025)) roundDownTo: 0.01) round:2.
	stopGain2 := ((entryPrice + (entryPrice * 0.005)) roundDownTo: 0.01) round:2.
	PharocksLog logAdd: 'PRICE: ' ,  latestPrice asString.
	PharocksLog logAdd: 'ENTRY: ' ,  entryPrice asString.
	PharocksLog logAdd: 'LOSS: ' ,  stopLoss asString.
	PharocksLog logAdd: 'GAIN1: ',  stopGain1 asString.
	PharocksLog logAdd: 'GAIN2: ',  stopGain1 asString.
	exchange futuresPrivateOrderCreateSell: market type: 'STOP_MARKET' quantity: ((quantity)roundDownTo: 0.001) atPrice: nil stopPrice: stopLoss. 
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/2)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain1. 
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/2)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain2
]

{ #category : #'as yet unclassified' }
PharocksManual >> openShort [
	|  latestPrice balance leverage quantity entryPrice stopLoss stopGain1 stopGain2 |
	
	latestPrice := exchange futuresSymbolLatestPrice: market.
	balance := exchange futuresBalance.
	PharocksLog logAdd: 'USD: ',  balance asString.
	leverage := 20.
	"exchange futures: market leverage: leverage."
	quantity := (((balance / latestPrice) * leverage)/2) roundDownTo: 0.001.
	exchange futuresPrivateOrderCreateSell: market type: 'MARKET' quantity: quantity atPrice: nil stopPrice: nil. 
	entryPrice := ((exchange futuresPositions at:coinIndex) at: 'entryPrice')asNumber.  
	stopLoss := ((entryPrice + (entryPrice * 0.002)) roundDownTo: 0.01) round:2.
	stopGain1 := ((entryPrice - (entryPrice * 0.0025)) roundDownTo: 0.01) round:2.
	stopGain2 := ((entryPrice - (entryPrice * 0.005)) roundDownTo: 0.01) round:2.
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
PharocksManual >> retargetLong [
	| quantity entryPrice stopLoss stopGain position stopGain1 stopGain2 |
	
	exchange futuresOrderCancelAll: market.
	position := (exchange futuresPositions) at:coinIndex.
	entryPrice := (position at: 'entryPrice') asNumber. 
	quantity := ((position at: 'positionAmt') asNumber).
	quantity positive ifFalse: [ quantity := quantity * -1 ].
	
	stopLoss := ((entryPrice + (entryPrice * 0.0006)) roundDownTo: 0.01) round:2.
	stopGain := ((entryPrice + (entryPrice * 0.01)) roundDownTo: 0.01) round:2.
	stopGain1 := ((entryPrice + (entryPrice * 0.015)) roundDownTo: 0.01) round:2.
	stopGain2 := ((entryPrice + (entryPrice * 0.02)) roundDownTo: 0.01) round:2.
	
	exchange futuresPrivateOrderCreateSell: market type: 'STOP_MARKET' quantity: ((quantity)roundDownTo: 0.001) atPrice: nil stopPrice: stopLoss. 
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/3)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain.
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/3)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain1.
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/3)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain2
]

{ #category : #'as yet unclassified' }
PharocksManual >> retargetLongFirst [
	| quantity entryPrice stopGain position stopGain1 |
	
	exchange futuresOrderCancelAll: market.
	position := (exchange futuresPositions) at:coinIndex.
	entryPrice := (position at: 'entryPrice') asNumber. 
	quantity := ((position at: 'positionAmt') asNumber).
	quantity positive ifFalse: [ quantity := quantity * -1 ].
	
	stopGain := ((entryPrice + (entryPrice * 0.005)) roundDownTo: 0.01) round:2.
	stopGain1 := ((entryPrice + (entryPrice * 0.01)) roundDownTo: 0.01) round:2.

	exchange futuresPrivateOrderCreateSell: market type: 'STOP_MARKET' quantity: quantity atPrice: nil stopPrice: entryPrice. 
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/2)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain.
	exchange futuresPrivateOrderCreateSell: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/2)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain1
]

{ #category : #'as yet unclassified' }
PharocksManual >> retargetShort [
	| quantity entryPrice stopLoss stopGain position stopGain1 stopGain2 |
	
	exchange futuresOrderCancelAll: market.
	position := (exchange futuresPositions) at:coinIndex.
	entryPrice := (position at: 'entryPrice') asNumber. 
	quantity := ((position at: 'positionAmt') asNumber).
	quantity positive ifFalse: [ quantity := quantity * -1 ].
	
	stopLoss := ((entryPrice - (entryPrice * 0.0006)) roundDownTo: 0.01) round:2.
	stopGain := ((entryPrice - (entryPrice * 0.01)) roundDownTo: 0.01) round:2.
	stopGain1 := ((entryPrice - (entryPrice * 0.015)) roundDownTo: 0.01) round:2.
	stopGain2 := ((entryPrice - (entryPrice * 0.02)) roundDownTo: 0.01) round:2.
	
	exchange futuresPrivateOrderCreateBuy: market type: 'STOP_MARKET' quantity: quantity atPrice: nil stopPrice: stopLoss. 
	exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/3)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain.
	exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/3)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain1.
	exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/3)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain2
]

{ #category : #'as yet unclassified' }
PharocksManual >> retargetShortFirst [
	| quantity entryPrice stopGain position stopGain1 |
	 
	exchange futuresOrderCancelAll: market.
	position := (exchange futuresPositions) at:coinIndex.
	entryPrice := (position at: 'entryPrice') asNumber. 
	quantity := ((position at: 'positionAmt') asNumber).
	quantity positive ifFalse: [ quantity := quantity * -1 ].
	
	stopGain := ((entryPrice - (entryPrice * 0.005)) roundDownTo: 0.01) round:2.
	stopGain1 := ((entryPrice - (entryPrice * 0.01)) roundDownTo: 0.01) round:2.

	exchange futuresPrivateOrderCreateBuy: market type: 'STOP_MARKET' quantity: quantity atPrice: nil stopPrice: entryPrice. 
	exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/2)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain.
	exchange futuresPrivateOrderCreateBuy: market type: 'TAKE_PROFIT_MARKET' quantity: ((quantity/2)roundDownTo: 0.001) atPrice: nil stopPrice: stopGain1
]
