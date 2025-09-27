# step2 他の方の解答を見る
## DFSの枝刈り
https://github.com/nittoco/leetcode/pull/38#discussion_r1845464140

```ruby
# @param {Integer[]} coins
# @param {Integer} amount
# @return {Integer}
def coin_change(coins, amount)
    return 0 if amount.zero?

    not_existed = -1
    num_coins_and_sub_amount = [[0, 0]]
    min_num_coins = Array.new(amount + 1, not_existed)
    seen_amounts = Array.new(amount + 1, false)
    while !num_coins_and_sub_amount.empty?
        num_coins, sub_amount = num_coins_and_sub_amount.pop
        next if sub_amount > amount
        next if seen_amounts[sub_amount] && num_coins > min_num_coins[sub_amount]
        min_num_coins[sub_amount] = num_coins
        seen_amounts[sub_amount] = true
        coins.each do |coin|
            num_coins_and_sub_amount << [num_coins + 1, sub_amount + coin]
        end
    end
    min_num_coins[amount]
end
```

```ruby
        next if seen_amounts[sub_amount] && num_coins > min_num_coins[sub_amount]
```
だと、同じ枚数で実現できる合計金額はスキップせずに探索を続けるので、
例えばcoins = [1, 2]とした時に
2 1 1
1 2 1
1 1 2
の順番の探索を打ち切らず組み合わせが2^nで増える

```ruby
        next if seen_amounts[sub_amount] && num_coins >= min_num_coins[sub_amount]
```

こうすれば　
2 1 1
の探索が終わった後に1 2 1の探索は打ち切られるので間に合う。


