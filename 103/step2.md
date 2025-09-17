# step2 他の方の解答を見る

- https://github.com/garunitule/coding_practice/pull/27/
 
> `result_reversed`より良い名前がある気もするが思いつかなかった。
`node_reversed`とかだとtraverseするノードが逆順になると捉えられる気がするのでやめた。

step1で上のように書いたが、resultに値を入れていく部分を捜査とすれば、捜査するノードが逆順になるので`is_reverse_traverse_order`とかの名前で違和感はない。
逆順にして突っ込むところをワンライナーで書いていたので捜査をイメージしきれてなかった。


- https://github.com/quinn-sasha/leetcode/pull/26/files#r2188598474

コピーを作らずにin-placeでやる方法

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
    traverse_order_reversed = false
    while !nodes.empty? do
        next_nodes = []
        nodes.each do |node|
            next if node.nil?

            next_nodes << node.left if node.left
            next_nodes << node.right if node.right
        end
        nodes.reverse! if traverse_order_reversed
        results << nodes.map(&:val)

        nodes = next_nodes
        traverse_order_reversed = !traverse_order_reversed
    end
    results
end
```
