# step1 何も見ずに解く
## 解答
- 入力が既にソートされているので、ノードを削除してもソートされていることは変わらない
- 単方向リストはノードを削除する時に対象となるノードの前のノードが必要であることを思い出した
- ノードの値を保持するSet用意して、headからノードを見ていく。値がSetに含まれていればそのノードを削除していく
- 計算量
  - 時間計算量O(N)
  - 空間計算量O(N)
  - ノードの数は最大でも300なのでこの計算量で良い

6分 (Wrong Answer)
```ruby
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head
# @return {ListNode}
def delete_duplicates(head)
    return head if head.nil? || head.next.nil?

    prev = head
    current = head.next
    visited_values = Set.new([prev.val])

    while current
        if visited_values.include?(current.val)
            prev.next = current.next
        end
        visited_values.add(current.val)
        prev = prev.next
        current = current.next
    end

    head
end
```

ノードを削除した時に、prevのnextがcurrentのnextになるのでprevとcurrentの前後関係がおかしくなることに気づいて修正した。
また、元のコードはwhileの中でindex-1から処理を始めていたがindex-0から処理を進める方がシンプルなので修正した。

```ruby
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head
# @return {ListNode}
def delete_duplicates(head)
    return head if head.nil? || head.next.nil?

    prev = ListNode.new(nil, head)
    current = head
    visited_values = Set.new

    while current
        if visited_values.include?(current.val)
            prev.next = current.next
        else
            prev = prev.next
        end
        visited_values.add(current.val)
        current = current.next
    end

    head
end
```

次に、ソートされているので、prevとcurrentの値の重複を確認すれば抜け漏れなく削除すべきノードは判定できることに気がついた。
これで空間計算量はO(1)になるし、コードの複雑性は増していない。
ただ、ソートされた入力が期待されていることはメソッドの説明に書いた方がよいだろう。

```ruby
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end

# Input linked list must be sorted.
# @param {ListNode} head
# @return {ListNode}
def delete_duplicates(head)
    return head if head.nil? || head.next.nil?

    prev = ListNode.new(nil, head)
    current = head
    while current
        if current.val == prev.val
            prev.next = current.next
        else
            prev = prev.next
        end
        current = current.next
    end

    head
end
```

## 感想
初手でSetを使わない解法が浮かんでいて、トレードオフを考慮して最終的な解答をだせるとよかった。
