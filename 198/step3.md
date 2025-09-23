# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[]} moneys
# @return {Integer}
def rob(moneys)
    moneys_size = moneys.size
    return 0 if moneys_size.zero?
    return moneys[0] if moneys_size == 1

    max_robbed_amounts = Array.new(moneys_size, 0)
    max_robbed_amounts[0] = moneys[0]
    max_robbed_amounts[1] = [moneys[0], moneys[1]].max
    (2...moneys_size).each do |i|
        max_robbed_amounts[i] = [max_robbed_amounts[i - 1], max_robbed_amounts[i - 2] + moneys[i]].max
    end
   max_robbed_amounts.last
end
```
