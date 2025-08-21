# step1 何も見ずに解く
値が0の計算結果用のノードを用意して、ポインター(node)を用意する。

与えられた二つのノードを前から見ていき、それぞれのノードの値とnodeの値の合計が10を超えればnodeの値を下一桁の値に置き換えてnodeの次に1の値を持つノードを追加する。
合計が10より小さい場合はnodeの値を合計の値に置き換える。という処理を繰り返す。
与えられたノードの片方が最後尾までいった場合、加算する値は0とする。

時間計算量はO(N)で空間計算量はO(1)
データサイズは最大100なので時間計算量はO(N)で良いだろう。

解答時間: 7:32(Wrong Answer)
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

    node1 = head1
    node2 = head2

    while node1 || node2
        if node.nil?
            node.next = ListNode.new(0, nil)
            node = node.next
        end

        sum = node.val + node1.val.to_i + node2.val.to_i
        ten_digit, one_digit = sum.divmod(10)

        if ten_digit == 1
            node.next = ListNode.new(1, nil)
        end

        node.val+= one_digit

        node = node.next
        node1 = node1.next if node1
        node2 = node2.next if node2
    end

    head
end
```

次のループ処理に移動する前に必要に応じて値が0の新規ノードを先頭に追加する必要があるのだが、
ループ処理の最後に追加すると必要のない0の値を持つノードが作られるのでループの先頭で追加しよう、と思って先頭に持ってきたがnodeがnilの場合を考慮できておらずエラーになった。


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

    node1 = head1
    node2 = head2

    while node1 || node2
        sum = node.val
        sum+= node1.val if node1
        sum+= node2.val if node2
        ten_digit, one_digit = sum.divmod(10)

        if ten_digit == 1
            node.next = ListNode.new(1, nil)
        end
        node.val = one_digit

        node1 = node1.next if node1
        node2 = node2.next if node2

        if node1 || node2
            node.next = ListNode.new(0, nil) if node.next.nil?
            node = node.next
        end
    end

    head
end
```
