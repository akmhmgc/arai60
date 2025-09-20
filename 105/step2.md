# step2 他の方の解答を見る

## 配列をsliceする方法
- https://github.com/olsen-blue/Arai60/pull/29

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
# @param {Integer[]} preorder
# @param {Integer[]} inorder
# @return {TreeNode}
def build_tree(preorder, inorder)
    return nil if preorder.empty? || inorder.empty?
    
    root_val = preorder.first
    root = TreeNode.new(root_val)
    root_value_index_in_inorder = inorder.index(root_val)
    root.left = build_tree(preorder[1..root_value_index_in_inorder], inorder[0...root_value_index_in_inorder])
    root.right = build_tree(preorder[(root_value_index_in_inorder + 1)..-1], inorder[(root_value_index_in_inorder + 1)..-1])
    root
end
```

完結に書けるが、時間計算量、空間計算量ともにO(N^2)になる。
