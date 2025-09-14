# step2 他の方の解答を見る
## 上から下に配るDFSを非破壊で書く
> 非破壊のパターンですが、root1 == null等ですぐに戻さずに、以下のようにすればdeepCloneの実装をしなくてもいけます。
https://github.com/goto-untrapped/Arai60/pull/47/files/8757cd56cd9b23fcd4e33d9b5abfb38b26dfad39#r1730325260

>この発想の個人的な要点は、
今の実装でも両方あるときは非破壊的で、片方だけの時からは破壊的（というか既存のものを一部流用）になってしまう → 片方だけの時も下のフローに流せば非破壊的 → 下のフローに流すためにダミーを作ってしまえばOK
という感じでした。今回の場合は既に非破壊的（流用しない）パーツが出来上がっているので、あとはコードの自然な流れにつなげるにはどうするか、みたいな頭の使い方で導いています。

この発想はとてもわかりやすかった。
一部のフローだと元の木を流用してしまうことは理解できていので、考えを発展させて「どのフローでもノードを新しく作るにはどうすれば良いか？」という考えに至ることができると良さそう。
ダミーのTreeを作るのは手段であって、元の木を流用しないフローに流すことが目的なので以下のようにした。

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

    merged_root = TreeNode.new(root1&.val.to_i + root2&.val.to_i, nil, nil)
    merged_root.left = merge_trees(root1&.left, root2&.left)
    merged_root.right = merge_trees(root1&.right, root2&.right)

    merged_root
end
```
