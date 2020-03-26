Class {
	#name : #PharocksBinanceQuerySubscriber,
	#superclass : #PharocksBinanceExchange,
	#instVars : [
		'querySigned'
	],
	#category : #'Pharocks-Cryptobot-Binance'
}

{ #category : #initialization }
PharocksBinanceQuerySubscriber >> initialize [
	super initialize.
	querySigned := PharocksCommunicator new
]
