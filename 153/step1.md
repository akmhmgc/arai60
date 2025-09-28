# step1 何も見ずに解く
left,rightをそれぞれ配列の先頭、末尾を指すインデックスとする。
leftの値よりもrightの値の方が大きければ昇順に並んでいるのでleftの値を返す。

middle = (left + right) / 2とする
middleの値が
leftの値以上である場合、middleの値を含む左側には最小値より大きい値しかない。なのでleftをmiddle + 1として更新する。
（最小値**以上**ではない理由は、先に昇順に並んでいる場合を処理しているため。）
leftの値よりも小さい場合、middleの値を含む右側には最小値以上の値しかない。なので、rightをmiddleとして更新する。

なんかやけに複雑な気がするけど、しばらく考えて切り上げた。
```ruby
# @param {Integer[]} nums
# @return {Integer}
def find_min(nums)
  left = 0
  right = nums.length - 1

  while left < right
    return nums[left] if nums[left] < nums[right]

    middle = (left + right) / 2
    if nums[middle] >= nums[left]
      left = middle + 1
    else
      right = middle
    end
  end

  nums[left]
end
```
