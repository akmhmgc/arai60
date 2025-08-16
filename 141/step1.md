# step1 何も見ずに解く
## 解答
- posが配列の最後尾のノードが指すindexのことだと理解するのに少し時間がかかった
	- 現実では最後尾のノードが指すindexがわかっているということはサイクルの有無がわかるはずで、なぜposというinputがあるのか混乱した
- メソッド名は`hasCycle`ではなく`has_cycle?の方がrubyらしい
- 制約について
  - データサイズの上限は`10^4`
	- 時間の制約は問題文にはないが、LeetCode全体の制約とかあるのか？
        - ないので適当にsleepさせてtimeoutするかどうかを観測したところ、1 - 1.5の間の制約があるっぽい。今回のデータサイズであればO(N)で間に合うだろう
- NodeListのvalが2回出てきたらCycleがあると判断して良いのでは？と思ったけど、値が異なる制約はないからダメ
- 問題の制約を活かして先頭から10^4 + 1個目のノードがあればサイクルが存在すると判定できそう。しかし、入力のサイズに関わらずサイクルさえあれば10^4 + 1回計算するのはいくらサイズの上限があったとしても無駄だし、パズルっぽくて不自然な感じがするな…
- 計算量
	- 時間計算量はO(N)
	- 空間計算量O(1)

(Accepted)
解答時間: 20分
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
    current_node = head

    return false if current_node.nil?

    max_node_length = 10 ** 4
    max_node_length.times do
        current_node = current_node.next
        return false if current_node.nil?
    end

    return true
end
```

解いた後に以下を考えた。

> NodeListのvalが2回出てきたらCycleがあると判断して良いのでは？と思ったけど、値が異なる制約はないからダメ

こちらの方針がより自然で、valueではなくて同じNodeが2回出てきたらCycleがあると判断すれば良いことに気づいた。
なぜvalではなくすでに見たノードを管理して、ノード同士を比較することを最初に思いつかなかったんだろうか？

すでに見たノードをSetで管理すれば、含まれているかどうかの確認がO(1)で出来る。
今回のデータサイズではArrayでも十分間に合うが、Setを使ってもコードは複雑にならないのでよさそう。
Setはruby 3.2より前はSetは標準ライブラリではなかったけど、許容範囲な気がする。

- 計算量
	- 時間計算量はO(N)
	- 空間計算量O(N)

(Accepted)
解答時間: 3分
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
    current_node = head
    return false if current_node.nil?

    visited_nodes = Set.new
    visited_nodes.add(current_node)

    while true
        current_node = current_node.next
        return false if current_node.nil?

        return true if visited_nodes.include?(current_node)
        visited_nodes.add(current_node)
    end
end
```

## 感想
- 以前使っていたのと、小さいコードを書くときの書き味が気に入っているのでrubyを使ったが、例が少ないので次からは普段それなりに書いているJavaかPythonにするかも
- rubyのSetはどういうハッシュ関数を使っていて、ハッシュが衝突した時にはどういう戦略をとっているのか気になった
- そういえばrubyは定数をメソッド内で定義するとエラーになった気がしたけど、本当にそうだっけ？
    - やはりエラーになった

```
def sample
  CONST_VALUE = 42
  puts "The constant value is: #{CONST_VALUE}"
end

sample
=>
dynamic constant assignment
> 1  def sample
> 4  end

sample.rb:2: dynamic constant assignment (SyntaxError)
  CONST_VALUE = 42
  ^~~~~~~~~~~
```

