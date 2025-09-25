# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

step1と同じになった。
```ruby
# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
    prices_size = prices.size
    return 0 if prices_size <= 1

    min_price = prices.first
    max_profit = 0
    (1...(prices_size)).each do |i|
        price = prices[i]
        max_profit = [max_profit, price - min_price].max
        min_price = [min_price, price].min
    end
    max_profit
end
```
