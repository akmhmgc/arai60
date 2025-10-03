# step2 他の方の解答を見る
## より簡潔に書く
https://github.com/tokuhirat/LeetCode/pull/46/
0 -> 01
1 -> 10
と子が作られるとすると、左の子であれば親から反転しないし、右側の子であれば反転することを利用する。

```ruby
# @param {Integer} n
# @param {Integer} k
# @return {Integer}
def kth_grammar(n, k)
    return -1 if n <= 0 || k <= 0 || k > 2 ** (n - 1) # 不正な値は-1を返す
    return 0 if n == 1 && k == 1

    result = kth_grammar(n - 1, (k + 1) / 2)
    result^= 1 if k.even?
    result
end
```

## 再帰を使わずにループで書く
rootに辿りつくまでに何回反転したかを考える

```ruby
# @param {Integer} n
# @param {Integer} k
# @return {Integer}
def kth_grammar(n, k)
    return -1 if n <= 0 || k <= 0 || k > 2 ** (n - 1) # 不正な値は-1を返す

    flips = 0
    col = k
    while col > 1
      flips^= 1 if col.even?
      col = (col + 1) >> 1
    end
    flips
end
```
