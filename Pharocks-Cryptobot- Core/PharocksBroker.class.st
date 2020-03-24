Class {
	#name : #PharocksBroker,
	#superclass : #Object,
	#instVars : [
		'wallet',
		'strategy'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #control }
PharocksBroker >> applyStrategy [
	wallet strategy: strategy.
	wallet createAssets
]

{ #category : #accessing }
PharocksBroker >> configuration [

	
]

{ #category : #initialization }
PharocksBroker >> initialize [

	wallet := PharocksWallet new.
	"check the amount of USDT in Binance and set it in" "amountTotal := walletSync"
	"amountTotal := wallet walletSync."
	
	
	""
]

{ #category : #initialization }
PharocksBroker >> runRoundMaxTime: aNumberOfMinutes [
]

{ #category : #accessing }
PharocksBroker >> setWalletExchange: anObject [
	wallet exchange: anObject
]

{ #category : #accessing }
PharocksBroker >> strategy [
	^ strategy
]

{ #category : #accessing }
PharocksBroker >> strategy: anObject [
	strategy := anObject 
]

{ #category : #accessing }
PharocksBroker >> wallet [
	^ wallet
]

{ #category : #accessing }
PharocksBroker >> wallet: anObject [
	wallet := anObject
]
