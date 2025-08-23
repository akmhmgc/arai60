# step1 何も見ずに解く
スタックを使って、入力の前から値を入れていって、入れ終わったらスタックから値を取り出してLinkedListを作る方法
スタックを使わずに入力の前から値を見て、LinkedListのheadに追加していく方法
両方が思いついた。

入力サイズは最大でも5000なのでどちらにしても時間計算量はO(N)なので問題ない。
空間計算量はスタックを使う解法はO(N)、使わない解法はO(1)
メモリの制限はないが、読み手の認知負荷はスタックの方法と比べて高くはないのでスタックを使わない方法にした。


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
def reverse_list(head)
    reversed_head = nil
    node = head
    while node
        new_reversed_head = ListNode.new(node.val, nil)
        if reversed_head
            new_reversed_head.next = reversed_head
        end

        reversed_head = new_reversed_head
        node = node.next 
    end

    reversed_head
end
```

不要な場合分けがあったので修正した。

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
def reverse_list(head)
    reversed_head = nil
    node = head
    while node
        reversed_head = ListNode.new(node.val, reversed_head)
        node = node.next 
    end

    reversed_head
end
```

一応stackを使った解法も

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
def reverse_list(head)
    return nil if head.nil?

    node = head
    node_values = []
    while node
        node_values << node.val
        node = node.next
    end

    reversed_dummy_head = ListNode.new(Float::INFINITY, nil)
    reversed_node = reversed_dummy_head
    node_values.size.times do
        node_value = node_values.pop
        reversed_node.next = ListNode.new(node_value, nil)
        reversed_node = reversed_node.next
    end

    reversed_dummy_head.next
end
```

書く前に、ここまでコードが長くなるとは予想できてなかった。
スタック使う解き方をコードを書く前に整理しきってなかったのが原因かもしれない。
番兵を使わないと以下のようになる。

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
def reverse_list(head)
    return nil if head.nil?

    node = head
    node_values = []
    while node
        node_values << node.val
        node = node.next
    end

    node_value = node_values.pop
    reversed_head = ListNode.new(node_value, nil)
    reversed_node = reversed_head
    node_values.size.times do
        node_value = node_values.pop
        reversed_node.next = ListNode.new(node_value, nil)
        reversed_node = reversed_node.next
    end

    reversed_head
end
```
