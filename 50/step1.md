# step1 何も見ずに解く

普通に計算しようと思ったが、n の最大が 2^31 - 1 なので線形時間だと 1 秒以内に間に合わない。

```ruby
# @param {Float} x
# @param {Integer} n
# @return {Float}
def my_pow(x, n)
    res = 1
    n.abs.times do
        if n < 0
            res /= x
        else
            res *= x
        end
    end
    res
end
```

再帰とメモ化で n を半分ずつに分けて計算すれば O(logN)に計算量を落とせるので間に合うのではないかと考えた。
空間計算量も O(logN)になる

```ruby
# @param {Float} base
# @param {Integer} exsp
# @return {Float}
def my_pow(base, exsp)
    exsp_to_pow = {}
    calculate_my_pow = lambda do |exsp|
        return 1 if exsp.zero?
        return base if exsp == 1
        return exsp_to_pow[exsp] if exsp_to_pow.key?(exsp)

        result = 1.0
        exsp_abs = exsp.abs
        if exsp_abs.even?
            exsp_left = exsp_right = exsp_abs / 2
        else
            exsp_left = exsp_abs / 2
            exsp_right = (exsp_abs + 1) / 2
        end
        if exsp >= 0
            result *= calculate_my_pow.call(exsp_left)
            result *= calculate_my_pow.call(exsp_right)
        else
            result /= calculate_my_pow.call(exsp_left)
            result /= calculate_my_pow.call(exsp_right)
        end
        exsp_to_pow[exsp] = result
        result
    end
    calculate_my_pow.call(exsp)
end
```

calculate_my_pow では`exsp`が正の場合だけ計算して、外で exsp が負であれば割るのも良いかも。
Ruby の冪乗を計算するための`Integer#**`メソッドも時間計算量 O(log)になっているか気になったのでコードを見た。
バイナリ法という方法で計算することにより、同じ値を計算する必要がないのでメモ化がいらない。
時間計算量は O(logN)
参考にすると以下のようになる。

```ruby
# @param {Float} base
# @param {Integer} exsp
# @return {Float}
def my_pow(base, exsp)
    return 1 if exsp == 0
    return base if exsp == 1

    exsp = exsp.abs
    power = 1
    current_base = base
    bit = exsp
    while bit > 0
        if (bit & 1) == 1
          power *= current_base
        end
        current_base *= current_base
        bit = bit >> 1
    end
    exsp < 0 ? 1 / power : power
end
```
