# step1 何も見ずに解く
幅優先探索で解ける。ノードのサイズの最大が10^4なので時間計算量はO(N)で十分1秒以内に間に合う。
配列に入るノードの数が最大になる場合は、depthが最も小さくなるようにノードが配置されている時の最下層。
1 + 2 + 2^2 + .... + 2^k = Nとなるときなので、空間計算量はO(log(N))となる。

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
    nodes = []
    nodes << root if root
    depth = 0
    while !nodes.empty?
        next_nodes = []
        depth += 1
        nodes.size.times do
            node = nodes.pop
            next_nodes << node.left if node.left
            next_nodes << node.right if node.right
        end
        nodes = next_nodes
    end
    depth
end
```

また、あるノードに到達するのに一つの経路しかないので深さ優先探索でも解けそう。
1. 上のノードにいる人の階層を教えてもらって、最も深い階数を教えるよう頼まれる
2. 自分の階がなければ教えてもらった階を教える。
3. 自分の階があれば少なくとも+1階が答えの候補になる
4. 下の階の人がいれば1と同じ質問をして、答えの候補と比べて深い方を採用
5. 採用した答えを上の人に教える

という感じ

時間計算量はO(N)で空間計算量はO(1)
stackの最大の深さはO(logN)なので、Rubyのデフォルトの設定であればStack overflowは起きない。

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

        current_depth = parent_depth + 1
        max_depth = current_depth
        max_depth = [max_depth, max_depth_helper.call(node.left, current_depth)].max if node.left
        max_depth = [max_depth, max_depth_helper.call(node.right, current_depth)].max if node.right
        [max_depth_helper.call(node.left, current_depth), max_depth_helper.call(node.right, current_depth)]
        max_depth
    }
    max_depth_helper.call(root, 0)
end
```

1. 上のノードにいる人の階層を教えてもらって、「あなたが居る場所から最も深い階数を教えて」と頼まれる
2. 自分の階がなければ0を教える
3. 自分の階があれば少なくとも1階が答えの候補になる
4. 下の階の人がいれば1と同じ質問をして、+1した答えと候補を比べて深い方を採用する
5. 採用した答えを上の人に教える

こういう発想もできるが、あまり直感的ではないと感じた


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
        return 0 if node.nil?

        max_depth = 1
        max_depth = [max_depth, max_depth_helper.call(node.left, parent_depth) + 1].max if node.left
        max_depth = [max_depth, max_depth_helper.call(node.right, parent_depth) + 1].max if node.right
        max_depth
    }
    max_depth_helper.call(root, 0)
end
```
