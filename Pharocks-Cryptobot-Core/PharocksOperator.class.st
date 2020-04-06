"
Binance API documentation: https://github.com/binance-exchange/binance-official-api-docs/blob/master/rest-api.md

How to use:
binance := PharocksBinance new apiKey: 'abc123'; apiSecretKey: 'abc123'.
exchange := PharocksCryptocurrencyExchange exchangePlugin: binance.
cryptoRobot := PharocksOperator setExchange: exchange.
cryptoRobot executeStrategyOnExchange. 

After run executeStrategyOnExchange, the Pharocks will buy the numbers of assets configured in strategy method and create the sell orders OCO (One-Cancels-the-Other) Orders with the price setted in strategy method. 



Some examples:

exchange exchangeInfo. ""anObject""
exchange exchangePing. ""true""
exchange exchangeStatus. ""true""
exchange exchangeTime. ""1585330938078""
exchange orderBook: 'BNBUSDT' lastOrders: 5. ""anObject""
exchange symbolAvaregePrice: 'BNBUSDT'. ""12.90751442""
exchange symbolPrice: 'BNBUSDT' lastOrders: 5 type: 'bids'. ""12.89462""
exchange symbolPriceBuy: 'BNBUSDT' lastOrders: 5. ""12.89074""
exchange symbolPriceSell: 'BNBUSDT' lastOrders: 5. ""12.89724""
exchange privateOrders: 'BNBUSDT' last: 5 ""anObject""
exchange privateAccountInformation. 
exchange symbolsInAccount.
exchange symbolsAmountFree.
exchange symbolsAmountLocked.
exchange symbolsAmountTotal.
exchange privateOrderCreateBuy: 'BNBUSDT' quantity: 1 atPrice: (exchange symbolBestPriceBuy: 'BNBUSDT').
exchange privateOrderCreateSell: 'BNBUSDT' quantity: 1 atPrice: (exchange symbolBestPriceSell: 'BNBUSDT').

buyPrice := (exchange symbolLatestPrice: 'BNBUSDT').
exchange privateOrderCreateBuy: 'BNBUSDT' quantity: 1 atPrice: buyPrice.
sellPriceProfit := (buyPrice * 2/100) +  buyPrice asFloat round:4 .
sellPriceLoss := buyPrice - (buyPrice * 1/100) asFloat round:4.
sellPriceLimit := sellPriceLoss - (sellPriceLoss * 0.1/100) asFloat round:4.
exchange privateOrderOCOCreateSell: 'BNBUSDT' quantity: 1 atPrice: sellPriceProfit stopPrice: sellPriceLoss stopLimitPrice: sellPriceLimit.

cryptoRobot := PharocksOperator setExchange: exchange.
cryptoRobot executeStrategyOnServer. 

cryptoRobot setStrategy: PharocksStrategy simpleWinLossPercentage.
cryptoRobot walletSync.
cryptoRobot createAssets. 


assets := PharocksAssets new.
wallet := PharocksWallet new.
strategy := PharocksStrategy simpleWinLossPercentage.
broker := PharocksBroker new.
broker strategy: PharocksStrategy simpleWinLossPercentage.


"
Class {
	#name : #PharocksOperator,
	#superclass : #PharocksBroker,
	#instVars : [
		'processMonitor',
		'indicators'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #accessing }
PharocksOperator class >> setExchange: anObject setStrategy: anObject2 [
	| operator |
	operator := self new.
	operator setExchange: anObject.
	operator wallet: PharocksWallet new.
	operator setStrategy: anObject2.
	^ operator
]

{ #category : #accessing }
PharocksOperator >> down20 [
	exchange privateOrdersCancelAll.
	exchange privateSellEverything
]

{ #category : #accessing }
PharocksOperator >> down80 [
	exchange privateOrdersCancelAll.
	exchange privateSellEverything
]

{ #category : #accessing }
PharocksOperator >> initialize [
	
	
	
]

{ #category : #accessing }
PharocksOperator >> start [ 

	"exchange ifNil: [ (Object new) error: 'Set the Exchange before start the aplication' ]"
	

]

{ #category : #accessing }
PharocksOperator >> startMonitor [
	self halt. 
	processMonitor := [ [ 
			(indicators at: 'stochRSI' = '20up') ifTrue:[ self up20 ].
			
			(indicators at: 'stochRSI' = '80up') ifTrue:[ self up80 ].
			
			(indicators at: 'stochRSI' = '80down') ifTrue:[ self down80].
			
			(indicators at: 'stochRSI') = '20down' ifTrue:[ self down20].
			
					 
	(Delay forSeconds: 300000) wait ] repeat ]
		forkNamed: 'Pharocks processMonitor'
]

{ #category : #accessing }
PharocksOperator >> stopMonitor [
	processMonitor terminate
]

{ #category : #accessing }
PharocksOperator >> up20 [
	exchange privateOrdersCancelAll.
	self createAssets.
	self assetsBuy.
	10 seconds wait.
	self assetsSellOCO. 
]

{ #category : #accessing }
PharocksOperator >> up80 [
	exchange privateOrdersCancelAll.
	self createAssets.
	self assetsSellOCO. 
]
