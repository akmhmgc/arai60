# step1 何も見ずに解く
簡単な例を書いていくと、n行目のk番目の値はn - 1行目の(k + 1) / 2の値によってわかると気づく。
kは半分ずつ減るので時間計算量はO(logk)となる。kの最大値は2^(30 - 1)なので1秒以内に間に合う。
stackの深さは最大でも30なのでstack overflowは起きない。
空間計算量はO(n)

```ruby
# @param {Integer} n
# @param {Integer} k
# @return {Integer}
def kth_grammar(n, k)
    return -1 if n <= 0 || k <= 0 || k > 2 ** (n - 1) # 不正な値は-1を返す
    return 0 if n == 1 && k == 1

    if kth_grammar(n - 1, (k + 1) / 2).zero?
        if k.even?
            1
        else
            0
        end
    else
        if k.even?
            0
        else
            1
        end
    end
end
```
