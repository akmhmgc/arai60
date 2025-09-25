# step1 何も見ずに解く

簡単な例で確認した。
ある時点を考えると、一つ前の値段が安い時はその時に買って、ある時点で売れば良いだけであることに気づいた。
時間計算量はO(N)で空間計算量はO(1)

```ruby
# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
    prices_size = prices.size
    return 0 if prices_size <= 1

    max_profit = 0
    buy_price = prices.first
    prices.each do |sell_price|
        if sell_price > buy_price
            max_profit += sell_price - buy_price
        end
        buy_price = sell_price
    end
    max_profit
end
```

もう少し見やすくできる。

```ruby
# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
    max_profit = 0
    prices.each_cons(2) do |prev_price, current_price|
        next unless current_price > prev_price
        max_profit += current_price - prev_price
    end
    max_profit
end
```

これもRubyっぽくてありかもしれない。
```ruby
# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
    prices.each_cons(2).map { |prev_price, current_price| [0, current_price - prev_price].max }.inject(:+) || 0
end
```
