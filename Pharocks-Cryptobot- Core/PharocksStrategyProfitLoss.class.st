Class {
	#name : #PharocksStrategyProfitLoss,
	#superclass : #PharocksStrategy,
	#instVars : [
		'profitPercentage',
		'lossPercentage',
		'cryptoPair'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #accessing }
PharocksStrategyProfitLoss >> cryptoPair [
	^ cryptoPair
]

{ #category : #accessing }
PharocksStrategyProfitLoss >> cryptoPair: anObject [
	cryptoPair := anObject
]

{ #category : #accessing }
PharocksStrategyProfitLoss >> lossPercentage [
	^ lossPercentage
]

{ #category : #accessing }
PharocksStrategyProfitLoss >> lossPercentage: anObject [
	lossPercentage := anObject
]

{ #category : #accessing }
PharocksStrategyProfitLoss >> profitPercentage [
	^ profitPercentage
]

{ #category : #accessing }
PharocksStrategyProfitLoss >> profitPercentage: anObject [
	profitPercentage := anObject
]
