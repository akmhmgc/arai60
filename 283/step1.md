# step1 何も見ずに解く

以下を行うとよさそう
0,1の位置にそれぞれleft,rightをおく
- leftの位置に0がない時はそれぞれ1進める
- leftの位置に0がある時
  - rightの位置に0以外がある時は交換して、それぞれ1進める
  - rightの位置に0がある時はrightを1進める

時間計算量はO(N)で、空間計算量はO(1)
Nの最大値は10^4なので1秒以内に間に合う

```ruby
# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def move_zeroes(nums)
    return nums if nums.size <= 1

    left = 0
    (1...(nums.size)).each do |right|
        if !nums[left].zero?
            left += 1
            next
        end
        if !nums[right].zero?
            nums[left], nums[right] = nums[right], nums[left]
            left += 1
        end
    end
end
```
