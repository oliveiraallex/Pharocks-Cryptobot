Class {
	#name : #PharocksStrategy,
	#superclass : #Object,
	#instVars : [
		'numberOfAssets',
		'assetsPercentage'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #'as yet unclassified' }
PharocksStrategy class >> simpleWinLossPercentage [
	| strategy |
	strategy := self new.
	strategy numberOfAssets: 10.
	strategy assetsPercentage add: (PharocksStrategyProfitLoss new cryptoPair: 'BTCUSDT'; profitPercentage: 3 ; lossPercentage: 1).
	strategy assetsPercentage add: (PharocksStrategyProfitLoss new cryptoPair: 'BNBUSDT'; profitPercentage: 0.8 ; lossPercentage: 0.5).
	strategy assetsPercentage add: (PharocksStrategyProfitLoss new cryptoPair: 'BNBUSDT'; profitPercentage: 1 ; lossPercentage: 0.8).
	strategy assetsPercentage add: (PharocksStrategyProfitLoss new cryptoPair: 'ZENUSDT'; profitPercentage: 2 ; lossPercentage: 1.6).
	
	^ strategy
]

{ #category : #accessing }
PharocksStrategy >> assetsPercentage [
	^ assetsPercentage
]

{ #category : #accessing }
PharocksStrategy >> assetsPercentage: anObject [
	assetsPercentage := anObject
]

{ #category : #initialization }
PharocksStrategy >> initialize [
	assetsPercentage := OrderedCollection new
]

{ #category : #accessing }
PharocksStrategy >> numberOfAssets [
	^ numberOfAssets
]

{ #category : #accessing }
PharocksStrategy >> numberOfAssets: anObject [
	numberOfAssets := anObject
]
