# step2 他の方の解答を見る
## 境界の命名
https://github.com/YukiMichishita/LeetCode/pull/8

境界を`min_val`, `max_val`と命名していたが、最小値、最大値ではない。
もしそうであればより小さいもの、大きいものに更新されていくので以下のような処理は違和感がある。

```ruby
[min_val, node.val].max
```

以下であれば下限が狭くなっているので違和感はない。

```ruby
[lower_bound, node.val].max
```

## 下限・上限の計算部分の修正
https://github.com/YukiMichishita/LeetCode/pull/8

lower_bound --- node.val --- upper_bound
となっているので、lower_boundとnode.valの間にnode.leftを含む全ての子ノードの値が含まれる
node.rightはnode.valとupper_boundの間になる。

なので修正すると以下のようになる。

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
# @return {Boolean}
def is_valid_bst(root)
    is_valid_bst_helper = ->(node, lower_bound, upper_bound) {
        return true if node.nil?

        return false if !(node.val > lower_bound && node.val < upper_bound)
        return is_valid_bst_helper.call(node.left, lower_bound, node.val) && is_valid_bst_helper.call(node.right, node.val, upper_bound)
    }
    is_valid_bst_helper.call(root, -Float::INFINITY, Float::INFINITY)
end
```

## in order traversal
一度ノードをしたから舐めて配列に入れた後にチェックする方法。

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
# @return {Boolean}
def is_valid_bst(root)
    in_order_sort = ->(node, in_order_values) {
        return if node.nil?

        in_order_sort.call(node.left, in_order_values)
        in_order_values << node.val
        in_order_sort.call(node.right, in_order_values)
        in_order_values
    }
    in_order_values = in_order_sort.call(root, [])
    prev_val = -Float::INFINITY
    in_order_values.each do |current_val|
        return false if !(prev_val < current_val)
        prev_val = current_val
    end
    true
end
```
