# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

結局step1のDPになった。

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
