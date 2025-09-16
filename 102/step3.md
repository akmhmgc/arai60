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
def level_order(root)
    return [] if root.nil?

    result = []
    nodes = [root]
    while !nodes.empty? do
        result << nodes.map(&:val)
        next_nodes = []
        nodes.each do |node|
            next if node.nil?

            next_nodes << node.left if node.left
            next_nodes << node.right if node.right
        end
        nodes = next_nodes
    end
    result
end
```
