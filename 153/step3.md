# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[]} nums
# @return {Integer}
def find_min(nums)
    left = 0
    right = nums.size
    while left < right
        middle = (left + right) / 2
        if nums[middle] <= nums.last
            right = middle
        else
            left = middle + 1
        end
    end
    nums[left]
end
```
