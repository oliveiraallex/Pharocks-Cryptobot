Class {
	#name : #PharocksQueriesBitPreco,
	#superclass : #PharocksExchange,
	#category : #'Pharocks-Cryptobot-Exchanges'
}

{ #category : #accessing }
PharocksQueriesBitPreco >> configuration [
	website := 'https://bitpreco.com/'.
	apiUrl := 'https://api.bitpreco.com'


]

{ #category : #initialization }
PharocksQueriesBitPreco >> initialize [
	self configuration
]

{ #category : #accessing }
PharocksQueriesBitPreco >> queryOrderBook: aString [ 
	^ self
		get: self apiUrl , '/',aString asString,'/orderbook'
]
