# Pharocks Cryptobot

[![Build Status](https://travis-ci.org/oliveiraallex/Pharocks-Cryptobot.svg?branch=master)](https://travis-ci.org/oliveiraallex/Pharocks-Cryptobot)


Pharocks Cryptobot is a robot app built in Pharo, for buying and selling cryptocurrency pairs, based on a loss / gain percentage strategy.

Different cryptocurrency pairs can be traded, such as Bitcoin / Tether (BTCUSDT), Ethereum / Bitcoin (ETHBTC) or Litecoin / Binancecoin (LTCBNB) for example.

To buy and sell, you need an account in an cryptocurrency exchange, for Pharocks to create buy and sell orders according to the configured strategy.

For now, it is possible to use only with Binance's cryptocurrency exchange, so an account there is mandatory. [Create your Binance account now!](https://www.binance.com/en/register?ref=35954516)

## Watch a short demonstration of Pharocks working

[![Alt text](https://img.youtube.com/vi/v5ylcKQT5Mk/0.jpg)](https://www.youtube.com/watch?v=v5ylcKQT5Mk)

## Market operation principle

There are different types of cryptocurrencies, with different projects and goals. These cryptocurrencies are traded on exchanges and the principles of buying and selling work as they do in the stock market.

Let's see what the journey is like. *Note: These are the raw calculations, with no brokerage or transfer fees.

You don't have cryptocurrencies and you need to buy them. Then you buy an amount of cryptocurrency in relation to some fiat currency (dollar, euro, etc.).

This means that you pay the market price of the currency. You can buy fractions of the currency. Bitcoin for example was costing $ 9.684,29 on the day of purchase, in this example. If you buy $ 1,000.00 in Bitcoin, you will have the equivalent of 0,10326002 bitcoins.

The market can go up or down. If BTC increase 5% for example (going up to $10.168,50), you will continue with the same 0.10326002 bitcoins, but worth $ 1,050.00. You can sell them now to someone at the exchange and withdraw your $1,050.00. You made a profit of $50.00.

If you decide not to sell your 0.10326002 bitcoins, the market may continue to rise. But it can go down too. If the market drops around 11,62% (going down to $8.986,92), your same amount of bitcoin will now be worth $927,99. You lost what you won (-$50,00) and lost part of the starting capital (-$72,01).

![image](https://user-images.githubusercontent.com/39618015/77694892-1cb5f900-6fab-11ea-8852-25a834de13c4.png)

How can you protect your cryptocurrencies from devaluation?

## Crypto trading based on a loss / gain percentage strategy

The principle of operation of this strategy is to define the selling price of your cryptocurrency.

There are two selling prices. The selling price when it reaches a profit percentage and the selling price when it reaches a loss percentage.

Applying this strategy in this example, we could define a profit selling price of 3% and a loss selling price of 1%. So there are 2 cases:

- If the market goes up 3%, your cryptocurrencies will sell for $1,030.00. That would make you a profit of $30.00.

- If the market starts to fall, they would sell for $990.00. Loss of only $10.00.

After each sale, you must buy the crypto coins again and sell at the prices you set earlier.

For each cycle in this example, you can have a loss of 1% or a profit of 3%. If the market is fluctuating a lot, you can do several of these cycles a day. The lower the percentages, the more cycles you can do. The higher the percentage the greater the profit / loss.

The question you must answer for yourself: Is it better to have several small profits a day or a larger profit at the end of the day? But remember that at the end of the day you can have only one loss as well.

You just need to be lucky to set the time to buy. But even if you don't get it right, your loss will be controlled.

## Binance OCO Orders (One Cancels the Other)

An OCO, or “One Cancels the Other” order allows you to place two orders at the same time. It combines a limit order, with a stop-limit order, but only one of the two can be executed. In other words, as soon as one of the orders get partially or fully filled, the remaining one will be canceled automatically.

When Pharocks creates a sales order, it creates an OCO order. This means that it can set the selling price in profit or loss. And the Binance exchange executes the order automatically.

Watch this video to understand better about OCO Orders. 

[![Alt text](https://img.youtube.com/vi/5YtlwWlwE5o/0.jpg)](https://www.youtube.com/watch?v=5YtlwWlwE5o)

## Pharocks operation principle

With Pharocks, you can buy and sell any amount in any cryptocurrency available on the exchange you are operating on and set any percentage of sale in profit and loss.

The Pharocks operating principle allows you to create multiple buy and sell orders at the same time, with different profit / loss strategies, with different amounts of your money.

### Wallet, assets and strategy

It works like you have a wallet. You define how many parts it will be divided into. Let's say you have $1,000.00 in your exchange account. We will divide the value within this wallet into 10 equal parts. Each of these parts are called assets. You can define a strategy for each $100.00 asset.

![image](https://user-images.githubusercontent.com/39618015/77703399-0152ea00-6fbb-11ea-837d-4fd502efbcbe.png)

In the strategy file, you define how many parts your wallet will be divided into and how many parts will be used. In this example, we divided the total portfolio value of $1,000.00 into 10 equal parts. And we will only work with 4 parties, leaving 60% of our capital secure.

![image](https://user-images.githubusercontent.com/39618015/78240657-95eba980-74df-11ea-8d97-b1ee01580aa7.png)

Every asset has the currency parity in which it is being traded, the quantity, purchase price and the sale price that will be inserted when the asset is sold. Profit and loss selling prices are also contained in each asset, as well as the percentage.

![image](https://user-images.githubusercontent.com/39618015/78240821-ccc1bf80-74df-11ea-8669-721a7b026b6f.png)

## Installing Pharocks

[Download Pharo Laucher](http://pharo.org/download), create a new Pharo 8 image and start it. Then open the playground and run this script:

```
Metacello new
  baseline: 'Pharocks';
  repository: 'github://oliveiraallex/Pharocks-Cryptobot';
  load
```

## Starting Pharocks

Setting the exchange:

```
binance := PharocksBinance new apiKey: 'abc123'; apiSecretKey: 'abc123'.
exchange := PharocksCryptocurrencyExchange exchangePlugin: binance.
```

Creating the Pharocks operator with the exchange configured:

```
cryptoRobot := PharocksOperator setExchange: exchange.
```

Appyling the strategy:
```
cryptoRobot setStrategy: PharocksStrategy simpleWinLossPercentage.
```

Syncing the wallet with the exchange and creating the assets in your wallet localy. This assests will be created again when you start Pharocks, so this is just to you check if the values and crypto pairs are according your strategy.

```
cryptoRobot walletSync.
cryptoRobot createAssets. 
```

Start Pharocks and create the buy and sell OCO orders:

```
cryptoRobot executeStrategyOnExchange. 
```


## Under construction

This project is under construction. The next steps are the price monitoring system to buy the assets using indicators (Stochastic, RSI, Bollinger Bands etc) of [Trading View](https://www.tradingview.com/chart/?symbol=BINANCE%3ABNBUSDT)

![image](https://user-images.githubusercontent.com/39618015/78253056-16b4a080-74f4-11ea-95b0-be3c6bbc4e0a.png)

## Disclamer
There is no guarantee of profit or that this application will work without fail. Only you are responsible for using this program. Any loss generated by any application failure is your sole responsibility.
