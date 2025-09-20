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
# @param {Integer[]} preorder
# @param {Integer[]} inorder
# @return {TreeNode}
def build_tree(preorder, inorder)
    inorder_val_to_index = {}
    inorder.each_with_index do |val, i|
        inorder_val_to_index[val] = i
    end

    build_tree_helper = -> (left_index, right_index, preorder_root_index) {
        return unless left_index < right_index

        root_val = preorder[preorder_root_index]
        root = TreeNode.new(root_val)
        inorder_split_index = inorder_val_to_index[root_val]
        root.left = build_tree_helper.call(left_index, inorder_split_index, preorder_root_index + 1)
        root.right = build_tree_helper.call(inorder_split_index + 1, right_index, preorder_root_index + (inorder_split_index - left_index) + 1)
        root
    }
    build_tree_helper.call(0, preorder.size, 0)
end
```
