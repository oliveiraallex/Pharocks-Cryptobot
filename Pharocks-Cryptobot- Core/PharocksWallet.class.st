Class {
	#name : #PharocksWallet,
	#superclass : #Object,
	#instVars : [
		'assets',
		'amountTotal',
		'exchange',
		'strategy'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #accessing }
PharocksWallet >> amountTotal [
	^ amountTotal
]

{ #category : #accessing }
PharocksWallet >> amountTotal: anObject [
	amountTotal := anObject
]

{ #category : #accessing }
PharocksWallet >> assets [
	^ assets
]

{ #category : #accessing }
PharocksWallet >> assets: anObject [
	assets := anObject
]

{ #category : #accessing }
PharocksWallet >> assetsTotal [
	^ assets size
]

{ #category : #accessing }
PharocksWallet >> createAsset: aString profit: aNumber loss: aNumber2 [
	
]

{ #category : #accessing }
PharocksWallet >> createAssets [
	| numberOfAssets assetsPercentages| 
	numberOfAssets := strategy numberOfAssets.
	assets := Array new: numberOfAssets.
	assetsPercentages := strategy assets.
	
	assetsPercentages do: [ :each | each ].
	self halt.
]

{ #category : #accessing }
PharocksWallet >> exchange [
	^ exchange
]

{ #category : #accessing }
PharocksWallet >> exchange: anObject [
	exchange := anObject
]

{ #category : #initialization }
PharocksWallet >> initialize [
	self walletSync.
	
]

{ #category : #accessing }
PharocksWallet >> strategy [
	^ strategy
]

{ #category : #accessing }
PharocksWallet >> strategy: anObject [
	strategy := anObject
]

{ #category : #initialization }
PharocksWallet >> walletSync [
	"check in Binance the amount of the USDT wallet"
	amountTotal := 100 
]
