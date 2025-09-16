# step2 他の方の解答を見る
## DFSのlevelの拡張方法

https://github.com/hayashi-ay/leetcode/pull/32/files#diff-f64e64b98ee3e79b1af4864eb48c186566221d5e613381a9102b5069412dd01eR76

> 「level が大きくて nodes_ordered_by_level が足りない場合、足りるように拡張します。そして、拡張した場所に書き込みます。」(読んでいくと、あとから、足りないことがあったとしても1段であることが他のところから分かる。)
「level が大きくて nodes_ordered_by_level が足りない場合、1段だけ拡張します。そして、level 番目に書き込みます。(書き込めなかったら IndexError が投げられます。)」(読んでいくと、1段だけしか拡張しなくても、level 番目が準備されているので例外はないことが分かる。)
というふうに読めます。どっちが読み手にとっていいですか。

とても納得するが、コードを書く時に意識するまでにはまだ距離があると感じた。

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

        level_order << [] while level_order.size <= depth
        level_order[depth] << node.val
        level_order_helper.call(node.left, depth + 1, level_order)
        level_order_helper.call(node.right, depth + 1, level_order)
        level_order
    }
    level_order_helper.call(root, 0, [])
end
```
