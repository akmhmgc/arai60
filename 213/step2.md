# step2 他の方の解答を見る
## リストの分け方
https://github.com/h1rosaka/arai60/pull/38/files#diff-ce0cd96bb02b9d0f849c47d3ecac921373d9a9834854c70c62942f51d909f929R37-R39

最初を含まないリスト、最後を含まないリストに関して計算して、それぞれの最大値を競わせる。
こっちの方が書きやすいし読みやすい。

ついでに空間計算量O(1)で書いてみる。
あと、ループを0から始めることもできるので書いてみる。

```ruby
# @param {Integer[]} moneys
# @return {Integer}
def rob(moneys)
    moneys_size = moneys.size
    return 0 if moneys_size == 0
    return moneys.max if moneys_size <= 3

    [
        max_robbed_amount_in_line(moneys[0...(moneys_size - 1)]),
        max_robbed_amount_in_line(moneys[1...moneys_size])
    ].max
end

def max_robbed_amount_in_line(moneys)
    max_robbed_amount_two_last = 0
    max_robbed_amount_one_last = 0
    max_robbed_amount = 0

    moneys.each do |money|
        max_robbed_amount = [max_robbed_amount_one_last, max_robbed_amount_two_last + money].max
        max_robbed_amount_one_last, max_robbed_amount_two_last = max_robbed_amount, max_robbed_amount_one_last
    end
    max_robbed_amount
end
```

## ヘルパーメソッドの命名について
https://github.com/shintaro1993/arai60/pull/40/files#diff-b0cd43f46a2e0a4b323f085921c5e047630e92d6f24255ed62534e48d0f19ec4R114

元のメソッド名が`rob`で、円形に並んだ家から盗める最大値を返すことを期待している。
この命名が良いかどうかは置いておいて、変えられないものとして考えると、`rob_xxx`といった名前が良いかもしれない。
`rob_in_line`だと少し情報が少なすぎるか？


