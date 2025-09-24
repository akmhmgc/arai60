# step1 何も見ずに解く
House Robber Iのように考えると、
ある家まで見た時に盗める最大の金は
「①１つ前の家まで見た時に盗める最大の金」 or 「②２つ前の家まで見た時に盗める最大の金 + ある家で盗める金」
の大きい方と考えたいところだが、①は問題ないが、②だとnumsの先頭から金を盗んでいる場合だと家が隣になるので答えにならない。

となると、②を先頭からは金を奪っていない条件で、２つ前の家まで見た時に盗める最大の金 + ある家で盗める金
とすれば良い。

そうするとnumsの部分配列に関してHouse Robber Iと同様の考えを適用すれば良いことがわかる。
時間計算量はO(N)で空間計算量もO(N)
Nは最大で100なので1秒以内で余裕で間に合う。

配列のスライスではなくインデックスを渡す方法もあるが今回は配列をそのまま渡している。

```ruby
# @param {Integer[]} moneys
# @return {Integer}
def rob(moneys)
    moneys_size = moneys.size
    return 0 if moneys_size == 0
    return moneys.max if moneys_size <= 3

    [
        max_robbed_amount_in_line(moneys[0...(moneys_size - 1)]),
        max_robbed_amount_in_line(moneys[1...(moneys_size - 2)]) + moneys.last
    ].max
end

def max_robbed_amount_in_line(moneys)
    moneys_size = moneys.size
    return moneys.last if moneys_size == 1

    max_robbed_amounts = Array.new(moneys_size, 0)
    max_robbed_amounts[0] = moneys[0]
    max_robbed_amounts[1] = [moneys[0], moneys[1]].max

    (2...moneys_size).each do |i|
        max_robbed_amounts[i] = [max_robbed_amounts[i - 1], max_robbed_amounts[i - 2] + moneys[i]].max
    end
    max_robbed_amounts.last
end
```

