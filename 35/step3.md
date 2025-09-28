# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search_insert(nums, target)
    left = 0
    right = nums.size
    while left < right
        middle = (right + left) / 2
        if nums[middle] >= target
            right = middle
        else
            left = middle + 1
        end
    end
    right
end
```
