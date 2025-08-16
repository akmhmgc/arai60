## step2 他の方の解答を見る
### https://github.com/canisterism/leetcode/pull/2
フロイドの循環検出法を初めて知った。これを0から思いつくのは難しいが、知っていて利用できることはエンジニアとしての常識の範囲に入るのだろうか。

https://ja.wikipedia.org/wiki/%E3%83%95%E3%83%AD%E3%82%A4%E3%83%89%E3%81%AE%E5%BE%AA%E7%92%B0%E6%A4%9C%E5%87%BA%E6%B3%95 を見て、なぜこれが成り立つのかを理解した。
サイクルの有無だけではなくどこからサイクルか始まるも特定出来るのか。
巡回部分に入った時にそれぞれのインデックスが最も離れていたとしても、１ステップで１ずつ距離が近づくなるので、そこから最大でもサイクルのノードの数だけステップを進めれば出会うことになる。なのでトータルで最大で非連結部分のノード数+連結部分のノード数のステップで計算が終わる。

もし空間計算量の制限があれば、フロイドの循環検出法を知らない相手にはこういった説明をした上で利用することになる。

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
# @return {Boolean}
def hasCycle(head)
    return false if head.nil? || head.next.nil?

    slow, fast = head, head
    while true
        return false if fast.nil? || fast.next.nil?

        slow = slow.next
        fast = fast.next.next
        return true if slow == fast
    end
end
```
