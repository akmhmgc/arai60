# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def next_permutation(nums)
    reverse = lambda do |left, right|
        while left < right
            nums[left], nums[right] = nums[right], nums[left]
            left += 1
            right -= 1
        end
    end
    rfind_first_ascending = lambda do
        (nums.size - 2).downto(0).each do |i|
            return i if nums[i] < nums[i + 1]
        end
        nil
    end
    rfind_first_greater_than = lambda do |target|
        (nums.size - 1).downto(0).each do |i|
            return i if nums[i] > target
        end
        nil
    end
    pivot_index = rfind_first_ascending.call
    if pivot_index.nil?
        nums.reverse!
        return
    end
    swap_index = rfind_first_greater_than.call(nums[pivot_index])
    nums[pivot_index], nums[swap_index] = nums[swap_index], nums[pivot_index]
    reverse.call(pivot_index + 1, nums.size - 1)
end
```
