# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def move_zeroes(nums)
    # leftより左には0以外の値がくる
    left = 0
    nums.size.times do |right|
        next if nums[right].zero?
        
        nums[left], nums[right] = nums[right], nums[left]
        left += 1
    end
end
```
