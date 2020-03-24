Class {
	#name : #PharocksStrategy,
	#superclass : #Object,
	#instVars : [
		'numberOfAssets',
		'cryptoPair',
		'assetsPercentage'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #'as yet unclassified' }
PharocksStrategy class >> simpleWinLossPercentage [
	| strategy |
	strategy := self new.
	strategy numberOfAssets: 10.
	strategy cryptoPair: 'BNBUSDT'.
	strategy assetsPercentage add: (PharocksStrategyPercentageProfitLoss new profitPercentage: 0.5 ; lossPercentage: 0.3).
	strategy assetsPercentage add: (PharocksStrategyPercentageProfitLoss new profitPercentage: 0.8 ; lossPercentage: 0.5).
	strategy assetsPercentage add: (PharocksStrategyPercentageProfitLoss new profitPercentage: 1 ; lossPercentage: 0.8).
	strategy assetsPercentage add: (PharocksStrategyPercentageProfitLoss new profitPercentage: 2 ; lossPercentage: 1.6).
	
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

{ #category : #accessing }
PharocksStrategy >> cryptoPair [
	^ cryptoPair
]

{ #category : #accessing }
PharocksStrategy >> cryptoPair: anObject [
	cryptoPair := anObject
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
