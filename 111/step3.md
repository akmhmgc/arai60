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
# @return {Integer}
def min_depth(root)
    return 0 if root.nil?

    nodes = [root]
    depth = 0
    while !nodes.empty?
        depth += 1
        next_nodes = []
        nodes.size.times do
            node = nodes.pop
            return depth if !node.left && !node.right
            next_nodes << node.left if node.left
            next_nodes << node.right if node.right
        end
        nodes = next_nodes
    end
    depth
end
```
