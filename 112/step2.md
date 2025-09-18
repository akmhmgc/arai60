# step2 他の方の解答を見る
## 下から上に上がるDFS
https://github.com/rossy0213/leetcode/pull/14/

下から上にあがるDFSは以下のように考える。

上司から、残りの値を教えられて「合計が残りと一致する経路があるか？」と尋ねられる
上司の残りから自分のノードの値を引いて部下に同じ質問をする
自分が最後のノードであれば自分の値と残りの値が一致するかどうかを返す

こっちの方がシンプルかもしれないが、step1では思い浮かばなかった。
今まで解いてきた感じだと、思考の癖なのか下から上にあがるDFSが思い浮かびにくい気がする。

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
# @param {Integer} target_sum
# @return {Boolean}
def has_path_sum(root, target_sum)
    return false if root.nil?
    return root.val == target_sum if root.left.nil? && root.right.nil?

    has_path_sum(root.left, target_sum - root.val) || has_path_sum(root.right, target_sum - root.val)
end
```

stackでも実装してみる。
答が見つかったらreturnして枝刈りした。
もし下から上に上がるDFSを思いついていればこの実装もかなり自然に感じられた。

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
# @param {Integer} target_sum
# @return {Boolean}
def has_path_sum(root, target_sum)
    return false if root.nil?
    nodes = [[root, target_sum]]
    while !nodes.empty?
        node, remaining = nodes.pop
        next if node.nil?
        return true if !node.left && !node.right && remaining == node.val

        nodes << [node.left, remaining - node.val]
        nodes << [node.right, remaining - node.val]
    end
    false
end
```
