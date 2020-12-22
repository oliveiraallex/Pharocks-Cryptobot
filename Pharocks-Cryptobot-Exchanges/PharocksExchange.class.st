Class {
	#name : #PharocksExchange,
	#superclass : #Object,
	#instVars : [
		'apiKey',
		'apiSecretKey',
		'website',
		'apiUrl',
		'apiUrlSecondary'
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
	| webClient queryString signature delete | 
	aDictionary at: 'timestamp' put: self timestamp.
	queryString := self getQueryAsString: aDictionary.
	signature := self signQuery: queryString.
	webClient := ZnClient new
		url: path;
		headerAddAll: {('X-MBX-APIKEY' -> apiKey)} asDictionary;
		queryAddAll: aDictionary;
		queryAddAll: {(#signature -> signature)} asDictionary.
	PharocksLog logAdd: 'DELETE ',path,queryString.
	delete := [NeoJSONReader fromString: webClient delete] ifError: [ :error | PharocksLog logAdd: 'ERROR ', error asString ].
	^ delete
]

{ #category : #accessing }
PharocksExchange >> get: path [
	^ self get: path parameters: {} asDictionary
]

{ #category : #accessing }
PharocksExchange >> get: path parameters: aDictionary [
	| webClient get | 
	webClient := ZnClient new. 
	webClient url: path.
	webClient queryAddAll: aDictionary.
	get := [NeoJSONReader fromString: webClient get asString] ifError: [ :error | PharocksLog logAdd: 'ERROR ', error asString ].
	^ get
]

{ #category : #accessing }
PharocksExchange >> getPrivate: path [
	^ self getPrivate: path parameters: {} asDictionary
]

{ #category : #accessing }
PharocksExchange >> getPrivate: path parameters: aDictionary [
	| webClient queryString signature get |
	aDictionary at: 'timestamp' put: self timestamp.
	queryString := self getQueryAsString: aDictionary.
	signature := self signQuery: queryString.
	webClient := ZnClient new
		url: path;
		headerAddAll: {('X-MBX-APIKEY' -> apiKey)} asDictionary;
		queryAddAll: aDictionary;
		queryAddAll: {(#signature -> signature)} asDictionary.
	PharocksLog logAdd: 'GET ',path,queryString.
	get := [NeoJSONReader fromString: webClient get] ifError: [ :error | PharocksLog logAdd: 'ERROR ', error asString ].
	^ get
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
]

{ #category : #accessing }
PharocksExchange >> postPrivate: path parameters: aDictionary [
	| webClient queryString signature post | 
	aDictionary at: 'timestamp' put: self timestamp.
	queryString := self getQueryAsString: aDictionary.
	signature := self signQuery: queryString.
	webClient := ZnClient new
		url: path;
		headerAddAll: {('X-MBX-APIKEY' -> apiKey)} asDictionary;
		queryAddAll: aDictionary;
		queryAddAll: {(#signature -> signature)} asDictionary.
	PharocksLog logAdd: 'POST ',path,queryString. 
	post := [NeoJSONReader fromString: webClient post] ifError: [ :error | PharocksLog logAdd: 'ERROR ', error asString ].
	^ post
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
	"^ DateAndTime totalSeconds * 1000"
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
