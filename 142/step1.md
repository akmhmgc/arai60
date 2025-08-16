# step1 何も見ずに解く
## 解答
- `Do not modify the linked list.`という制約の有無で解き方は変わらないのでは…？
- 既に辿ったノードをSetで管理しながらheadから順に見ていけばよい
- 計算量
  - 時間計算量はO(N)
  - 空間計算量O(N)
- データサイズは最大で10^4なので時間計算量はO(N)で良い。また空間計算量もO(N)で十分小さいし、エンジニアの常識ではないフロイドの循環検出法を利用する必要はないと考えた

解答時間: 2分程度
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
    node = head
    visited_nodes = Set.new

    while node
        return node if visited_nodes.include?(node)
        
        visited_nodes.add(node)
        node = node.next
    end
    
    return nil
end
```

次は、フロイドの循環検出法で解いてみる。
https://github.com/akmhmgc/arai60/pull/1 で141を解いた時にサイクルの始点を求められることを調べていたのでそれを利用する。
slow,fastで一致したノードのポインタとheadノードのポインタを1ずつ進めていって一致するノードがサイクルの始点となる。
フロイドの循環検出法に限らず、なんらかの理由で常識とされていない課題の解決方法を利用せざるを得ない場合はPR descriptionおよびコード上にコメントを書いてコードの読み手に共有することになるだろう。

- 計算量
  - 時間計算量はO(N)
  - 空間計算量O(1)

解答時間: 3分程度 (Wrong Answer)
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
        if slow == fast
            start = head
            collided = slow
            while true
                return start if start == collided

                start = start.next
                collided = collided.next
            end
        end

        slow = slow.next
        fast = fast.next.next
    end

    nil
end
```

一つ目のwhileの頭で`slow == fast`を比較したらいきなりtrueになる、と気づいて以下のように修正。
slowとfastが一致した後の処理に気を取られすぎていた。
修正してAccepted

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

        if slow == fast
            start = head
            collided = slow
            while true
                return start if start == collided

                start = start.next
                collided = collided.next
            end
        end
    end

    nil
end
```
