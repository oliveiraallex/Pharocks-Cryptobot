Class {
	#name : #PharocksQueriesMercadoBitcoin,
	#superclass : #PharocksExchange,
	#category : #'Pharocks-Cryptobot-Exchanges'
}

{ #category : #accessing }
PharocksQueriesMercadoBitcoin >> configuration [
	website := 'https://www.mercadobitcoin.com.br'.
	apiUrl := 'https://www.mercadobitcoin.net/api'


]

{ #category : #initialization }
PharocksQueriesMercadoBitcoin >> initialize [
	self configuration
]

{ #category : #accessing }
PharocksQueriesMercadoBitcoin >> queryOrderBook: aString [ 
	^ self
		get: self apiUrl , '/',aString asString,'/ticker/'
]
