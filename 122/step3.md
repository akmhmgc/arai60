# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

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
