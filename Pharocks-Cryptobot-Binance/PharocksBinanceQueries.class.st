Class {
	#name : #PharocksBinanceQueries,
	#superclass : #PharocksBinanceExchange,
	#instVars : [
		'query'
	],
	#category : #'Pharocks-Cryptobot-Binance'
}

{ #category : #controling }
PharocksBinanceQueries >> get: aUri [
	^ query get: (self website),'/wapi/v3/systemStatus.html'
]

{ #category : #controling }
PharocksBinanceQueries >> initialize [
	super initialize.
	query := PharocksCommunicator new
]

{ #category : #controling }
PharocksBinanceQueries >> querySystemStatus [
	^ self get: '/wapi/v3/systemStatus.html'
]
