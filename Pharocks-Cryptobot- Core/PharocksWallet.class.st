Class {
	#name : #PharocksWallet,
	#superclass : #Object,
	#instVars : [
		'assets',
		'amountTotal',
		'currencyPriceNow',
		'cryptoPair'
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
PharocksWallet >> cryptoPair [
	^ cryptoPair
]

{ #category : #accessing }
PharocksWallet >> cryptoPair: anObject [
	cryptoPair := anObject
]

{ #category : #accessing }
PharocksWallet >> currencyPriceNow [
	^ currencyPriceNow
]

{ #category : #accessing }
PharocksWallet >> currencyPriceNow: anObject [
	currencyPriceNow := anObject
]

{ #category : #initialization }
PharocksWallet >> initialize [
	"self walletSync."
	
]
