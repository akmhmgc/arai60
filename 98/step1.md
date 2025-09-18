# step1 何も見ずに解く
## DFS
最大値と最小値を教えて貰い、「自分を含むノードの値全てが範囲に収まるか？」を上司に回答する

1. 自分が最大値と最小値に収まるかをチェックする
2. 左の部下には、自分の値より下 & 最大値より下 & 最小値より上かを質問する。つまり、最大値を自分の値と今の最大値の小さい方に更新して、上司からの質問と同じ質問を行う
3. 右の部下には、自分の値より上 & 最小値より上 & 最大値より下かを質問する。つまり、最小値を自分の値と今の最小値の大きい方に更新して、上司からの質問と同じ質問を行う

時間計算量はO(N)で、ノードの数は最大で10^4なので1秒内に間に合う。
空間計算量はO(N)で、再帰の深さの最大は10^4なのでRubyのデフォルトだとstack overflowが起きそうなので設定変更が必要。

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
    is_valid_bst_helper = ->(node, min_val, max_val) {
        return true if node.nil?

        return false if !(node.val > min_val && node.val < max_val)
        return is_valid_bst_helper.call(node.left, min_val, [max_val, node.val].min) && is_valid_bst_helper.call(node.right, [min_val, node.val].max, max_val)
    }
    is_valid_bst_helper.call(root, -Float::INFINITY, Float::INFINITY)
end
```

## BFS
BFSでやる場合は最大値と最小値をもって更新していけば良さそう

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
    nodes = [[root, -Float::INFINITY, Float::INFINITY]]
    while !nodes.empty?
        next_nodes = []
        nodes.each do |node, min_val, max_val|
            next if node.nil?

            return false if !(node.val > min_val && node.val < max_val)
            next_nodes << [node.left, min_val, [max_val, node.val].min] if node.left
            next_nodes << [node.right, [min_val, node.val].max , max_val] if node.right
        end
        nodes = next_nodes
    end
    true
end
```
