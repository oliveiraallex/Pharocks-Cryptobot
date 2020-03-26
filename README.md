# Pharocks Cryptobot

Pharocks Cryptobot is a robot app for buying and selling cryptocurrency pairs, based on a loss / gain percentage strategy.

Different cryptocurrency pairs can be traded, such as Bitcoin / Tether (BTCUSDT), Bitcoin / Ethereum (BTCETH) or Binancecoin / Litecoin (BNBLTC).

To buy and sell, you need an account in an cryptocurrency exchange, for Pharocks to create buy and sell orders according to the configured strategy.

For now, it is possible to use only with Binance's cryptocurrency exchange https://www.binance.com/, so an account there is mandatory.

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

## Pharocks operation principle

With Pharocks, you can buy and sell any amount in any cryptocurrency available on the exchange you are operating on and set any percentage of sale in profit and loss.

The Pharocks operating principle allows you to create multiple buy and sell orders at the same time, with different profit / loss strategies, with different amounts of your money.

### Wallet, assets and strategy

It works like you have a wallet. You define how many parts it will be divided into. Let's say you have $1,000.00 in your exchange account. We will divide the value within this wallet into 10 equal parts. Each of these parts are called assets. You can define a strategy for each $100.00 asset.

![image](https://user-images.githubusercontent.com/39618015/77703399-0152ea00-6fbb-11ea-837d-4fd502efbcbe.png)

In the strategy file, you define how many parts your wallet will be divided into and how many parts will be used. In this example, we divided the total portfolio value of $1,000.00 into 10 equal parts. And we will only work with 4 parties, leaving 60% of our capital secure.

![image](https://user-images.githubusercontent.com/39618015/77704479-71fb0600-6fbd-11ea-8af4-f3dcb8ad403c.png)

Every asset has the currency parity in which it is being traded, the quantity, purchase price and the sale price that will be inserted when the asset is sold. Profit and loss selling prices are also contained in each asset, as well as the percentage.

![image](https://user-images.githubusercontent.com/39618015/77704355-2f392e00-6fbd-11ea-8b41-258294edd4d6.png)

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

Syncing the wallet with the exchange and creating the assets in your wallet localy:

```
cryptoRobot walletSync.
cryptoRobot createAssets. 
```

## Under construction

This project is under construction and is not yet functional. The next steps are effective communication with the exchange and the price monitoring system to buy and sell the assets.

## Disclamer
There is no guarantee of profit or that this application will work without fail. Only you are responsible for using this program. Any loss generated by any application failure is your sole responsibility.
