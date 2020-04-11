"
Webserver used to set the indicators. 

The URL will be acessed from Trading View from Alarm Indicators to inform the Pharocks how is the market. 

http://serverIP:8080/setStochRSIUp20

setStochRSIUp20
setStochRSIUp80
setStochRSIDown20
setStochRSIDOwn80
"
Class {
	#name : #PharocksServer,
	#superclass : #Object,
	#instVars : [
		'znServer',
		'pharocks'
	],
	#category : #'Pharocks-Cryptobot-Server'
}

{ #category : #initialization }
PharocksServer >> initialize [
	| delegate |
	delegate := PharocksDelegate new.
	delegate pharocks: PharocksOperator. 
	znServer := ZnSingleThreadedServer defaultOn: 80.
	znServer delegate: delegate.
	
]

{ #category : #initialization }
PharocksServer >> start [
	znServer start
]

{ #category : #initialization }
PharocksServer >> stop [
	znServer stop
]
