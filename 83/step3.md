# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

平均1.5分程度
```ruby
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end5
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
