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
	| strategy  |
	strategy := self new.
	strategy numberOfAssets: 5.
	strategy market: 'USDT'.	
	strategy assetsPercentage add: {('cryptoPair' -> 'BNBUSDT').('profitPercentage' -> 0.5).('lossPercentage' -> 0.5).} asDictionary.
	strategy assetsPercentage add: {('cryptoPair' -> 'BNBUSDT').('profitPercentage' -> 0.6).('lossPercentage' -> 0.6).} asDictionary.
	strategy assetsPercentage add: {('cryptoPair' -> 'BNBUSDT').('profitPercentage' -> 0.7).('lossPercentage' -> 0.7).} asDictionary.
	strategy assetsPercentage add: {('cryptoPair' -> 'BNBUSDT').('profitPercentage' -> 0.8).('lossPercentage' -> 0.8).} asDictionary.
	strategy assetsPercentage add: {('cryptoPair' -> 'BNBUSDT').('profitPercentage' -> 0.9).('lossPercentage' -> 0.9).} asDictionary.
	^ strategy
]

{ #category : #'as yet unclassified' }
PharocksStrategy class >> simpleWinLossPercentage80 [
	"This strategy will create sales orders according to the configured loss / gain percentages. 
	Maximum 5 sell strategies / For now only use crypto pairs from USDT marketing (some hardcode yet) 
	To see the pairs go to FIAT Markets USDT: https://www.binance.com/en/markets"
	| strategy  |
	strategy := self new.
	strategy numberOfAssets: 5.
	strategy market: 'USDT'.	
	strategy assetsPercentage add: {('cryptoPair' -> 'BNBUSDT').('profitPercentage' -> 0.5).('lossPercentage' -> 0.3).} asDictionary.
	strategy assetsPercentage add: {('cryptoPair' -> 'BNBUSDT').('profitPercentage' -> 0.6).('lossPercentage' -> 0.3).} asDictionary.
	strategy assetsPercentage add: {('cryptoPair' -> 'BNBUSDT').('profitPercentage' -> 0.7).('lossPercentage' -> 0.3).} asDictionary.
	strategy assetsPercentage add: {('cryptoPair' -> 'BNBUSDT').('profitPercentage' -> 0.8).('lossPercentage' -> 0.3).} asDictionary.
	strategy assetsPercentage add: {('cryptoPair' -> 'BNBUSDT').('profitPercentage' -> 0.9).('lossPercentage' -> 0.3).} asDictionary.
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
