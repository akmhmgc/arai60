# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

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
def reverse_list(original_head)
    node = original_head
    reversed_head = nil
    while node
        reversed_head = ListNode.new(node.val, reversed_head)
        node = node.next
    end
    
    reversed_head
end
```
