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
# @param {TreeNode} root
# @return {Boolean}
def is_valid_bst(root)
    is_valid_bst_helper = ->(node, lower_bound, upper_bound) {
        return true if node.nil?

        return false if !(node.val > lower_bound && node.val < upper_bound)
        is_valid_bst_helper.call(node.left, lower_bound, node.val) && is_valid_bst_helper.call(node.right, node.val, upper_bound)
    }
    is_valid_bst_helper.call(root, -Float::INFINITY, Float::INFINITY)
end
```
