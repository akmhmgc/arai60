# step1 何も見ずに解く
最初はそれぞれの家で盗む・盗まないを決めて全ての金額を総当たりで計算する方法が思いついたが、Nの最大値が100なのでO(2^N)で間に合わない。

簡単な例を書き出して考えると、ある家まで見た時に盗める金の最大値は、
１つ前の家まで見た時に盗める金の最大値 or ２つ前の家まで見た時に盗める金の最大値 の大きい方
になる。
これだと時間計算量がO(N)で済むので1秒以内に余裕で間に合う
空間計算量も同様にO(N)
配列を使わなければ空間計算量はO(1)にできる。

入力が`nums`だったので`moneys`に変更した。

```ruby
# @param {Integer[]} moneys
# @return {Integer}
def rob(moneys)
    moneys_size = moneys.size
    return 0 if moneys_size.zero?
    return moneys.first if moneys_size == 1

    max_robbed_amount = Array.new(moneys_size, 0)
    max_robbed_amount[0] = moneys[0]
    max_robbed_amount[1] = [moneys[1], moneys[0]].max

    (2...moneys_size).each do |i|
        max_robbed_amount[i] = [max_robbed_amount[i - 1], max_robbed_amount[i - 2] + moneys[i]].max
    end
    max_robbed_amount.last
end
```

あとは再帰を使った解法もある。
メモ化を使わない場合、簡単な例でノードを書いてみたがざっくりO(2^n)になりそう。
フィボナッチ数列と同じになるな。

