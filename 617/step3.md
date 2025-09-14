# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

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
# @param {TreeNode} root1
# @param {TreeNode} root2
# @return {TreeNode}
def merge_trees(root1, root2)
    return nil if root1.nil? && root2.nil?
    
    merged_root = TreeNode.new(root1&.val.to_i + root2&.val.to_i)
    merged_root.left = merge_trees(root1&.left, root2&.left)
    merged_root.right = merge_trees(root1&.right, root2&.right)
    merged_root
end
```
