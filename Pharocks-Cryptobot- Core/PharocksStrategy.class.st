Class {
	#name : #PharocksStrategy,
	#superclass : #Object,
	#instVars : [
		'numberOfAssets',
		'cryptoPair',
		'assets'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #'as yet unclassified' }
PharocksStrategy class >> simpleWinLossPercentage [
	| strategy strategyProfitLoss |
	strategy := self new.
	strategyProfitLoss := PharocksStrategyPercentageProfitLoss new.
	strategy numberOfAssets: 10.
	strategy cryptoPair: 'BNBUSDT'.
	strategy assetsAdd: (strategyProfitLoss profitPercentage: 0.5/100 ; lossPercentage: 0.3/100).
	strategy assetsAdd: (strategyProfitLoss profitPercentage: 0.8/100 ; lossPercentage: 0.5/100).
	strategy assetsAdd: (strategyProfitLoss profitPercentage: 1/100 ; lossPercentage: 0.8/100).
	strategy assetsAdd: (strategyProfitLoss profitPercentage: 2/100 ; lossPercentage: 1.6/100).
	
	^ strategy
]

{ #category : #accessing }
PharocksStrategy >> assets [
	^ assets
]

{ #category : #accessing }
PharocksStrategy >> assets: anObject [
	assets := anObject
]

{ #category : #initialization }
PharocksStrategy >> assetsAdd: anObject [
	assets add: anObject
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
	assets := OrderedCollection new.
]

{ #category : #accessing }
PharocksStrategy >> numberOfAssets [
	^ numberOfAssets
]

{ #category : #accessing }
PharocksStrategy >> numberOfAssets: anObject [
	numberOfAssets := anObject
]
