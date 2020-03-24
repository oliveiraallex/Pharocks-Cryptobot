Class {
	#name : #PharocksAssets,
	#superclass : #Object,
	#instVars : [
		'cryptoPair',
		'quantity',
		'buyPrice',
		'soldPrice',
		'sellPriceProfit',
		'sellPriceLoss',
		'profitPercentage',
		'lossPercentage'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #'as yet unclassified' }
PharocksAssets class >> cryptoPair: aString buyPrice: aNumberBuy quantity: aNumber1 profitPercentage: aNumberProfit lossPercentage: aNumberLoss [

	| assert sellPriceProfit sellPriceLoss| 
	sellPriceProfit := (aNumberBuy * aNumberProfit/100) +  aNumberBuy asFloat.
	sellPriceLoss :=  aNumberBuy - (aNumberBuy * aNumberLoss/100) asFloat.
	assert := self new.
	assert cryptoPair: aString;
	buyPrice: aNumberBuy asFloat;
	quantity: aNumber1 asFloat;
	profitPercentage: aNumberProfit asFloat;
	lossPercentage: aNumberLoss asFloat;
	sellPriceProfit: sellPriceProfit;
	sellPriceLoss: sellPriceLoss.
	
	
	^ assert
	
	
]

{ #category : #accessing }
PharocksAssets >> buyPrice [
	^ buyPrice
]

{ #category : #accessing }
PharocksAssets >> buyPrice: anObject [
	buyPrice := anObject
]

{ #category : #accessing }
PharocksAssets >> cryptoPair [
	^ cryptoPair
]

{ #category : #accessing }
PharocksAssets >> cryptoPair: anObject [
	cryptoPair := anObject
]

{ #category : #initialization }
PharocksAssets >> initialize [

]

{ #category : #accessing }
PharocksAssets >> lossPercentage [
	^ lossPercentage
]

{ #category : #accessing }
PharocksAssets >> lossPercentage: anObject [
	lossPercentage := anObject
]

{ #category : #accessing }
PharocksAssets >> profitPercentage [
	^ profitPercentage
]

{ #category : #accessing }
PharocksAssets >> profitPercentage: anObject [
	profitPercentage := anObject
]

{ #category : #accessing }
PharocksAssets >> quantity [
	^ quantity
]

{ #category : #accessing }
PharocksAssets >> quantity: anObject [
	quantity := anObject
]

{ #category : #accessing }
PharocksAssets >> sellPriceLoss [
	^ sellPriceLoss
]

{ #category : #accessing }
PharocksAssets >> sellPriceLoss: anObject [
	sellPriceLoss := anObject
]

{ #category : #accessing }
PharocksAssets >> sellPriceProfit [
	^ sellPriceProfit
]

{ #category : #accessing }
PharocksAssets >> sellPriceProfit: anObject [
	sellPriceProfit := anObject
]

{ #category : #accessing }
PharocksAssets >> soldPrice [
	^ soldPrice
]

{ #category : #accessing }
PharocksAssets >> soldPrice: anObject [
	soldPrice := anObject
]
