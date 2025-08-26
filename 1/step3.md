# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

平均 1:30
```ruby
# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
    nums_to_indexes = {}
    nums.each_with_index do |num, num_index|
        remain = target - num
        return [nums_to_indexes[remain], num_index] if nums_to_indexes[remain]

        nums_to_indexes[num] = num_index
    end

    [nil, nil]
end
```
