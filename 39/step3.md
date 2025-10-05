# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[]} candidates
# @param {Integer} target
# @return {Integer[][]}
def combination_sum(candidates, target)
    combinations = []
    combination_sum_helper = lambda do |index, total, partial_combination|
        if total == target
            combinations << partial_combination.dup
            return
        end
        (index...(candidates.size)).each do |next_index|
            new_total = total + candidates[next_index]
            next if new_total > target

            partial_combination << candidates[next_index]
            combination_sum_helper.call(next_index, new_total, partial_combination)
            partial_combination.pop
        end
    end
    combination_sum_helper.call(0, 0, [])
    combinations
end
```
