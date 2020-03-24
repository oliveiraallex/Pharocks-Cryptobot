Class {
	#name : #PharocksWalletTest,
	#superclass : #TestCase,
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #running }
PharocksWalletTest >> testWalletAtCreationIsZero [
	| w |
	w := PharocksWallet new.
	self assert: w amountTotal = 0
]
