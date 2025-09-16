# step1 何も見ずに解く
## BFS
BFSでそれぞれの階層ごとに答えに追加していけばよい。
時間計算量はO(N)でNの最大値は2000なので1秒以内に余裕で間に合う。
空間計算量はO(N)

(wrong answer)
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

    nodes = [root]
    result = []
    while !nodes.empty? do
        result << nodes.map(&:val)
        next_nodes = []
        nodes.size.times do
            node = nodes.pop
            next if node.nil?

            next_nodes << node.left if node.left
            next_nodes << node.right if node.right
        end
        nodes = next_nodes
    end
    result
end
```

popして順番がノードを処理する順番が逆だったのに気づいたので修正

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

    nodes = [root]
    result = []
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

## DFS
上から配るDFSもそこそこ簡単にかける。
時間計算量はO(N)で、空間計算量はO(N)
Rubyのデフォルト設定でもstack overflowは起きない。

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

    level_order_helper = ->(node, depth, level_order) {
        return if node.nil?

        level_order << [] if level_order[depth].nil?
        level_order[depth] << node.val
        level_order_helper.call(node.left, depth + 1, level_order)
        level_order_helper.call(node.right, depth + 1, level_order)
        level_order
    }
    level_order_helper.call(root, 0, [])
end
```
