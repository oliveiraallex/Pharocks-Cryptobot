Class {
	#name : #PharocksBinanceExchange,
	#superclass : #Object,
	#instVars : [
		'apiKey',
		'apiSecretKey',
		'website',
		'apiUrl'
	],
	#category : #'Pharocks-Cryptobot-Binance'
}

{ #category : #accessing }
PharocksBinanceExchange >> apiKey [
	^ apiKey
]

{ #category : #accessing }
PharocksBinanceExchange >> apiKey: aString [
	apiKey := aString
]

{ #category : #accessing }
PharocksBinanceExchange >> apiSecretKey [
	^ apiSecretKey
]

{ #category : #accessing }
PharocksBinanceExchange >> apiSecretKey: aString [
	apiSecretKey := aString
]

{ #category : #accessing }
PharocksBinanceExchange >> apiUrl [
	^ apiUrl
]

{ #category : #accessing }
PharocksBinanceExchange >> apiUrl: anObject [
	apiUrl := anObject
]

{ #category : #accessing }
PharocksBinanceExchange >> configuration [
	website := 'https://www.binance.com'.
	apiUrl := 'https://api.binance.com'
]

{ #category : #accessing }
PharocksBinanceExchange >> get: path [
	^ self get: path parameters: {} asDictionary
]

{ #category : #accessing }
PharocksBinanceExchange >> get: path parameters: aDictionary [
	| webClient | 
	webClient := ZnClient new. 
	webClient url: path.
	webClient queryAddAll: aDictionary.
	^ NeoJSONReader fromString: webClient get. 
]

{ #category : #accessing }
PharocksBinanceExchange >> getPrivate: path [
	^ self getPrivate: path parameters: {} asDictionary
]

{ #category : #accessing }
PharocksBinanceExchange >> getPrivate: path parameters: aDictionary [
	| webClient queryString signature |
	aDictionary at: 'timestamp' put: self timestamp.
	queryString := self getQueryAsString: aDictionary.
	signature := self signQuery: queryString.
	webClient := ZnClient new
		url: path;
		headerAddAll: {('X-MBX-APIKEY' -> apiKey)} asDictionary;
		queryAddAll: aDictionary;
		queryAddAll: {(#signature -> signature)} asDictionary.
	^ NeoJSONReader fromString: webClient get
]

{ #category : #accessing }
PharocksBinanceExchange >> getQueryAsString: aDictionary [ 
	| webClient requestLine |
	webClient := ZnClient new queryAddAll: aDictionary.
	requestLine := webClient request requestLine uri asString .
	^ requestLine copyReplaceAll: '/?'  with: ''
	
]

{ #category : #initialization }
PharocksBinanceExchange >> initialize [
	self configuration .
	
	"runQuery := PharocksBinanceOperations new."
]

{ #category : #accessing }
PharocksBinanceExchange >> signQuery: aString [
	| signature |
	signature := (HMAC on: SHA256)
		key: apiSecretKey asByteArray;
		digestMessage: aString asByteArray.
	^ signature hex
]

{ #category : #accessing }
PharocksBinanceExchange >> timestamp [
	^ self subclassResponsibility 
]

{ #category : #accessing }
PharocksBinanceExchange >> website [
	^ website
]

{ #category : #accessing }
PharocksBinanceExchange >> website: anObject [
	website := anObject
]
