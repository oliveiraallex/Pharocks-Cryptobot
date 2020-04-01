Class {
	#name : #PharocksBroker,
	#superclass : #Object,
	#instVars : [
		'wallet',
		'strategy',
		'exchange',
		'processMonitor'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

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
		symbol := (assetsPercentages at: i) cryptoPair.
		lastPrice := exchange symbolLatestPrice: symbol.
		wallet assets
			at: i
			put:
				(PharocksAssets
					cryptoPair: symbol
					buyPrice: lastPrice
					quantity: (wallet amountTotalUSD / numberOfAssets / lastPrice )
					profitPercentage: (assetsPercentages at: i) profitPercentage
					lossPercentage: (assetsPercentages at: i) lossPercentage) ]
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
PharocksBroker >> orderCreateSell: aString atPrice: aNumber [
	exchange orderCreateSell: aString atPrice: aNumber
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

{ #category : #accessing }
PharocksBroker >> startMonitor [
	self halt.
	processMonitor := [ [ wallet assets
		do: [ :asset |
			asset
				ifNotNil: [ asset status = 'WAITING_TO_BUY'
						ifTrue: [ exchange
								privateOrderCreateBuy: asset cryptoPair
								quantity: asset quantity
								atPrice: asset buyPrice ].
					asset status = 'WAITING_TO_SELL'
						ifTrue: [ (self
								checkPriceToSell: asset crytpoPair
								priceProfit: asset sellPriceProfit
								priceLoss: asset sellPriceLoss) = 'sell'
								ifTrue: [ exchange
										privateOrderCreateSell: asset crytpoPair
										quantity: asset quantity
										atPrice: (exchange symbolBestPriceSell: asset cryptoPair) ] ].
					 ] ].
	(Delay forSeconds: 300000) wait ] repeat ]
		forkNamed: 'Pharocks processMonitor'
]

{ #category : #accessing }
PharocksBroker >> stopMonitor [
	processMonitor terminate
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
PharocksBroker >> walletSync [
	"setting the cypto pair defined in the strategy"
	wallet market: strategy market.
	"check in Binance the amount of the USDT wallet"
	wallet amountTotalUSD: exchange symbolsAmountTotalInUSD.
	"check in Binance the price of the pairCurrency"
	"wallet currencyPriceNow: (exchange symbolLatestPrice: 'BNBUSDT')"
]
