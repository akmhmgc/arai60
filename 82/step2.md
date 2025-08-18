# step2 他の方の解答を見る
## https://github.com/yus-yus/leetcode/pull/4
現在のノード(node)と重複していないノードを扱うためのポインタ(unique)を用意する
nodeと次のノードの値が同じ間、nodeを進める
uniqueとnodeを繋げることで重複するノードを全て削除することができる
この発想は思いつかなかったが、それなりに自然に感じた。

`prev_head`よりも`dummy_head`の方が自分で用意したノードであることがわかるので良い。
dummy_headに入れる値はnilよりも`Float::INFINITY`の方がよりあり得ない(=dummyとわかる)ので良いかもしれない。

個人的には、以下のように`if - else`ではなくnextで抜けると`duplicated_value = node.val`がなぜduplicateなのかがわかりづらくなる気がしている。
あれ、`node.val`がduplicateなのはなんでだっけ…？あ、`node.val != node.next.val`の条件が前にあるからここの処理は`node.val == node.next.val`が保証されてるのか…という感じ。

```ruby
def delete_duplicates(head)
    dummy_head = ListNode.new(Float::INFINITY, head)
    unique = dummy_head
    node = head

    while node
        if !node.next
            unique.next = node
            break
        end
        
        if node.val != node.next.val
            unique.next = node
            unique = unique.next
            node = node.next
            next
        end

        duplicated_value = node.val
        while node && node.val == duplicated_value
            node = node.next
        end
        unique.next = node
    end

    dummy_head.next
end
```

以下の二つどちらかが良いと考える。

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
    dummy_head = ListNode.new(Float::INFINITY, head)
    unique = dummy_head
    node = head

    while node
        if !node.next
            unique.next = node
            break
        end

        if node.val == node.next.val
            duplicated_value = node.val
            while node && node.val == duplicated_value
                node = node.next
            end
            unique.next = node
        else
            unique.next = node
            unique = unique.next
            node = node.next
        end
    end

    dummy_head.next
end
```

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
    dummy_head = ListNode.new(Float::INFINITY, head)
    unique = dummy_head
    node = head

    while node
        if !node.next
            unique.next = node
            break
        end

        if node.val == node.next.val
            duplicated_value = node.val
            while node && node.val == duplicated_value
                node = node.next
            end
            unique.next = node
            next
        end

        unique.next = node
        unique = unique.next
        node = node.next
    end

    dummy_head.next
end
```
