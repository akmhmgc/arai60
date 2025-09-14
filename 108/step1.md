# step1 何も見ずに解く
## 上から配るDFS
配列の真ん中の値を取ってノードを作る。
真ん中の右側の配列にも同じ作業をしてノードの右側につなげる
真ん中の左側の配列にも同じ作業をしてノードの左側につなげる

という感じの再帰で解けると考えた。

時間計算量はO(NlogN)で、Nの最大値が10^4なのでRubyだと1秒以内に間に合う。
空間計算量はO(N)
再帰の深さはlogNなのでRubyのデフォルトの設定でもstack overflowは起きないだろう。

```ruby
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {Integer[]} nums
# @return {TreeNode}
def sorted_array_to_bst(nums)
    return nil if nums.empty?

    size = nums.size
    mean_index = size / 2
    root = TreeNode.new(nums[mean_index])
    root.left = sorted_array_to_bst(nums[0...mean_index])
    root.right = sorted_array_to_bst(nums[(mean_index + 1)..-1])
    root
end
```

## 下から上に上げるDFS
こっちの書き方もできる。個人的にはどっちでもいいかな。

```ruby
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {Integer[]} nums
# @return {TreeNode}
def sorted_array_to_bst(nums)
    return nil if nums.empty?

    size = nums.size
    mean = size / 2
    left = sorted_array_to_bst(nums[0...mean])
    right = sorted_array_to_bst(nums[(mean + 1)..-1])
    TreeNode.new(nums[mean], left, right)
end
```
