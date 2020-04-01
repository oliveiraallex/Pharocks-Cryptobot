Class {
	#name : #PharocksStrategy,
	#superclass : #Object,
	#instVars : [
		'numberOfAssets',
		'assetsPercentage',
		'market'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #'as yet unclassified' }
PharocksStrategy class >> simpleWinLossPercentage [
	| strategy |
	strategy := self new.
	strategy numberOfAssets: 10.
	strategy market: 'USDT'.
	strategy assetsPercentage add: (PharocksStrategyProfitLoss new cryptoPair: 'BNBUSDT'; profitPercentage: 1 ; lossPercentage: 0.7).
	strategy assetsPercentage add: (PharocksStrategyProfitLoss new cryptoPair: 'BNBUSDT'; profitPercentage: 1.3 ; lossPercentage: 0.9).
	strategy assetsPercentage add: (PharocksStrategyProfitLoss new cryptoPair: 'BNBUSDT'; profitPercentage: 1.5 ; lossPercentage: 1).
	strategy assetsPercentage add: (PharocksStrategyProfitLoss new cryptoPair: 'BNBUSDT'; profitPercentage: 2 ; lossPercentage: 1.5).
	strategy assetsPercentage add: (PharocksStrategyProfitLoss new cryptoPair: 'BNBUSDT'; profitPercentage: 3 ; lossPercentage: 2).
	
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
PharocksStrategy >> market [
	^ market
]

{ #category : #accessing }
PharocksStrategy >> market: aString [
	market := aString
]

{ #category : #accessing }
PharocksStrategy >> numberOfAssets [
	^ numberOfAssets
]

{ #category : #accessing }
PharocksStrategy >> numberOfAssets: anObject [
	numberOfAssets := anObject
]
