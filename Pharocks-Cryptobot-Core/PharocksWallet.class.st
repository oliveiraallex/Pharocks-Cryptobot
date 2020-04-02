Class {
	#name : #PharocksWallet,
	#superclass : #Object,
	#instVars : [
		'assets',
		'amountTotalUSD',
		'market'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #accessing }
PharocksWallet >> amountTotalUSD [
	^ amountTotalUSD
]

{ #category : #accessing }
PharocksWallet >> amountTotalUSD: anObject [
	amountTotalUSD := anObject
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
