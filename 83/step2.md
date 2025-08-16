# step2 他の方の解答を見る
## https://github.com/atomina1/Arai60_review/pull/2
自分はポインタ2つ使って書いていたが、1でも良さそう。

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
    return head if head.nil?

    node = head
    while node && node.next
        if node.val == node.next.val
            node.next = node.next.next
        else
            node = node.next
        end
    end

    head
end
```

while前でノードがnilになる場合は弾かれているし、whileの中の処理でノードがnilになることはないのでwhileの条件が修正できることに気づいた。

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
    return head if head.nil?

    node = head
    while node.next
        if node.val == node.next.val
            node.next = node.next.next
        else
            node = node.next
        end
    end

    head
end
```
