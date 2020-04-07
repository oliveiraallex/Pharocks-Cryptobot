Class {
	#name : #PharocksAssets,
	#superclass : #Object,
	#instVars : [
		'status',
		'cryptoPair',
		'quantity',
		'buyPrice',
		'soldPrice',
		'sellPriceProfit',
		'sellPriceLoss',
		'sellPriceLossLimit',
		'profitPercentage',
		'lossPercentage',
		'soldPercentage'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #'as yet unclassified' }
PharocksAssets class >> cryptoPair: aString buyPrice: aNumberBuy quantity: aNumber1 profitPercentage: aNumberProfit lossPercentage: aNumberLoss [

	| assert sellPriceProfit sellPriceLoss sellPriceLossLimit| 
	sellPriceProfit := (aNumberBuy * aNumberProfit/100) +  aNumberBuy asFloat.
	sellPriceLoss :=  aNumberBuy - (aNumberBuy * aNumberLoss/100) asFloat.
	sellPriceLossLimit := sellPriceLoss - (sellPriceLoss * 0.1/100) asFloat.  "hard coded"
	assert := self new.
	assert cryptoPair: aString;
	buyPrice: aNumberBuy asFloat;
	quantity: (aNumber1 asFloat round:2);
	profitPercentage: aNumberProfit asFloat;
	lossPercentage: aNumberLoss asFloat;
	sellPriceProfit: (sellPriceProfit round:2);
	sellPriceLoss: (sellPriceLoss round:2);
	sellPriceLossLimit: (sellPriceLossLimit round:2);
	status: 'WAITING_TO_BUY'.
	
	
	^ assert
	
	
]

{ #category : #'as yet unclassified' }
PharocksAssets class >> cryptoPair: aString newPrice: aNumberBuy2 buyPrice: aNumberBuy  quantity: aNumber1 profitPercentage: aNumberProfit lossPercentage: aNumberLoss [

	| assert sellPriceProfit sellPriceLoss sellPriceLossLimit| 
	sellPriceProfit := (aNumberBuy2 * aNumberProfit/100) +  aNumberBuy2 asFloat.
	sellPriceLoss :=  aNumberBuy2 - (aNumberBuy2 * aNumberLoss/100) asFloat.
	sellPriceLossLimit := sellPriceLoss - (sellPriceLoss * 0.1/100) asFloat.  "hard coded"
	assert := self new.
	assert cryptoPair: aString;
	buyPrice: aNumberBuy asFloat;
	quantity: (aNumber1 asFloat round:2);
	profitPercentage: aNumberProfit asFloat;
	lossPercentage: aNumberLoss asFloat;
	sellPriceProfit: (sellPriceProfit round:2);
	sellPriceLoss: (sellPriceLoss round:2);
	sellPriceLossLimit: (sellPriceLossLimit round:2);
	status: 'WAITING_TO_BUY'.
	
	
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
PharocksAssets >> sellPriceLossLimit [
	^ sellPriceLossLimit
]

{ #category : #accessing }
PharocksAssets >> sellPriceLossLimit: anObject [
	sellPriceLossLimit := anObject
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
PharocksAssets >> soldPercentage [
	^ soldPercentage
]

{ #category : #accessing }
PharocksAssets >> soldPercentage: anObject [
	soldPercentage := anObject
]

{ #category : #accessing }
PharocksAssets >> soldPrice [
	^ soldPrice
]

{ #category : #accessing }
PharocksAssets >> soldPrice: anObject [
	soldPrice := anObject
]

{ #category : #accessing }
PharocksAssets >> status [
	^ status
]

{ #category : #accessing }
PharocksAssets >> status: anObject [
	status := anObject
]
