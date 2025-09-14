# step1 何も見ずに解く
上司からrootから自分のノードまでの合計値を教えてもらって、target_sumに合致するpathがあるかどうかを返す
部下がいれば、部下に同じ質問をする。
どちらかの部下がYesと答えたら、上司に報告する

というイメージをして再帰で解いた。
時間計算量はO(N)、空間計算量もO(N)
Nは最大で5*10^3なので、1秒以内に間に合う。また、再帰の深さも最大で10^3でRubyのデフォルト設定でもstack overflowは起きない。

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
# @param {TreeNode} root
# @param {Integer} target_sum
# @return {Boolean}
def has_path_sum(root, target_sum)
    return false if root.nil?

    has_path_sum_helper = ->(node, sum) {
        return sum == target_sum if node && !node.left && !node.right

        result = false
        result ||= has_path_sum_helper.call(node.left, sum + node.left.val) if node.left
        result ||= has_path_sum_helper.call(node.right, sum + node.right.val) if node.right
        result
    }
    has_path_sum_helper.call(root, root.val)
end
```
