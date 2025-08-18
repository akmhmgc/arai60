## step4 レビューを受けて解答を修正

dummy_headを利用せずに解答する。
先頭の数字が連続するパターンはheadの位置を移動する必要がある。
headの位置が確定すればあとはstep3と同じように進めれば良い。

(Wrong Answer)
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
    while head && head.next && head.val == head.next.val
        duplicated_value = head.val
        while head && head.val == duplicated_value
            head = head.next
        end
    end
    
    unique = head
    node = head.next
    
    while node
        if node.next.nil?
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

    head
end
```

headがnilになる場合の考慮が漏れていた。

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
    while head && head.next && head.val == head.next.val
        duplicated_value = head.val
        while head && head.val == duplicated_value
            head = head.next
        end
    end

    return head if head.nil?

    unique = head
    node = head.next

    while node
        if node.next.nil?
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

    head
end
```

> dummy_head と node だけを使って同様の処理を書くことはできますか？
https://github.com/akmhmgc/arai60/pull/4/files#r2282076223

上のコメントをいただいたの書いた。

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
    while head && head.next && head.val == head.next.val
        duplicated_value = head.val
        while head && head.val == duplicated_value
            head = head.next
        end
    end

    return nil if head.nil?

    dummy_head = ListNode.new(Float::INFINITY, head)
    node = head.next

    while node
        break if node.next.nil?

        if node.val == node.next.val
            duplicated_value = node.val
            while node && node.val == duplicated_value
                node = node.next
            end
            head.next = node
            next
        end

        head.next = node
        head = head.next
        node = node.next
    end

    dummy_head.next
end
```

> dummy_head と node だけを定義し、 node だけを動かして、同様の処理を書くことはできますか？
https://github.com/akmhmgc/arai60/pull/4#discussion_r2282167859 を受けて再度コードを書いた


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
    node = dummy_head

    while node && node.next && node.next.next
        if node.next.val == node.next.next.val
            duplicated_value = node.next.val
            while node && node.next && node.next.val == duplicated_value
                node.next = node.next.next
            end
            next
        end

        node = node.next
    end

    dummy_head.next
end
```
