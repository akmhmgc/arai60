# step2 他の方の解答を見る
## 最小売買回数
https://github.com/Yoshiki-Iwasa/Arai60/pull/53#discussion_r1730194725

up trendが終わったタイミングで売買を行えば良いので、以下のような感じで出せる。

```ruby
# @param {Integer[]} prices
# @return {Integer}
def min_trading_count(prices)
    min_trading_count = 0
    is_up_trend = false
    prices.each_cons(2) do |prev_price, current_price|
        min_trading_count += 1 if is_up_trend && current_price < prev_price
        is_up_trend = current_price > prev_price
    end
    min_trading_count
end
```
