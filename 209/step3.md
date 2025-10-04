# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer} target
# @param {Integer[]} nums
# @return {Integer}
def min_sub_array_len(target, nums)
    min_size = Float::INFINITY
    prefix_sum = 0
    left = 0
    nums.each_with_index do |num, right|
        while prefix_sum + num >= target
            min_size = [min_size, right - left + 1].min
            prefix_sum -= nums[left]
            left += 1
        end
        prefix_sum += num
    end
    min_size == Float::INFINITY ? 0 : min_size
end
```
