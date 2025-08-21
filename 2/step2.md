# step2 他の方の解答を見る
## https://github.com/kazukiii/leetcode/pull/6
番兵を使って次のノードに計算結果を書き込んでいく方法だと、step1で自分が気にしていた、最後に0が含まれるノードを追加してしまうのを回避できるな。
再帰で書く方法は検討していなかった。
再帰の考え方が苦手なんだけど、どう考えると自然なんだろうか。試しに簡単なフィボナッチ数の処理を書いてみたがおぼつかなかった。

1. 前の計算で繰り上げた値carry、二つの入力ノードの先頭(head1, head2)、計算結果を保存するノードの末端(node)を持つ
1. head1, head2から値を取り出してcarryに追加したものを計算する(sum)。値を取り出した後head1, head2を進める
1. sumの1の位の値を持ったノードをnodeに追加して、nodeを1つ進める
2. carryをsumの10の位に置き換える
3. 更新したcarry, head1, head2, nodeを使って1の処理を行う

上を繰り返す。
head1とhead2がnil、つまり両方のポインターが末端にたどり着いたら終了。
自然言語にするとあまり難しさは感じない。
Numeric#divmodは使っても使わなくてもどっちでも良いかもしれない。

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
# @param {ListNode} head1
# @param {ListNode} head2
# @return {ListNode}
def add_two_numbers(head1, head2)
    dummy_head = ListNode.new(Float::INFINITY, nil)
    node = dummy_head
    carry = 0
    add(node, carry, head1, head2)

    dummy_head.next
end

def add(node, carry, head1, head2)
    node1 = head1
    node2 = head2

    sum = carry
    if node1
        sum += node1.val
        node1 = node1.next
    end
    if node2
        sum += node2.val
        node2 = node2.next
    end

    carry = sum / 10
    node.next = ListNode.new(sum % 10, nil)
    node = node.next
    add(node, carry, node1, node2)
end
```

二つの値を計算した結果、桁が上がる場合でうまく計算ができていないことに気づいた。例えば、入力値の最大の桁が10桁だとして、合計が11桁になるケース。
また、headへのポインタを保持しておく必要はないのででわざわざ別の変数に入れる必要はない。

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
    dummy_head = ListNode.new(Float::INFINITY, nil)
    node = dummy_head
    carry = 0
    add(node, carry, head1, head2)

    dummy_head.next
end

def add(node, carry, head1, head2)
    return if head1.nil? && head2.nil? && carry.zero?
    
    sum = carry
    if head1
        sum += head1.val
        head1 = head1.next
    end
    if head2
        sum += head2.val
        head2 = head2.next
    end

    carry = sum / 10
    node.next = ListNode.new(sum % 10, nil)
    node = node.next
    add(node, carry, head1, head2)
end
```

次に番兵を使わずに解いてみる。

1. 二つの入力ノードの先頭(head1, head2)、計算結果を保存するノードの末端(node)を持つ
1. head1, head2から値を取り出してnodeの値に追加したものを計算する(sum)。値を取り出した後head1, head2を進める
1. sumの1の位の値でnodeのvalを更新する
1. nodeの次にsumの10の位の値を持つノードを追加して、nodeを次に進める
3. 更新したhead1, head2, nodeを使って1の処理を行う

> 4. nodeの次にsumの10の位の値を持つノードを追加して、nodeを次に進める

nodeの末端に不要な0がつくのを回避する必要がある

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
    if head1 || head2 || ten_digit != 0
        node.next = ListNode.new(ten_digit, nil)
    end
    node = node.next

    add(node, head1, head2)
end
```
