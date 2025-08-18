# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

1回目: 7:16
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

2回目: 5:25 (Wrong Answer)
nextが抜けていた。
最初は普通に｀if - else`で書いた後にnextに直すのが自分の思考の流れにあっていることに気づけた。

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
        end

        unique.next = node
        unique = unique.next
        node = node.next
    end

    dummy_head.next
end
```

3回目: 3:35
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
            while node &&  node.val == duplicated_value
                node = node.next
            end
            unique.next = node
            next
        end

        unique.next = node
        unique = unique.next
        node = node.next
    end
```

4回目: 3:20
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

5回目: 2:43
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
```
