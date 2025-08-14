## step3 3回続けて10分以内に書いてエラーを出さなければOKとする

平均1.5分程度で書けるようになった。
最後に相手を想定して口頭で説明しながら解いたが、「確実にループを抜けるのか？」は自分だったら疑問に思うので説明しておく必要があるだろう。

```ruby
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} head
# @return {Boolean}
def hasCycle(head)
    return false if head.nil? || head.next.nil?

    slow, fast = head, head
    while true
        return false if fast.nil? || fast.next.nil?

        slow = slow.next
        fast = fast.next.next
        return true if slow == fast
    end
end
```
