Class {
	#name : #PharocksArbitrage,
	#superclass : #PharocksBroker,
	#instVars : [
		'arbitrage'
	],
	#category : #'Pharocks-Cryptobot-Core'
}

{ #category : #checking }
PharocksArbitrage >> check [

| binance y a j queries b k c l d m webClient e page f date |
arbitrage := [ 
binance := PharocksBinance new apiKey: 'xxx'; apiSecretKey: 'xxx'.
exchange := PharocksCryptocurrencyExchange exchangePlugin: binance.
date := Date current yyyymmdd asString , ' ', Time current asString.


y := OrderedCollection new.
a := OrderedCollection new.
j := OrderedCollection new.
queries := PharocksQueriesMercadoBitcoin new.
Transcript cr;cr;show: 'Comunicating with Mercado Bitcoin';cr.
y add: 'BTC'; add: 'ETH'; add: 'XRP'; add: 'BCH'; add: 'LTC'; add: 'USDC' ; add: 'USDC'.
y do: [ :s | a add: (((((queries queryOrderBook: s) at: 'ticker' at: 'buy')asNumber round:2) asString) copyReplaceAll: '.' with: ',' )] .
a at:6 put: '0'.
y do: [ :s | j add: (((((queries queryOrderBook: s) at: 'ticker' at: 'sell')asNumber round:2) asString) copyReplaceAll: '.' with: ',' )] .
j at:6 put: '0'.
"Transcript cr."

y := OrderedCollection new.
b := OrderedCollection new.
k := OrderedCollection new.
queries := PharocksQueriesBitPreco new.
Transcript show: 'Comunicating with Bit Preço';cr.
y add: 'btc-brl'; add: 'eth-brl'.
y do: [ :s | b add: (((((queries queryOrderBook: s)at: 'bids'at:1) at: 'price') asString) 
copyReplaceAll: '.' with: ',' )] .
b add: '0' ; add: '0'; add: '0'; add: '0'; add: '0'.
y do: [ :s | k add: (((((queries queryOrderBook: s)at: 'asks'at:1) at: 'price') asString) 
copyReplaceAll: '.' with: ',' )] .
k add: '0' ; add: '0'; add: '0'; add: '0'; add: '0'.
"Transcript cr."

y := OrderedCollection new.
c := OrderedCollection new.
l := OrderedCollection new.
queries := PharocksQueriesBraziliex new.
Transcript show: 'Comunicating with Braziliex';cr.
y add: 'btc_brl'; add: 'eth_brl'; add: 'xrp_brl'; add: 'bch_brl'; add: 'ltc_brl'; add: 'usdt_brl'; add: 'usdt_brl'.
y do: [ :s | c add: (((((queries queryOrderBook: s)at: 'bids'at:1) at: 'price') asString) 
copyReplaceAll: '.' with: ',' )] .
c at:6 put: '0'.
y do: [ :s | l add: (((((queries queryOrderBook: s)at: 'asks'at:1) at: 'price') asString) 
copyReplaceAll: '.' with: ',' )] .
l at:6 put: '0'.
"Transcript cr."

y := OrderedCollection new.
d := OrderedCollection new.
m := OrderedCollection new.
Transcript show: 'Comunicating with Binance';cr.
y add: 'BTCUSDT'; add: 'ETHUSDT'; add: 'XRPUSDT'; add: 'BCHUSDT'; add: 'LTCUSDT'; add: 'DOGEUSDT'.
y do: [ :s | d add: ((exchange symbolLatestPrice: s)asString copyReplaceAll: '.' with: ',' )] .
d add: '1'.
"Transcript cr."


webClient := ZnClient new. 
e := OrderedCollection new.
Transcript show: 'Comunicating with Belgacoin';cr.
webClient url: 'https://www.belgacoin.com/index.jsp'.
page := (webClient get) findTokens: '<b>'.
e add: ((( page at: 193 )copyReplaceAll: ' EUR = 1 BTC' with: '') 
copyReplaceAll: '.' with: ',' ).
e add: ((( page at: 198 )copyReplaceAll: ' EUR = 1 ETH' with: '') 
copyReplaceAll: '.' with: ',' ).
e add: ((( page at: 203 )copyReplaceAll: ' EUR = 1 XRP' with: '') 
copyReplaceAll: '.' with: ',' ).
e add: ((( page at: 208 )copyReplaceAll: ' EUR = 1 BCH' with: '') 
copyReplaceAll: '.' with: ',' ).
e add: ((( page at: 213 )copyReplaceAll: ' EUR = 1 LTC' with: '') 
copyReplaceAll: '.' with: ',' ).
e add: ((( page at: 218 )copyReplaceAll: ' EUR = 1 DOGE' with: '') 
copyReplaceAll: '.' with: ',' ).
e add: '0'.

webClient := ZnClient new. 
f := OrderedCollection new.
Transcript show: 'Comunicating with Melhor Cambio';cr;cr;cr.
webClient url: 'https://www.melhorcambio.com/euro-hoje'.
page := (webClient get) findBetweenSubstrings: {'class="tdvalor">'.'</td>'}.
f add: (( page at: 12 )copyReplaceAll: 'R$' with: '').
webClient url: 'https://www.melhorcambio.com/dolar-hoje'.
page := (webClient get) findBetweenSubstrings: {'class="tdvalor">'.'</td>'}.
f add: (( page at: 12 )copyReplaceAll: 'R$' with: '').

Transcript cr.
1 to: 7 do: [ :i | Transcript show: 
	(a at: i); tab ; show: (j at: i); tab ; show:(b at: i); tab; show: (k at: i);tab ;show:(c at: i) ; tab;show:(l at: i) ; tab; show:(d at: i);tab;show:(d at: i);tab; show:(e at: i);tab; show:(e at: i);cr].
Transcript show: (f at: 1); tab;show:(f at: 2); tab; show: date ; tab; cr.
]  forkNamed: 'Pharocks Arbritage'
]
