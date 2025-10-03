# step2 他の方の解答を見る

https://github.com/TORUS0818/leetcode/pull/47

step1の再帰の方法であったとしても、子ノードが一つしか生まれないようにすればメモ化が必要なくなるのか。
exponentが偶数のときは、exponentを半分に減らせて子ノードは1つしかできない。
奇数のときは次のノードのexponentが偶数になるようにすれば良い。

```ruby
# @param {Float} base
# @param {Integer} exponent
# @return {Float}
def my_pow(base, exponent)
  return 1 if exponent.zero?
  return 1.0 / my_pow(base, - exponent) if exponent < 0

  if exponent.even?
      return my_pow(base, exponent / 2) ** 2
  else
      return base * my_pow(base, exponent - 1)
  end
end
```

こっちはもちろんノードが二つになるので以下だと時間以内に解けない

```ruby
# @param {Float} base
# @param {Integer} exponent
# @return {Float}
def my_pow(base, exponent)
  return 1 if exponent.zero?
  return 1.0 / my_pow(base, - exponent) if exponent < 0

  if exponent.even?
      # ノードが二つになる
      return my_pow(base, exponent / 2) * my_pow(base, exponent / 2)
  else
      return base * my_pow(base, exponent - 1)
  end
end
```

https://github.com/TORUS0818/leetcode/pull/47#discussion_r2038337006
確かに bit を 1 にして左にシフトしていくことで捜査する方が自然

```ruby
# @param {Float} base
# @param {Integer} exponent
# @return {Float}
def my_pow(base, exponent)
    return 1 if exponent == 0

    if exponent < 0
        base = 1.0 / base
        exponent = - exponent
    end
    pow = 1
    current_base = base
    bit = 1
    while bit <= exponent
        pow *= current_base if (exponent & bit) != 0
        current_base *= current_base
        bit <<= 1
    end
    pow
end
```
