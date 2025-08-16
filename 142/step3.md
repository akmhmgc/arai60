# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

平均約3分程度
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
# @return {ListNode}
def detectCycle(head)
    return nil if head.nil? || head.next.nil?

    slow = head
    fast = head
    while true
        return nil if fast.nil? || fast.next.nil?

        slow = slow.next
        fast = fast.next.next
        break if slow == fast
    end

    start = head
    collided = slow
    while start != collided
        start = start.next
        collided = collided.next
    end

    return start
end
```
