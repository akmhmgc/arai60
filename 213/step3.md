# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[]} moneys
# @return {Integer}
def rob(moneys)
    moneys_size = moneys.size
    return 0 if moneys_size == 0
    return moneys.first if moneys_size == 1

    [rob_in_line(moneys[0...(moneys_size - 1)]), rob_in_line(moneys[1...moneys_size])].max
end

def rob_in_line(moneys)
    max_robbed_amount = 0
    max_robbed_amount_one_last = 0
    max_robbed_amount_two_last = 0

    moneys.each do |money|
        max_robbed_amount = [max_robbed_amount_two_last + money, max_robbed_amount_one_last].max
        max_robbed_amount_one_last, max_robbed_amount_two_last = max_robbed_amount, max_robbed_amount_one_last
    end
    max_robbed_amount
end
```
