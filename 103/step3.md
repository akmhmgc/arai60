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
# @return {Integer[][]}
def zigzag_level_order(root)
    return [] if root.nil?

    result = []
    nodes = [root]
    traverse_order_reversed = false
    while !nodes.empty?
        next_nodes = []
        nodes.each do |node|
            next_nodes << node.left if node.left
            next_nodes << node.right if node.right
        end
        nodes.reverse! if traverse_order_reversed
        result << nodes.map(&:val)

        nodes = next_nodes
        traverse_order_reversed = !traverse_order_reversed
    end
    result
end
```
