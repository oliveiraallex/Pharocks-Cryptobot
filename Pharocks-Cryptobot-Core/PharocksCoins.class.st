Class {
	#name : #PharocksCoins,
	#superclass : #Object,
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #'as yet unclassified' }
PharocksCoins class >> floatCounter: aFloat [
	| n quantity |
	n := aFloat.
	quantity := 0.
	[ n = 1 ] 	whileFalse: [ n := n * 10. quantity := quantity + 1 ].
	^ quantity
]

{ #category : #'as yet unclassified' }
PharocksCoins class >> pair: aString [
	| pair |
	pair := Dictionary new.
	pair at: 'BTCUSDT' put:({('minAmount' -> 0.000001).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'ETHUSDT' put:({('minAmount' -> 0.00001).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'BNBUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'NEOUSDT' put:({('minAmount' -> 0.001).('minPrice' -> 0.001).('minOrder' -> 10)} asDictionary).
	pair at: 'LTCUSDT' put:({('minAmount' -> 0.00001).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'QTUUSDT' put:({('minAmount' -> 0.001).('minPrice' -> 0.001).('minOrder' -> 10)} asDictionary).
	pair at: 'ADAUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'XRPUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'EOSUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'TUSUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'IOTUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'XLMUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'ONTUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'TRXUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'ETCUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'ICXUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'NULUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'VETUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'PAXUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'USDUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'LINUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'WAVUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'BTTUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.0000001).('minOrder' -> 10)} asDictionary).
	pair at: 'ONGUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'HOTUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.0000001).('minOrder' -> 10)} asDictionary).
	pair at: 'ZILUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'ZRXUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'FETUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'BATUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'XMRUSDT' put:({('minAmount' -> 0.00001).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'ZECUSDT' put:({('minAmount' -> 0.00001).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'IOSUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'CELUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'DASUSDT' put:({('minAmount' -> 0.00001).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'NANUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'OMGUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'THEUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'ENJUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'MITUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'MATUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'ATOUSDT' put:({('minAmount' -> 0.001).('minPrice' -> 0.001).('minOrder' -> 10)} asDictionary).
	pair at: 'TFUUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'ONEUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'FTMUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'ALGUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'GTOUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'ERDUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'DOGUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.0000001).('minOrder' -> 10)} asDictionary).
	pair at: 'DUSUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'ANKUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'WINUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.0000001).('minOrder' -> 10)} asDictionary).
	pair at: 'COSUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'NPXUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.0000001).('minOrder' -> 10)} asDictionary).
	pair at: 'COCUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'MTLUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'TOMUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'PERUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'DENUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.0000001).('minOrder' -> 10)} asDictionary).
	pair at: 'MFTUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'KEYUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'DOCUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'WANUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'FUNUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'CVCUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'CHZUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'BANUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'BUSUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'BEAUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'XTZUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'RENUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'RVNUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'HC/USDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'HBAUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'NKNUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'STXUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'KAVUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'ARPUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'IOTUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'RLCUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'MCOUSDT' put:({('minAmount' -> 0.001).('minPrice' -> 0.001).('minOrder' -> 10)} asDictionary).
	pair at: 'CTXUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'BCHUSDT' put:({('minAmount' -> 0.00001).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'TROUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.0000001).('minOrder' -> 10)} asDictionary).
	pair at: 'VITUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'FTTUSDT' put:({('minAmount' -> 0.001).('minPrice' -> 0.001).('minOrder' -> 10)} asDictionary).
	pair at: 'EURUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'OGNUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'DREUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'TCTUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'WRXUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'BTSUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'LSKUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'BNTUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'LTOUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'STRUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'AIOUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'MBLUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'COTUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'STPUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'WTCUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'DATUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'XZCUSDT' put:({('minAmount' -> 0.001).('minPrice' -> 0.001).('minOrder' -> 10)} asDictionary).
	pair at: 'CTSUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'HIVUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'CHRUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'GXSUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'ARDUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'LENUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'MDTUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'STMUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'KNCUSDT' put:({('minAmount' -> 0.001).('minPrice' -> 0.001).('minOrder' -> 10)} asDictionary).
	pair at: 'REPUSDT' put:({('minAmount' -> 0.001).('minPrice' -> 0.001).('minOrder' -> 10)} asDictionary).
	pair at: 'LRCUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'PNTUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'COMUSDT' put:({('minAmount' -> 0.00001).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'BKRUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.0000001).('minOrder' -> 10)} asDictionary).
	pair at: 'SC/USDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'ZENUSDT' put:({('minAmount' -> 0.001).('minPrice' -> 0.001).('minOrder' -> 10)} asDictionary).
	pair at: 'SNXUSDT' put:({('minAmount' -> 0.001).('minPrice' -> 0.001).('minOrder' -> 10)} asDictionary).
	pair at: 'ETHUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'ETHUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'ADAUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'ADAUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'LINUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'LINUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'VTHUSDT' put:({('minAmount' -> 1).('minPrice' -> 0.000001).('minOrder' -> 10)} asDictionary).
	pair at: 'DGBUSDT' put:({('minAmount' -> 0.1).('minPrice' -> 0.00001).('minOrder' -> 10)} asDictionary).
	pair at: 'GBPUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'SXPUSDT' put:({('minAmount' -> 0.001).('minPrice' -> 0.001).('minOrder' -> 10)} asDictionary).
	pair at: 'MKRUSDT' put:({('minAmount' -> 0.00001).('minPrice' -> 0.01).('minOrder' -> 10)} asDictionary).
	pair at: 'DAIUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	pair at: 'DCRUSDT' put:({('minAmount' -> 0.001).('minPrice' -> 0.001).('minOrder' -> 10)} asDictionary).
	pair at: 'STOUSDT' put:({('minAmount' -> 0.01).('minPrice' -> 0.0001).('minOrder' -> 10)} asDictionary).
	
	^ pair at: aString
]

{ #category : #'as yet unclassified' }
PharocksCoins class >> rules: string [
	| rules amountDecimals priceDecimals  |
	rules := self pair: string.
	amountDecimals := self floatCounter: (rules at: 'minAmount').
	priceDecimals := self floatCounter: (rules at: 'minPrice').
	rules at: 'amountDecimals' put: amountDecimals.
	rules at: 'priceDecimals' put: priceDecimals.
	^ rules
]
