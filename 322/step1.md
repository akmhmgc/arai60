# step1 何も見ずに解く

合計がある金額になるコインの最小枚数は、合計が「ある金額 - コイン」になるコインの最小枚数 + 1が候補になり得る。
0円からスタートして合計を大きくしていき上の考えを適用すれば良い。

合計金額をN、コインの枚数をMとすると時間計算量はO(MN)
空間計算量はO(N)
M,Nはそれぞれ10^4, 12が最大値なので1秒以内に計算が終わる。
not_existedという変数名が怪しいけど他に思いつかなかった。合計金額を表すことができないという意味にしたい

```ruby
# @param {Integer[]} coins
# @param {Integer} amount
# @return {Integer}
def coin_change(coins, amount)
    not_existed = -1
    fewest_num_coins = Array.new(amount + 1, Float::INFINITY)
    fewest_num_coins[0] = 0
    1.upto(amount).each do |sub_amount|
        coins.each do |coin|
            next if sub_amount - coin < 0
            fewest_num_coins[sub_amount] = [fewest_num_coins[sub_amount - coin] + 1, fewest_num_coins[sub_amount]].min
        end
    end
    fewest_num_coins[amount] == Float::INFINITY ? not_existed : fewest_num_coins[amount]
end
```

あとは合計に達するまでの最短距離なのでBFSも良さそう。

```ruby
# @param {Integer[]} coins
# @param {Integer} amount
# @return {Integer}
def coin_change(coins, amount)
    return 0 if amount.zero?

    not_existed = -1
    num_coins_and_rest_amount = [[0, amount]]
    seen_amounts = Set.new
    seen_amounts << amount
    while !num_coins_and_rest_amount.empty?
        next_num_coins_and_rest_amount = []
        num_coins_and_rest_amount.each do |num_coins, rest_amount|
            coins.each do |coin|
                new_rest_amount = rest_amount - coin
                next if new_rest_amount < 0
                next if seen_amounts.include?(new_rest_amount)
                return num_coins + 1 if new_rest_amount == 0
                seen_amounts << new_rest_amount
                next_num_coins_and_rest_amount << [num_coins + 1, new_rest_amount]
            end
        end
        num_coins_and_rest_amount = next_num_coins_and_rest_amount
    end
    not_existed
end
```
