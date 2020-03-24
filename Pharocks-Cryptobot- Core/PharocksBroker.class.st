Class {
	#name : #PharocksBroker,
	#superclass : #Object,
	#instVars : [
		'wallet',
		'strategy',
		'exchange'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #accessing }
PharocksBroker >> configuration [

	
]

{ #category : #accessing }
PharocksBroker >> createAssets [
	| numberOfAssets assetsPercentages quantity buyPrice cryptoPair |
	numberOfAssets := strategy numberOfAssets.
	wallet assets: (Array new: numberOfAssets).
	assetsPercentages := strategy assetsPercentage.
	quantity := wallet amountTotal / numberOfAssets.
	buyPrice := wallet currencyPriceNow.
	cryptoPair := strategy cryptoPair.
	1 to: assetsPercentages size do: [ :i | wallet assets at: i put:
		(PharocksAssets
			cryptoPair: cryptoPair
			buyPrice: buyPrice
			quantity: quantity
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

{ #category : #initialization }
PharocksBroker >> runRoundMaxTime: aNumberOfMinutes [
]

{ #category : #accessing }
PharocksBroker >> setExchange: anObject [
	exchange := anObject
]

{ #category : #control }
PharocksBroker >> setStrategy [
	wallet cryptoPair: strategy cryptoPair 
	"wallet createAssets"
]

{ #category : #accessing }
PharocksBroker >> setWalletExchange: anObject [
	exchange := anObject
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

{ #category : #initialization }
PharocksBroker >> walletSync [
	"setting the cypto pair defined in the strategy"
	wallet cryptoPair: strategy cryptoPair. 
	"check in Binance the amount of the USDT wallet"
	wallet amountTotal: exchange walletAmount.
	"check in Binance the price of the pairCurrency"
	wallet currencyPriceNow: (exchange cryptoPairPrice: wallet cryptoPair)
]
