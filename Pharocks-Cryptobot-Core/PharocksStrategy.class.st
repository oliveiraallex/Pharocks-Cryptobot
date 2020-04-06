Class {
	#name : #PharocksStrategy,
	#superclass : #Object,
	#instVars : [
		'numberOfAssets',
		'assetsPercentage',
		'market'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #'as yet unclassified' }
PharocksStrategy class >> simpleWinLossPercentage [
	"This strategy will create sales orders according to the configured loss / gain percentages. 
	Maximum 5 sell strategies / For now only use crypto pairs from USDT marketing (some hardcode yet) 
	To see the pairs go to FIAT Markets USDT: https://www.binance.com/en/markets"
	| strategy |
	strategy := self new.
	strategy numberOfAssets: 5.
	strategy market: 'USDT'.
	strategy assetsPercentage add: (PharocksStrategyProfitLoss new cryptoPair: 'BNBUSDT'; profitPercentage: 1.5 ; lossPercentage: 0.5).
	strategy assetsPercentage add: (PharocksStrategyProfitLoss new cryptoPair: 'BNBUSDT'; profitPercentage: 1.8 ; lossPercentage: 0.6).
	strategy assetsPercentage add: (PharocksStrategyProfitLoss new cryptoPair: 'BNBUSDT'; profitPercentage: 2.1 ; lossPercentage: 0.7).
	strategy assetsPercentage add: (PharocksStrategyProfitLoss new cryptoPair: 'BNBUSDT'; profitPercentage: 2.4 ; lossPercentage: 0.8).
	strategy assetsPercentage add: (PharocksStrategyProfitLoss new cryptoPair: 'BNBUSDT'; profitPercentage: 3 ; lossPercentage: 1).
	
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
