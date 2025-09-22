# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[]} nums
# @return {Integer}
def max_sub_array(nums)
    return 0 if nums.empty?

    max_sub_array_sum = -Float::INFINITY
    prefix_sum = 0
    min_prefix_sum = 0
    nums.each do |num|
        prefix_sum += num
        max_sub_array_sum = [max_sub_array_sum, prefix_sum - min_prefix_sum].max
        min_prefix_sum = [min_prefix_sum, prefix_sum].min
    end
    max_sub_array_sum
end
```
