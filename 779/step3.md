# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer} n
# @param {Integer} k
# @return {Integer}
def kth_grammar(n, k)
    return -1 if n < 1 || k < 1 || k > 2 ** (n - 1) # 不正な値

    flips = 0
    col = k
    while col > 1
        flips^= 1 if k.even?
        col = (col + 1) >> 1
    end
    flips
end
```
