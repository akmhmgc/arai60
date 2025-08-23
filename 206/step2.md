# step2 他の方の解答を見る
## https://github.com/tarinaihitori/leetcode/pull/6
自分が作業をするときにどのような名前で変数を渡されるかという観点で命名を考えるのは分かりやすいと思った。

再帰で解いてみる。

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
    reversed_head = nil
    node = original_head
    reverse(reversed_head, node)
end

def reverse(reversed_head, node)
    return reversed_head if node.nil?

    next_node = node.next
    node.next = reversed_head
    reverse(node, next_node)
end
```

元のLinkedListを破壊しないのであれば以下のようになる。

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
    reversed_head = nil
    node = original_head
    reverse(reversed_head, node)
end

def reverse(reversed_head, node)
    return reversed_head if node.nil?

    new_reversed_head = ListNode.new(node.val, reversed_head)
    reverse(new_reversed_head, node.next)
end
```
