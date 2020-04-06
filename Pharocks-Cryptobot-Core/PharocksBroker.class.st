Class {
	#name : #PharocksBroker,
	#superclass : #Object,
	#instVars : [
		'wallet',
		'strategy',
		'exchange',
		'result'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #accessing }
PharocksBroker >> assetsBuy [
	| resultBuy |
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
	result add: resultBuy
]

{ #category : #accessing }
PharocksBroker >> assetsSellOCO [
	| resultSell |
	resultSell := OrderedCollection new.
	wallet assets
		do: [ :asset | 
			asset
				ifNotNil: [ asset status = 'WAITING_TO_BUY'
						ifTrue: [ resultSell
								add:
									(exchange
										privateOrderOCOCreateSell: asset cryptoPair
										quantity: (asset quantity - (asset quantity * 0.2 / 100) round: 2)
										atPrice: asset sellPriceProfit
										stopPrice: asset sellPriceLoss
										stopLimitPrice: asset sellPriceLossLimit).
							asset status: 'WAITING_TO_SELL' ] ] ].
	result add: resultSell
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
					quantity: (wallet amountTotalUSDFree / numberOfAssets / lastPrice )
					profitPercentage: ((assetsPercentages at: i) at: 'profitPercentage')
					lossPercentage: ((assetsPercentages at: i) at: 'lossPercentage')) ]
]

{ #category : #accessing }
PharocksBroker >> executeStrategyOnExchange [
	result := OrderedCollection new.
	self walletSync.
	self createAssets.
	self assetsBuy.
	10 seconds wait.
	self assetsSellOCO. 	
]

{ #category : #initialization }
PharocksBroker >> initialize [

	wallet := PharocksWallet new.
	"check the amount of USDT in Binance and set it in" "amountTotal := walletSync"
	"amountTotal := wallet walletSync."
	
	
	""
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