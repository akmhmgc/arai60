# step2 他の方の解答を見る
- https://github.com/h1rosaka/arai60/pull/24/files#diff-8467ab6cc6ececb3404ca05d2600450ca5cada8cd06ac2add723c558b796275aR30-R36

## 下から上げるDFS

自分がstep1の前半やっていたのは上から配る方
ref: https://discord.com/channels/1084280443945353267/1227073733844406343/1236235351140339742

step1の後半が下から上げる方に近かったが、上の階の情報が必要なかった。

(元の考え)
1. 上のノードにいる人の階層を教えてもらって、「あなたが居る場所から最も深い階数を数えて」と頼まれる
2. 自分の階がなければ0を教える
3. 自分の階があれば少なくとも1階が答えの候補になる
4. 下の階の人がいれば1と同じ質問をして、+1した答えと候補を比べて深い方を採用する
5. 採用した答えを上の人に教える

(修正版)
1. 上の階の人から「あなたが居る場所から最も深い階数を数えて」と頼まれる
2. 自分の階がなければ0を教える
3. 自分の階があれば少なくとも1階が答えの候補になる
4. 下の階の人がいれば1と同じ質問をして、+1した答えと候補を比べて深い方を採用する
5. 採用した答えを上の人に教える


手順書を作るイメージだと以下のような感じ。

- 上の階には、自分を1とした最も深い階層を教えること
- 自分の階がなければ0が答えになる
- 下の階にこの手順書を複製して渡すこと
- 下の階から貰った答え + 1を比較して答えを出すこと


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
def max_depth(root)
    return 0 if root.nil?

    1 + [max_depth(root.left), max_depth(root.right)].max
end
```

stackを使って実装すると以下のようになる

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
  return 0 if root.nil?

  stack = [[root, false]]
  node_to_depth = {}

  while !stack.empty?
    node, visited = stack.pop

    if node.nil?
      next
    end

    if visited
      left_depth = node_to_depth[node.left] || 0
      right_depth = node_to_depth[node.right] || 0
      node_to_depth[node] = [left_depth, right_depth].max + 1
      next
    end

    stack << [node, true]
    stack << [node.right, false]
    stack << [node.left, false]
  end

  node_to_depth[root]
end
```

より再帰の流れを模倣すると以下のような感じになる

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
def max_depth(root)
  result_ref = [nil]

  stack = [[root, result_ref, [nil], [nil]]]

  while !stack.empty?
    node, depth_ref, left_depth_ref, right_depth_ref = stack.last

    if node.nil?
      depth_ref[0] = 0
      stack.pop
      next
    end

    if left_depth_ref[0] && right_depth_ref[0]
        depth_ref[0] = [left_depth_ref[0], right_depth_ref[0]].max + 1
        stack.pop
        next
    end

    stack << [node.left, left_depth_ref, [nil], [nil]]
    stack << [node.right, right_depth_ref, [nil], [nil]]
  end

  result_ref[0]
end
```

これは書くのがかなり難しかった。

## 上から配るDFS

step1の前半も手順書を作ると以下のようになる

- 上の階には、最も深い階層を教えること
- 自分の階がなければ上の階が答えになる
- 下の階には、この手順書と自分の階を教えること
- 下の階から貰った答え同士を比較して答えを出すこと

手順書を詳しく作るとstep1で冗長なことをしていることに気づいた。`node.left``node.right`の存在確認をする必要がない。
修正

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
def max_depth(root)
    max_depth_helper = ->(node, parent_depth) {
        return parent_depth if node.nil?

        [max_depth_helper.call(node.left, parent_depth + 1), max_depth_helper.call(node.right, parent_depth + 1)].max
    }
    max_depth_helper.call(root, 0)
end
```

stackを使って実装すると以下のようになる

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
def max_depth(root)
    return 0 if root.nil?

    node_and_depth = [[root, 1]]
    max_depth = 1
    while !node_and_depth.empty?
        node, depth = node_and_depth.pop
        max_depth = [max_depth, depth].max
        node_and_depth << [node.left, depth + 1] if node.left
        node_and_depth << [node.right, depth + 1] if node.right
    end
    max_depth
end
```
