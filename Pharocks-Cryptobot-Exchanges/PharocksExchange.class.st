Class {
	#name : #PharocksExchange,
	#superclass : #Object,
	#instVars : [
		'apiKey',
		'apiSecretKey',
		'website',
		'apiUrl',
		'apiUrlSecondary',
		'result'
	],
	#category : #'Pharocks-Cryptobot-Exchanges'
}

{ #category : #accessing }
PharocksExchange >> apiKey [
	^ apiKey
]

{ #category : #accessing }
PharocksExchange >> apiKey: aString [
	apiKey := aString
]

{ #category : #accessing }
PharocksExchange >> apiSecretKey [
	^ apiSecretKey
]

{ #category : #accessing }
PharocksExchange >> apiSecretKey: aString [
	apiSecretKey := aString
]

{ #category : #accessing }
PharocksExchange >> apiUrl [
	^ apiUrl
]

{ #category : #accessing }
PharocksExchange >> apiUrl: anObject [
	apiUrl := anObject
]

{ #category : #accessing }
PharocksExchange >> apiUrlSecondary [

	^ apiUrlSecondary
]

{ #category : #accessing }
PharocksExchange >> apiUrlSecondary: anObject [

	apiUrlSecondary := anObject
]

{ #category : #accessing }
PharocksExchange >> deletePrivate: path parameters: aDictionary [
	| webClient queryString signature answer| 
	aDictionary at: 'timestamp' put: self timestamp.
	queryString := self getQueryAsString: aDictionary.
	signature := self signQuery: queryString.
	webClient := ZnClient new
		url: path;
		headerAddAll: {('X-MBX-APIKEY' -> apiKey)} asDictionary;
		queryAddAll: aDictionary;
		queryAddAll: {(#signature -> signature)} asDictionary.
	PharocksLog logAdd: 'DELETE ',path,queryString.
	answer := NeoJSONReader fromString: webClient delete.
	result at: Time current put: answer.
	^ answer
]

{ #category : #accessing }
PharocksExchange >> get: path [
	^ self get: path parameters: {} asDictionary
]

{ #category : #accessing }
PharocksExchange >> get: path parameters: aDictionary [
	| webClient | 
	webClient := ZnClient new. 
	webClient url: path.
	webClient queryAddAll: aDictionary.
	^ NeoJSONReader fromString: webClient get asString. 
]

{ #category : #accessing }
PharocksExchange >> getPrivate: path [
	^ self getPrivate: path parameters: {} asDictionary
]

{ #category : #accessing }
PharocksExchange >> getPrivate: path parameters: aDictionary [
	| webClient queryString signature answer|
	aDictionary at: 'timestamp' put: self timestamp.
	queryString := self getQueryAsString: aDictionary.
	signature := self signQuery: queryString.
	webClient := ZnClient new
		url: path;
		headerAddAll: {('X-MBX-APIKEY' -> apiKey)} asDictionary;
		queryAddAll: aDictionary;
		queryAddAll: {(#signature -> signature)} asDictionary.
	PharocksLog logAdd: 'GET ',path,queryString.
	answer := NeoJSONReader fromString: webClient get.
	result at: Time current put: answer.
	^ answer
]

{ #category : #accessing }
PharocksExchange >> getQueryAsString: aDictionary [ 
	| webClient requestLine |
	webClient := ZnClient new queryAddAll: aDictionary.
	requestLine := webClient request requestLine uri asString .
	^ requestLine copyReplaceAll: '/?'  with: ''
	
]

{ #category : #initialization }
PharocksExchange >> initialize [
	"self configuration."
	result := Dictionary new.
	"runQuery := PharocksBinanceOperations new."
]

{ #category : #accessing }
PharocksExchange >> postPrivate: path parameters: aDictionary [
	| webClient queryString signature answer| 
	aDictionary at: 'timestamp' put: self timestamp.
	queryString := self getQueryAsString: aDictionary.
	signature := self signQuery: queryString.
	webClient := ZnClient new
		url: path;
		headerAddAll: {('X-MBX-APIKEY' -> apiKey)} asDictionary;
		queryAddAll: aDictionary;
		queryAddAll: {(#signature -> signature)} asDictionary.
	PharocksLog logAdd: 'POST ',path,queryString.
	answer := NeoJSONReader fromString: webClient post.
	result at: Time current put: answer.
	^ answer
]

{ #category : #accessing }
PharocksExchange >> signQuery: aString [
	| signature |
	signature := (HMAC on: SHA256)
		key: apiSecretKey asByteArray;
		digestMessage: aString asByteArray.
	^ signature hex
]

{ #category : #accessing }
PharocksExchange >> timestamp [
	^ self subclassResponsibility 
]

{ #category : #accessing }
PharocksExchange >> website [
	^ website
]

{ #category : #accessing }
PharocksExchange >> website: anObject [
	website := anObject
]
