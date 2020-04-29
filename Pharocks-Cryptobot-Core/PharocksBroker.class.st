Class {
	#name : #PharocksBroker,
	#superclass : #Object,
	#instVars : [
		'wallet',
		'strategy',
		'exchange',
		'result',
		'orderFilled',
		'orderWaiting',
		'orderFilledOCO'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #accessing }
PharocksBroker >> assetsBuy [
	| resultBuy i |
	PharocksLog logAdd: '-----Starting assetsBuy'.
	i := 1.
	resultBuy := OrderedCollection new.
	orderFilled := false.
	wallet assets
		do: [ :asset | 
			asset
				ifNotNil: [ asset status = 'WAITING_TO_BUY'
						ifTrue: [PharocksLog logAdd: 'Creating buy order in exchange'.
							 resultBuy
								add:
									(exchange
										privateOrderCreateBuy: asset cryptoPair
										quantity: asset quantity
										atPrice: asset buyPrice). 
										
										PharocksLog logAdd: 'REPLY ',resultBuy asString ] ] ].
	
	[ orderFilled ]
		whileFalse: [ 
			PharocksLog logAdd: 'Checking if buy order is filled. orderFilled = ', orderFilled asString, '. Waiting 5 seconds'.
			5 seconds wait.
			self checkOrderFilled.
			i := i + 1.
			i = 5 ifTrue: [PharocksLog logAdd: 'Order not filled'. ^ false ] ].
	^ true
]

{ #category : #accessing }
PharocksBroker >> assetsSellOCO [
	| resultSell bnb |
	PharocksLog logAdd: '-----Starting assetsSellOCO'.
	resultSell := OrderedCollection new.
	wallet assets
		do: [ :asset | 
			asset
				ifNotNil: [ asset status = 'WAITING_TO_BUY'
						ifTrue: [bnb := (exchange symbolsAmountFree at: 'XRP') asNumber. 
							resultSell add:
									( exchange
										privateOrderOCOCreateSell: asset cryptoPair
										quantity: ((bnb   roundDownTo: 0.1 ) round: 1)
										atPrice: asset sellPriceProfit
										stopPrice: asset sellPriceLoss
										stopLimitPrice: asset sellPriceLossLimit).
							asset status: 'WAITING_TO_SELL' .
							PharocksLog logAdd: 'REPLY ',resultSell asString] ] ].
				
]

{ #category : #accessing }
PharocksBroker >> checkOrderFilled [
	|ordersBuy|
	PharocksLog logAdd: '---Starting checkOrderFilled'.
	ordersBuy := exchange privateOrderOpenGet: ''. 
	PharocksLog logAdd: 'Checking if buy order is empty. ordersBuy = ', ordersBuy asString.
	(ordersBuy isEmpty) 
		ifTrue: [ PharocksLog logAdd: 'Is empty'. ^ orderFilled := true  ]
		ifFalse: [PharocksLog logAdd: 'Is not empty'. 
			ordersBuy do: [ :order | PharocksLog logAdd: 'order at: status: ',(order at: 'status') .
			(((order at: 'side') = 'BUY') & (((order at: 'status') = 'PARTIALLY_FILLED') | ((order at: 'status') = 'NEW')))  ifTrue: [ PharocksLog logAdd: 'PARTIALLY_FILLED or NEW true'. ^ orderFilled := false ].
			(((order at: 'side') = 'BUY') & (((order at: 'status') = 'FILLED'))) ifTrue: [ PharocksLog logAdd: 'FILLED true'.  ^ orderFilled := true ].
			 ]] 
]

{ #category : #accessing }
PharocksBroker >> checkOrderFilledOCO [
	|ordersOCO currentPrice limitMakerPrice resultSell stopPrice stopLimit | 
	resultSell := OrderedCollection new.
	"PharocksLog logAdd: '---Starting checkOrderFilledOCO'."
	ordersOCO := exchange privateOrderOpenGet: ''. 
	"PharocksLog logAdd: 'Checking if OCO order is empty.'."
	(ordersOCO isEmpty) 
		ifTrue: [ PharocksLog logAdd: 'OCO orders is empty. Nothing to do.'. ^ orderFilledOCO := nil  ]
		ifFalse: ["PharocksLog logAdd: 'Is not empty'. "
			ordersOCO do: [ :order | "PharocksLog logAdd: 'order at: type ',(order at: 'type') ."
			((order at: 'side') = 'SELL') & ((order at: 'type') = 'STOP_LOSS_LIMIT') 
			ifTrue: [ 
				stopPrice := (order at: 'stopPrice') asNumber round:5.
				stopLimit := (order at: 'price') asNumber round:5.
				].
			((order at: 'side') = 'SELL') & ((order at: 'type') = 'LIMIT_MAKER') 
			ifTrue: [ 
				limitMakerPrice := (order at: 'price') asNumber round:5 .
				currentPrice:= (exchange symbolLatestPrice: 'XRPUSDT').
				PharocksLog logAdd: 'NOW limitMaker: ',limitMakerPrice asString, ', stopPrice: ',stopPrice asString,', stopLimit: ', stopLimit asString.
				
				PharocksLog logAdd: 'NEW limitMaker: ',((limitMakerPrice * 1.005) round:5) asString,', stopPrice: ' ,((limitMakerPrice * 0.994 ) round:5) asString,', stopLimit: ',  ((limitMakerPrice * 0.993 ) round:5) asString.
				PharocksLog logAdd: 'Current price of coin on exchange: ',currentPrice asString,' > ' ,((limitMakerPrice * 0.998)round:5) asString,' = ',  (currentPrice > (limitMakerPrice * 0.998)) asString. 
				(currentPrice > (limitMakerPrice * 0.998)) ifTrue: [ 
					PharocksLog logAdd: 'currentPrice bigger than limiteMakerPrice -0.2%. Going to cancel and create new OCO orders'. 
					exchange privateOrdersCancelAll.
				resultSell add:(	
					exchange
						privateOrderOCOCreateSell: (order at: 'symbol')
						quantity: (order at: 'origQty')
						atPrice: ((limitMakerPrice * 1.005) round:5)
						stopPrice: ((limitMakerPrice * 0.994 ) round:5)
						stopLimitPrice: ((limitMakerPrice * 0.993 ) round:5)).
			
				PharocksLog logAdd: 'REPLY ',resultSell asString
					 ].
				
				 ]. 
			 ]] 
]

{ #category : #accessing }
PharocksBroker >> checkPriceToSell: aString priceProfit: aNumber1 priceLoss: aNumber2 [
	| latestPrice |
	latestPrice := exchange symbolLatestPrice: aString.
	latestPrice > aNumber1 | (latestPrice < aNumber2)
		ifTrue: [ ^ 'sell' ]
]

{ #category : #accessing }
PharocksBroker >> configuration [

	
]

{ #category : #accessing }
PharocksBroker >> createAssets [
	| numberOfAssets assetsPercentages symbol lastPrice |
	"need refactory"
	numberOfAssets := strategy numberOfAssets.
	wallet assets: (Array new: numberOfAssets).
	assetsPercentages := strategy assetsPercentage.
	1 to: assetsPercentages size do: [ :i | 
		symbol := (assetsPercentages at: i) at: 'cryptoPair'.
		lastPrice := exchange symbolPriceSell: symbol lastOrders: 5.
		"lastPrice := (lastPrice * 0.1/100) +  lastPrice asFloat round:4. ""hard coded"
		wallet assets
			at: i
			put:
				(PharocksAssets
					cryptoPair: symbol
					buyPrice: (lastPrice)
					quantity: (wallet amountTotalUSDFree  / numberOfAssets / lastPrice )
					profitPercentage: ((assetsPercentages at: i) at: 'profitPercentage')
					lossPercentage: ((assetsPercentages at: i) at: 'lossPercentage')) ]
]

{ #category : #accessing }
PharocksBroker >> executeStrategyOnExchange [
	result := OrderedCollection new.
	self walletSync.
	self createAssets.
	self assetsBuy.
	self assetsSellOCO. 	
]

{ #category : #initialization }
PharocksBroker >> initialize [

	wallet := PharocksWallet new.
	result := OrderedCollection new
]

{ #category : #control }
PharocksBroker >> orderCreateBuy: aString atPrice: aNumber [
	exchange orderCreateBuy: aString atPrice: aNumber
]

{ #category : #control }
PharocksBroker >> orderCreateOCOSell: aString atPrice: aNumber [
	exchange orderCreateOCOSell: aString atPrice: aNumber
]

{ #category : #control }
PharocksBroker >> orderCreateSell: aString atPrice: aNumber [
	exchange orderCreateSell: aString atPrice: aNumber
]

{ #category : #accessing }
PharocksBroker >> orderFilled [
	^ orderFilled
]

{ #category : #accessing }
PharocksBroker >> orderFilled: anObject [
	orderFilled := anObject
]

{ #category : #accessing }
PharocksBroker >> result [
	^ result
]

{ #category : #accessing }
PharocksBroker >> result: anObject [
	result := anObject
]

{ #category : #initialization }
PharocksBroker >> runRoundMaxTime: aNumberOfMinutes [
]

{ #category : #accessing }
PharocksBroker >> setExchange: anObject [
	exchange := anObject
]

{ #category : #control }
PharocksBroker >> setStrategy [
	wallet market strategy market 
	"wallet createAssets"
]

{ #category : #control }
PharocksBroker >> setStrategy: anObject [ 
	strategy := anObject
]

{ #category : #accessing }
PharocksBroker >> strategy [
	^ strategy
]

{ #category : #accessing }
PharocksBroker >> strategy: anObject [
	strategy := anObject 
]

{ #category : #accessing }
PharocksBroker >> trailingStop [
	| limiteMakerPrice ordersOCO|
	
limiteMakerPrice := self checkOrderFilledOCO asNumber.
limiteMakerPrice ifNotNil: [ 
	 ((exchange symbolLatestPrice: 'BNBUSDT') > limiteMakerPrice * 0.999) ifTrue: [ 
		ordersOCO := exchange privateOrderOpenGet: ''. 
		ordersOCO do: [ :order | 
			PharocksLog logAdd: 'Limit maker order open true. Returning price: ',(order at: 'price')asString. 
	"	exchange
			privateOrderOCOCreateSell: asset cryptoPair
			quantity: ((bnb   roundDownTo: 0.01) round:2)
			atPrice: asset sellPriceProfit
			stopPrice: asset sellPriceLoss
			stopLimitPrice: asset sellPriceLossLimit"
		 ]
	 ] ]
]

{ #category : #accessing }
PharocksBroker >> updateAssets [
	| assetsPercentages lastPrice symbol|
	"need refactory"
	assetsPercentages := strategy assetsPercentage.
	(wallet assets) ifNil: [ self createAssets ].
	1 to: assetsPercentages size do: [ :i | 
		symbol := ((wallet assets at: i) cryptoPair).
		lastPrice := exchange symbolPriceSell: symbol lastOrders: 5.
		wallet assets
			at: i
			put:
				(PharocksAssets
					cryptoPair: ((wallet assets at: i) cryptoPair)
					newPrice: (lastPrice round: 4)
					buyPrice: ((wallet assets at: i) buyPrice)
					quantity:  ((wallet assets at: i) quantity)
					profitPercentage: ((assetsPercentages at: i) at: 'profitPercentage')
					lossPercentage: ((assetsPercentages at: i) at: 'lossPercentage')) ]
]

{ #category : #accessing }
PharocksBroker >> wallet [
	^ wallet
]

{ #category : #accessing }
PharocksBroker >> wallet: anObject [
	wallet := anObject
]

{ #category : #control }
PharocksBroker >> walletSync [ .
	"setting the cypto pair defined in the strategy"
	wallet market: strategy market.
	"check in Binance the amount of the USDT wallet"
	wallet amountTotalUSD: exchange symbolsAmountTotalInUSD.
	"check in Binance the price of the pairCurrency"
	wallet amountTotalUSDFree: exchange symbolsAmountTotalInUSDFree.
]
