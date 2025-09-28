# step2 他の方の解答を見る

## 常に右端と比べる方法
https://github.com/sakupan102/arai60-practice/pull/43

これは非常にわかりやすい。
rightを含む右側が最小値以上で、leftより左側が最小値より大きい。
なので探索が終わった時点のleftおよびrightが最小値となる。

```ruby
# @param {Integer[]} nums
# @return {Integer}
def find_min(nums)
  left = 0
  right = nums.length

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

`Array#bsearch`を使うと以下のように

```ruby
# @param {Integer[]} nums
# @return {Integer}
def find_min(nums)
    nums.bsearch { |val| val <= nums.last }
end
```
