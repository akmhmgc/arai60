# step2 他の方の解答を見る

## 再帰関数から特殊な処理を出す

- https://github.com/Mike0121/LeetCode/pull/11#discussion_r1594877766

確かに再帰関数の外側に出した方が意味としてわかりやすい。

下から上げる DFS の修正版

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
    min_depth_helper = ->(node){
        return [min_depth_helper.call(node.left), min_depth_helper.call(node.right)].min + 1 if node.left && node.right
        return min_depth_helper.call(node.left) + 1 if node.left
        return min_depth_helper.call(node.right) + 1 if node.right
        1
    }
    return 0 if root.nil?

    min_depth_helper.call(root)
end
```

上から下に配る DFS の修正版

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

    min_depth_helper = -> (node, depth) {
        if node.left && node.right
          return [min_depth_helper.call(node.left, depth + 1), min_depth_helper.call(node.right, depth + 1)].min
        end
        return min_depth_helper.call(node.left, depth + 1) if node.left
        return min_depth_helper.call(node.right, depth + 1) if node.right
        depth
    }

    min_depth_helper.call(root, 1)
end
```

## 枝刈り

- https://github.com/Mike0121/LeetCode/pull/11/files/f860146586f3c4ccd0dbb81fc0302b513862eeda#r1597468459

枝刈りを追加

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

    node_and_depth = [[root, 1]]
    result = Float::INFINITY
    while !node_and_depth.empty?
        node, depth = node_and_depth.pop
        result = [result, depth].min if !node.left && !node.right
        next if result <= depth

        node_and_depth << [node.left, depth + 1] if node.left
        node_and_depth << [node.right, depth + 1] if node.right
    end
    result
end
```
b
