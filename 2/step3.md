# step3 3回続けて10分以内に書いてエラーを出さなければOKとする
再帰を使った書き方にする。

4:49
```ruby
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head1
# @param {ListNode} head2
# @return {ListNode}
def add_two_numbers(head1, head2)
    head = ListNode.new(0, nil)
    node = head
    add(node, head1, head2)

    head
end

def add(node, head1, head2)
    return if head1.nil? && head2.nil?

    sum = node.val
    if head1
        sum += head1.val
        head1 = head1.next
    end
    if head2
        sum += head2.val
        head2 = head2.next
    end

    one_digit = sum % 10
    ten_digit = sum / 10

    node.val = one_digit
    if head1 || head2 || ten_digit == 1
        node.next = ListNode.new(ten_digit, nil)
    end
    node = node.next
    add(node, head1, head2)
end
```

3:15
```ruby
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head1
# @param {ListNode} head2
# @return {ListNode}
def add_two_numbers(head1, head2)
    head = ListNode.new(0, nil)
    node = head
    add(node, head1, head2)

    head
end

def add(node, head1, head2)
    return if head1.nil? && head2.nil?

    sum = node.val
    if head1
        sum += head1.val
        head1 = head1.next
    end
    if head2
        sum += head2.val
        head2 = head2.next
    end
    
    one_digit = sum % 10
    node.val = one_digit

    ten_digit = sum / 10
    if head1 || head2 || ten_digit == 1
        node.next = ListNode.new(ten_digit, nil)
    end

    node = node.next
    add(node, head1, head2)
end
```

2:48
```ruby
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head1
# @param {ListNode} head2
# @return {ListNode}
def add_two_numbers(head1, head2)
    head = ListNode.new(0, nil)
    node = head
    add(node, head1, head2)
    
    head
end

def add(node, head1, head2)
    return if head1.nil? && head2.nil?
    
    sum = node.val
    if head1
        sum += head1.val
        head1 = head1.next
    end
    if head2
        sum += head2.val
        head2 = head2.next
    end

    one_digit = sum % 10
    node.val = one_digit
    
    ten_digit = sum / 10
    if head1 || head2 || ten_digit == 1
        node.next = ListNode.new(ten_digit, nil)
    end
    node = node.next
    add(node, head1, head2)
end
```
