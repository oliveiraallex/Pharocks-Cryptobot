Class {
	#name : #PharocksBroker,
	#superclass : #Object,
	#instVars : [
		'wallet',
		'strategy',
		'exchange',
		'result',
		'orderFilled'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #accessing }
PharocksBroker >> assetsBuy [
	| resultBuy i |
	i := 1.
	resultBuy := OrderedCollection new.
	wallet assets
		do: [ :asset | 
			asset
				ifNotNil: [ asset status = 'WAITING_TO_BUY'
						ifTrue: [ resultBuy
								add:
									(exchange
										privateOrderCreateBuy: asset cryptoPair
										quantity: asset quantity
										atPrice: asset buyPrice) ] ] ].
	[ orderFilled ]
		whileFalse: [ 5 seconds wait. 
			self checkOrderFilled.
			i := i + 1.
			i = 5
				ifTrue: [  orderFilled := true.
					exchange privateOrdersCancelAll.
					^ false ] ].
	^ true
]

{ #category : #accessing }
PharocksBroker >> assetsSellOCO [
	| resultSell bnb |
	resultSell := OrderedCollection new.
	wallet assets
		do: [ :asset | 
			asset
				ifNotNil: [ asset status = 'WAITING_TO_BUY'
						ifTrue: [bnb := (exchange symbolsAmountFree at: 'BNB') asNumber. 
							resultSell add:
									( exchange
										privateOrderOCOCreateSell: asset cryptoPair
										quantity: ((bnb - (bnb * 1 / 100)  roundDownTo: 0.01) round:2)
										atPrice: asset sellPriceProfit
										stopPrice: asset sellPriceLoss
										stopLimitPrice: asset sellPriceLossLimit).
							asset status: 'WAITING_TO_SELL' ] ] ]
]

{ #category : #accessing }
PharocksBroker >> checkOrderFilled [
	|ordersBuy|
	orderFilled := true.
	ordersBuy := exchange privateOrderOpenGet: ''. 
	ordersBuy do: [ :order | (((order at: 'side') = 'BUY') & ((order at: 'status') = 'NEW')) ifTrue: [ ^ orderFilled := false ] ]
	
"change name to orderWaiting"
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
					buyPrice: (lastPrice round:4)
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
