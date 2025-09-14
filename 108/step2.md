# step2 他の方の解答を見る
## 配列のsliceを使わずにインデックスを渡す解法
- https://github.com/garunitule/coding_practice/pull/24/files#diff-f8c5b4d5721a9a3333f4c0bdd90cda4c0d48fe44f5167b7af1debde3013ac03bR147-R162


時間計算量はO(logN)で、Nの最大値が10^4なのでRubyだと1秒以内に間に合う。
空間計算量はO(logN)
それぞれ配列のスライスがないので改善されている。
メソッドに必要のない情報を渡さない点でこちらの方が好みかもしれない。
step1の時点で解法の選択肢として持ちたかった…

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
    sorted_array_to_bst_helper = ->(start_index, end_index){
        return nil if start_index > end_index

        middle_index = (end_index + start_index) / 2
        root = TreeNode.new(nums[middle_index])
        root.left = sorted_array_to_bst_helper.call(start_index , middle_index - 1)
        root.right = sorted_array_to_bst_helper.call(middle_index + 1, end_index)
        root
    }
    sorted_array_to_bst_helper.call(0, nums.size - 1)
end
```
