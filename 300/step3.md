# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[]} nums
# @return {Integer}
def length_of_lis(nums)
    return 0 if nums.empty?

    lis_sizes = Array.new(nums.size, 1)
    max_lis_size_before_index = ->(target_index) {
        max_size = 0
        target_index.times do |i|
            next unless nums[i] < nums[target_index]
            
            max_size = [max_size, lis_sizes[i]].max
        end
        max_size
    }

    1.upto(nums.size - 1).each do |i|
        lis_sizes[i] = max_lis_size_before_index.call(i) + 1
    end
    lis_sizes.max
end
```
