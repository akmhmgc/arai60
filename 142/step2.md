# step2 他の方の解答を見る
## https://github.com/pineappleYogurt/leetCode/pull/3
whileを二重にするんじゃなくてbreakで抜けるのは悪くないかも。
ただ、1個目のwhileの条件を変えずにやる場合、2個目のwhileの前にfastノードの判定が必要になる。

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
    while fast && fast.next
        slow = slow.next
        fast = fast.next.next
        break if slow == fast
    end

    return nil if fast.nil? || fast.next.nil?

    start = head
    collided = slow
    while start != collided
        start = start.next
        collided = collided.next
    end

    return start
end
```

- `while true` にしても読みやすさは大きく変わらないしコード量が減る
- 将来、処理の順番を変えるとコードが正しくなくなる
  - `return nil if fast.nil? || fast.next.nil?`を最後に移動すると正しくなくなる

という二点で個人的には以下の書き方の方が気に入っている。

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

