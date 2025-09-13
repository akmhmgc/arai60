# step1 何も見ずに解く

## 下から上に上げるDFS

以下をイメージした

- 上司から「あなたを基準とした時の最も浅い階を教えて」と命令される
- 自分の階がない時は0を答える
- 自分の階がある時は
  - 部下が誰もいなければ1を答える
  - 部下が一人しかいない時は部下に同じ命令をして、返ってきたものを答える
  - 部下が複数いる時は全員に同じ命令をして、答えのうち一番小さいものに+1して答える

これは下から上に上げるDFS

Nの最大値は10^5
時間計算量はO(N)なので、1秒以内に間に合う
空間計算量はO(1)
再帰の深さは最大でNになる。Rubyのデフォルトの設定だと10^4程度の簡単な再帰処理でstack overflowを起こすのでスタック領域の設定を変更する必要がある。
これがシンプルで個人的には気に入った。

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

    return [min_depth(root.left), min_depth(root.right)].min + 1 if root.left && root.right
    return min_depth(root.left) + 1 if root.left
    return min_depth(root.right) + 1 if root.right
    1
end
```

stack & loopを使うと以下のようになる

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
    min_depth_ref = [nil]
    stack = [[root, min_depth_ref, [nil], [nil]]]

    while !stack.empty?
        node, depth_ref, left_depth_ref, right_depth_ref = stack.last
        
        if node.nil?
            depth_ref[0] = 0
            stack.pop
            next
        end

        if left_depth_ref[0].nil? || right_depth_ref[0].nil?
            stack << [node.left, left_depth_ref, [nil], [nil]]
            stack << [node.right, right_depth_ref, [nil], [nil]]
            next
        end

        if node.left && node.right
            depth_ref[0] = [left_depth_ref[0], right_depth_ref[0]].min + 1 
        elsif node.left
            depth_ref[0] = left_depth_ref[0] + 1
        elsif node.right
            depth_ref[0] = right_depth_ref[0] + 1
        else
            depth_ref[0] = 1
        end

        stack.pop
    end
    min_depth_ref[0]
end
```

## 上から下に配るDFS

次は上から配るDFSを試す

- 上司から「上司の階を教えるから最も浅い階を教えて」と命令されて
- 自分の階がない時は上司の階を答える
- 自分の階がある時は
  - 部下が誰もいなければ上司の階 + 1
  - 部下が一人しかいない時は部下に同じ命令をして、返ってきたものを答える
  - 部下が複数いる時は全員に同じ命令をして、答えのうち一番小さいものを答える

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
    min_depth_helper = -> (node, parent_depth) {
        return parent_depth if node.nil?

        depth = parent_depth + 1
        return [min_depth_helper.call(node.left, depth), min_depth_helper.call(node.right, depth)].min if node.left && node.right
        return min_depth_helper.call(node.left, depth) if node.left
        return min_depth_helper.call(node.right, depth) if node.right
        depth
    }
    min_depth_helper.call(root, 0)
end
```

こちらはstack & loopを使って実装もしてみる

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

    node_and_depth = [[root, 0]]
    result = Float::INFINITY
    while !node_and_depth.empty?
        node, depth = node_and_depth.pop
        result = [result, depth + 1].min if !node.left && !node.right

        node_and_depth << [node.left, depth + 1] if node.left
        node_and_depth << [node.right, depth + 1] if node.right
    end
    result
end
```

少し修正すると以下のようになる。こっちの方がいいかも

- 上司から「あなたの階を教えるから最も浅い階を教えて」と命令されて
- 自分の階がない時は上司の階を答える
- 自分の階がある時は
  - 部下が誰もいなければ自分の階
  - 部下が一人しかいない時は部下に同じ命令をして、返ってきたものを答える
  - 部下が複数いる時は全員に同じ命令をして、答えのうち一番小さいものを答える


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

        node_and_depth << [node.left, depth + 1] if node.left
        node_and_depth << [node.right, depth + 1] if node.right
    end
    result
end
```

## BFS
BFSも緒感的
慣れの問題か、BFSの場合はそんなに考えずに書ける気がする

時間計算量はO(N)
入力が平衡二分木の場合で、葉に到達したときにもっともqueueにデータが入るはず。個数はlogNなので空間計算量O(logN)

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
        next_nodes = []
        depth += 1
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

## どれが一番気に入ったか
自然言語でしっかり考えずにかけたので、おそらく読み手もそうなんだろうというこということでBFSを選んだ
あと枝刈り等の工夫をしなくても計算効率が良いという点もある
