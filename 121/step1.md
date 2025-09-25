# step1 何も見ずに解く

ある日に売る時に得られる最大の利益は、「ある日での売り値 - ある日以前での最安値」で求めることができる。
ある日以前の最安値と、最大の利益を変数で更新していけば時間計算量O(N)となり、Nの最大値は10^5なので1秒以内に間に合う。
空間計算量はO(1)

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

