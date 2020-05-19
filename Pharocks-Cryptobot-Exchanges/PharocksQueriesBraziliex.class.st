Class {
	#name : #PharocksQueriesBraziliex,
	#superclass : #PharocksExchange,
	#category : #'Pharocks-Cryptobot-Exchanges'
}

{ #category : #accessing }
PharocksQueriesBraziliex >> configuration [
	website := 'https://braziliex.com'.
	apiUrl := 'https://braziliex.com/api/v1'


]

{ #category : #accessing }
PharocksQueriesBraziliex >> initialize [
	self configuration
]

{ #category : #accessing }
PharocksQueriesBraziliex >> queryOrderBook: aString [ 
	^ self
		get: self apiUrl , '/public/orderbook/', aString asString 
]
