Class {
	#name : #PharocksWallet,
	#superclass : #Object,
	#instVars : [
		'assets',
		'amountTotal',
		'currencyPriceNow',
		'market'
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

{ #category : #accessing }
PharocksWallet >> market [
	^ market
]

{ #category : #accessing }
PharocksWallet >> market: anObject [
	market := anObject
]
