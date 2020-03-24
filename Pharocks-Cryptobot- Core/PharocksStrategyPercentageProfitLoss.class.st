Class {
	#name : #PharocksStrategyPercentageProfitLoss,
	#superclass : #PharocksStrategy,
	#instVars : [
		'profitPercentage',
		'lossPercentage'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #accessing }
PharocksStrategyPercentageProfitLoss >> lossPercentage [
	^ lossPercentage
]

{ #category : #accessing }
PharocksStrategyPercentageProfitLoss >> lossPercentage: anObject [
	lossPercentage := anObject
]

{ #category : #accessing }
PharocksStrategyPercentageProfitLoss >> profitPercentage [
	^ profitPercentage
]

{ #category : #accessing }
PharocksStrategyPercentageProfitLoss >> profitPercentage: anObject [
	profitPercentage := anObject
]
