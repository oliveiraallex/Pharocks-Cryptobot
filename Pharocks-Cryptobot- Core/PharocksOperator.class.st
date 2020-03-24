Class {
	#name : #PharocksOperator,
	#superclass : #Object,
	#instVars : [
		'broker'
	],
	#category : #'Pharocks-Cryptobot- Core'
}

{ #category : #accessing }
PharocksOperator class >> setExchange: anObject [
	| broker |
	broker := PharocksBroker new.
	broker setWalletExchange: anObject.
	^ self new broker: broker
]

{ #category : #accessing }
PharocksOperator >> applyStrategy [
	broker applyStrategy
]

{ #category : #accessing }
PharocksOperator >> broker [
	^ broker
]

{ #category : #accessing }
PharocksOperator >> broker: anObject [
	broker := anObject
]

{ #category : #accessing }
PharocksOperator >> initialize [
	
	
]

{ #category : #accessing }
PharocksOperator >> setStrategy: anObject [
	broker 
]

{ #category : #accessing }
PharocksOperator >> start [ 

	"exchange ifNil: [ (Object new) error: 'Set the Exchange before start the aplication' ]"
	

]

{ #category : #accessing }
PharocksOperator >> strategy: anObject [  
	broker strategy: anObject 

]
