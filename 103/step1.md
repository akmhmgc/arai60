# step1 何も見ずに解く
## BFS
BFSが自然だと感じた。
時間計算量はO(N)で、空間計算量もO(N)
Nの最大が2000なので余裕で1秒以内に間に合う

`result_reversed`より良い名前がある気もするが思いつかなかった。
`node_reversed`とかだとtraverseするノードが逆順になると捉えられる気がするのでやめた。
他にはlevelが偶数か、奇数かみたいな命名を一瞬思いついた。
しかし階層が深くなるたびに逆転させた結果、levelが偶数だと逆転しているだけに過ぎないので、表現したい概念より遠ざかっている気がするのでやめた。

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

    results = []
    nodes = [root]
    result_reversed = false
    while !nodes.empty? do
        if result_reversed
            results << nodes.reverse.map(&:val)
        else
            results << nodes.map(&:val)
        end
        next_nodes = []
        nodes.each do |node|
            next if node.nil?

            next_nodes << node.left if node.left
            next_nodes << node.right if node.right
        end
        nodes = next_nodes
        result_reversed = !result_reversed
    end
    results
end
```

reverseしないで順番通り左からlevel毎に左からノードを詰めていって、後からreverseするという手もある。

## DFS
時間計算量はO(N)で、空間計算量もO(N)
Nの最大が2000なのでRubyであればstack overflowは起きない。

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

    zigzag_level_order_helper = ->(node, depth, result) {
        result << [] while result.size <= depth
        if depth.even?
            result[depth].append(node.val)
        else
            result[depth].unshift(node.val)
        end

        zigzag_level_order_helper.call(node.left, depth + 1, result) if node.left
        zigzag_level_order_helper.call(node.right, depth + 1, result) if node.right
        result
    }

    zigzag_level_order_helper.call(root, 0, [])
end
```
