# step1 何も見ずに解く

## 上から下に配るDFS
まず素直にこのパターンを思いついた。
時間計算量はO(N)で、空間計算量はO(N)
ノードの最大数は2000なのでRubyでもstack overflowは起きないだろう。
この解法だと、マージした木の一部が元の木の一部を指しているので、マージ後の木を処理した時に元の木に影響が出る。
元のrootをそのまま使わずに、deep copyを作成して返せばなんとかなるが、そのためにメソッドを作成するとなるとコードが増える。

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
    return root1 if root2.nil?
    return root2 if root1.nil?

    merged_root = TreeNode.new(root1.val + root2.val, nil, nil)
    merged_root.left = merge_trees(root1.left, root2.left)
    merged_root.right = merge_trees(root1.right, root2.right)

    merged_root
end
```

## 下から上に登るDFS
次に、子ノードを組み立ててから親ノードを作るDFSを考えた。
元のTreeを再利用しないのでこっちの方が好み

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

    left = merge_trees(root1&.left, root2&.left)
    right = merge_trees(root1&.right, root2&.right)
    val = root1&.val.to_i + root2&.val.to_i
    TreeNode.new(val, left, right)
end
```

## BFS
DFSより明らかに複雑になるのはわかっていたが、書いてみた。
案の定ぐちゃぐちゃになって時間がかかったので切り上げた。
誰かのコードを読むことはあるかもしれないが、自分から進んで再帰処理を使わずにコードを書くことはなさそう。

(Wrong Answer)
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

    head = TreeNode.new(0, nil, nil)
    nodes = [head]
    nodes1 = [root1]
    nodes2 = [root2]
    while !nodes1.empty? || !nodes2.empty? do
        next_nodes = []
        next_nodes1 = []
        next_nodes2 = []
        [nodes1.size, nodes2.size].max.times do
            node = nodes.pop
            node1 = nodes1.pop
            node2 = nodes2.pop
            next_node_left = nil
            next_node_right = nil
            next if node1.nil? && node2.nil?

            if node1
                node.val += node1.val
                next_nodes1 << node1.left
                next_nodes1 << node1.right
                if node1.left
                    node.left = TreeNode.new(0, nil, nil)
                    next_node_left = node.left
                end
                if node1.right
                    node.right = TreeNode.new(0, nil, nil)
                    next_node_right = node.right
                end
            end
            if node2
                node.val += node2.val
                next_nodes2 << node2.left
                next_nodes2 << node2.right
                if node2.left
                    node.left = TreeNode.new(0, nil, nil)
                    next_node_left = node.left
                end
                if node2.right
                    node.right = TreeNode.new(0, nil, nil)
                    next_node_right = node.right
                end
            end
            next_nodes << next_node_left
            next_nodes << next_node_right
        end
        nodes = next_nodes
        nodes1 = next_nodes1
        nodes2 = next_nodes2
    end
    head
end
```
