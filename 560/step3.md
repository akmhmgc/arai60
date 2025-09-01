# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def subarray_sum(nums, k)
    result = 0
    prefix_sum = 0
    prefix_sum_to_count = Hash.new(0)
    prefix_sum_to_count[0] = 1
    nums.each do |num|
        prefix_sum += num
        result += prefix_sum_to_count[prefix_sum - k]
        prefix_sum_to_count[prefix_sum] += 1
    end

    result
end
```
