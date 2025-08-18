# step1 何も見ずに解く
1. headから順にノードをみていく。ノードと次のノードの値が同じであれば次のノードを削除する？
1. それだと消すべきノードが必ず一つ残ることなるのでダメ
1. 消すノードの値は保持する必要がありそう。Setを使う
1. 次のノードと次の次のノードの値が同じであれば削除対象に入れて、次のノードが削除対象であれば削除する
1. 最初のノードが削除対象の場合、分岐が増えるので番兵を使う
1. headを返してしまうと、もしノードの先頭が削除対象の場合headを返すと間違いになるな
1. 前から見ていくポインタとは別に、番兵のポインタを用意しておいて、最後のそのポインタのnextを返せばよいだろう

- 計算量
  - 時間計算量はO(N)
  - 空間計算量はO(1)

解答時間: 15分 (Wrong Answer)
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
    return head if head.nil? || head.next.nil?

    node = ListNode.new(nil, head)
    prev_head = node
    delete_nodes = Set.new

    while node.next.next
        if node.next.val == node.next.next.val
            delete_nodes.add(node.next.val)
        end

        if delete_nodes.include?(node.next.val)
            node.next = node.next.next
        else
            node = node.next
        end
    end

    return prev_head.next
end
```

whileの条件が`node.next.next`になってしまっており、最後の2つのノードの値が同じテストケースで失敗することに気づいた。

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
    return head if head.nil? || head.next.nil?

    node = ListNode.new(nil, head)
    prev_head = node
    delete_nodes = Set.new

    while node.next
        if node.next.next && node.next.val == node.next.next.val
            delete_nodes.add(node.next.val)
        end

        if delete_nodes.include?(node.next.val)
            node.next = node.next.next
        else
            node = node.next
        end
    end

    return prev_head.next
end
```

## 感想
なんか複雑な処理をやっている気がする。
