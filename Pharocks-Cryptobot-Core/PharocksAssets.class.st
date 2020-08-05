Class {
	#name : #PharocksAssets,
	#superclass : #Object,
	#instVars : [
		'status',
		'cryptoPair',
		'coin',
		'quantity',
		'buyPrice',
		'soldPrice',
		'sellPriceProfit',
		'sellPriceLoss',
		'sellPriceLossLimit',
		'profitPercentage',
		'lossPercentage',
		'soldPercentage',
		'amountDecimals',
		'priceDecimals',
		'minPrice',
		'minAmount'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #'as yet unclassified' }
PharocksAssets class >> crypto: aString market: aString2 buyPrice: aNumberBuy quantity: aNumber1 profitPercentage: aNumberProfit lossPercentage: aNumberLoss [

	| assert sellPriceProfit sellPriceLoss sellPriceLossLimit amountDecimals priceDecimals coinRules| 
	sellPriceProfit := (aNumberBuy * aNumberProfit/100) +  aNumberBuy asFloat.
	sellPriceLoss :=  aNumberBuy - (aNumberBuy * aNumberLoss/100) asFloat.
	sellPriceLossLimit := sellPriceLoss - (sellPriceLoss * 0.1/100) asFloat.  "hard coded"
	coinRules := (PharocksCoins rules: aString,aString2).
	amountDecimals :=  coinRules at: 'amountDecimals'.
	priceDecimals := coinRules at: 'priceDecimals'.
	assert := self new.
	assert amountDecimals: amountDecimals.
	assert priceDecimals: priceDecimals.
	assert minPrice: (coinRules at: 'minPrice'). 
	assert minAmount: (coinRules at: 'minAmount').
	assert coin: aString.
	assert cryptoPair: aString,aString2;
	buyPrice: ((aNumberBuy asFloat roundDownTo: assert minPrice ) round: priceDecimals);
	quantity: ((aNumber1 asFloat roundDownTo: assert minAmount ) round: amountDecimals) ;
	profitPercentage: aNumberProfit asFloat;
	lossPercentage: aNumberLoss asFloat;
	sellPriceProfit: (sellPriceProfit round: priceDecimals);
	sellPriceLoss: (sellPriceLoss round: priceDecimals);
	sellPriceLossLimit: (sellPriceLossLimit round: priceDecimals);
	status: 'WAITING_TO_BUY'.
	
	
	^ assert
	
	
]

{ #category : #'as yet unclassified' }
PharocksAssets class >> cryptoPair: aString buyPrice: aNumberBuy quantity: aNumber1 profitPercentage: aNumberProfit lossPercentage: aNumberLoss [

	| assert sellPriceProfit sellPriceLoss sellPriceLossLimit amountDecimals priceDecimals coinRules| 
	sellPriceProfit := (aNumberBuy * aNumberProfit/100) +  aNumberBuy asFloat.
	sellPriceLoss :=  aNumberBuy - (aNumberBuy * aNumberLoss/100) asFloat.
	sellPriceLossLimit := sellPriceLoss - (sellPriceLoss * 0.1/100) asFloat.  "hard coded"
	coinRules := (PharocksCoins rules: aString).
	amountDecimals :=  coinRules at: 'amountDecimals'.
	priceDecimals := coinRules at: 'priceDecimals'.
	assert := self new.
	assert amountDecimals: amountDecimals.
	assert priceDecimals: priceDecimals.
	assert minPrice: (coinRules at: 'minPrice'). 
	assert minAmount: (coinRules at: 'minAmount').
	assert cryptoPair: aString;
	buyPrice: ((aNumberBuy asFloat roundDownTo: assert minPrice ) round: priceDecimals);
	quantity: ((aNumber1 asFloat roundDownTo: assert minAmount ) round: amountDecimals) ;
	profitPercentage: aNumberProfit asFloat;
	lossPercentage: aNumberLoss asFloat;
	sellPriceProfit: (sellPriceProfit round: priceDecimals);
	sellPriceLoss: (sellPriceLoss round: priceDecimals);
	sellPriceLossLimit: (sellPriceLossLimit round: priceDecimals);
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
PharocksAssets >> amountDecimals [
	^ amountDecimals
]

{ #category : #accessing }
PharocksAssets >> amountDecimals: anObject [
	amountDecimals := anObject
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
PharocksAssets >> coin [
	^ coin
]

{ #category : #accessing }
PharocksAssets >> coin: anObject [
	coin := anObject
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
PharocksAssets >> minAmount [
	^ minAmount
]

{ #category : #accessing }
PharocksAssets >> minAmount: anObject [
	minAmount := anObject
]

{ #category : #accessing }
PharocksAssets >> minPrice [
	^ minPrice
]

{ #category : #accessing }
PharocksAssets >> minPrice: anObject [
	minPrice := anObject
]

{ #category : #accessing }
PharocksAssets >> priceDecimals [
	^ priceDecimals
]

{ #category : #accessing }
PharocksAssets >> priceDecimals: anObject [
	priceDecimals := anObject
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
