# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search(nums, target)
    left = 0
    right = nums.size - 1
    while left < right
        mid = (left + right) / 2
        if nums[mid] <= nums[right]
            if nums[mid + 1] <= target && target <= nums[right]
                left = mid + 1
            else
                right = mid
            end
        else
            if nums[left] <= target && target <= nums[mid]
                right = mid
            else
                left = mid + 1
            end
        end
    end
    not_existed = -1
    nums[left] == target ? left : not_existed
end
```
